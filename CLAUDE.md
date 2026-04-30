# qml-hmi-navigator — CLAUDE.md

## プロジェクト概要
Qt 6 / QML による産業用HMIナビゲーターのポートフォリオ実装。
CHバーナー制御パネルで得た設計パターンをクリーンルーム再実装。
**ソース非公開のCH業務コードは `source/CH/`（読み取り専用・絶対に触らない）**

---

## ビルド

```powershell
# PATH設定（毎回必要）
$env:PATH = "D:\software\Qt\Tools\mingw1310_64\bin;D:\software\Qt\Tools\Ninja;D:\software\Qt\Tools\CMake_64\bin;" + $env:PATH

# configure（初回のみ）
cmake -S . -B build -G Ninja `
  -DCMAKE_PREFIX_PATH=D:\software\Qt\6.11.0\mingw_64 `
  -DCMAKE_CXX_COMPILER=D:\software\Qt\Tools\mingw1310_64\bin\g++.exe

# ビルド
cmake --build build

# 実行
$env:PATH = "D:\software\Qt\6.11.0\mingw_64\bin;" + $env:PATH
.\build\qml-hmi-navigator.exe
```

ビルド済みexeが起動中なら先に `Stop-Process -Name qml-hmi-navigator` する（Permission denied防止）。

---

## アーキテクチャ

```
NavigatorShell
├── NavHeader          ヘッダー（戻るボタン + パンくず + グローバルアイコン）
└── Loader（contentLoader）
    ├── MenuScreen     メニューノード（isIconGrid / Column / Grid 自動切替）
    ├── LeafScreenA    テスト・設定系リーフ（OnOffButton列）
    └── StatusLeafScreen ステータス系リーフ（ラベル+値+単位列）
```

ナビゲーション全体は `NavigationTree` singleton が管理。  
`isLeaf = menuModel.length === 0`

---

## デザインルール（ThemeObject準拠・CH ButtonParts基準）

| プロパティ | 値 |
|---|---|
| buttonWidth | 300px |
| buttonHeight | 60px |
| spacing | 15px |
| radius | 10px |
| fontSizeLarge | 28px（ボタンテキスト） |
| fontSizeTitle | 30px（パンくず） |
| fontSizeBase | 20px |
| fontSizeSmall | 16px |
| headerHeight | 70px |

コンテンツ領域: 480 - 70 = **410px**  
5項目上限検証: 5×60 + 4×15 = 360px < 410px ✓

### レイアウトルール
- 全コンポーネントのサイズ・spacing は `ThemeObject` 経由（ハードコード禁止）
- リーフ画面の Column: `width: parent.width - 80`（左右40pxマージン）
- `itemH = ThemeObject.buttonHeight + ThemeObject.spacing`
- `OnOffButton`: 幅は親から継承（`width: parent.width`）、ラベル幅=`parent.width - 120`

### レイアウト検証手順（スクショ不要）
修正後にコードから計算して確認する:
1. 合計高さ = N × buttonHeight + (N-1) × spacing
2. コンテンツ高さ410px内に収まるか
3. `anchors.fill: parent` の伝播チェック（特にLoader内のrootItem）

スクショが必要なケース: Canvas描画アイコン確認 / CHとのビジュアル比較のみ

---

## QML実装ルール

- **Singleton**: `pragma Singleton` だけでは不十分。`qmldir` に `singleton ThemeObject ThemeObject.qml` を手動記載必須（Qt 6.11 auto-detect 非動作）
- **シグナルハンドラー衝突**: プロパティ名を `on` + 大文字始まりにしない（例: `onPrimary` → NG、QMLがsignal handlerとして解析する）
- **QMLファイル配置**: モジュールルートに置く（サブディレクトリは qmldir 解決が崩れる）
- **PowerShellビルド出力**: `tail` は使えない → `Select-Object -Last N`

---

## Wasm対応（Phase 4）

- `patch-wasm-html.cmake`: POST_BUILDでHTMLパッチ
- CI: Qt 6.6.3 + emsdk 3.1.37
- ローカル: Qt 6.11.0 + emsdk 4.0.7
- **スケーリング既知問題**: CSS `transform: scale(N)` は Qt の ResizeObserver と競合してキャンバスが拡大される
  - 現状: `meta viewport width=800` + flexbox中央配置（1x固定）
  - 再挑戦時: `QT_SCALE_FACTOR` 環境変数 + ページロード時コンテナサイズ動的変更アプローチを検討

---

## ナビゲーションツリー（Main.qml定義）

```
root（ホーム）
├── status（ステータス）
│   ├── status_general → statusLeaf
│   ├── status_ope（menu）→ status_ope_1〜2（statusLeaf）
│   ├── status_detail（menu）→ status_detail_1〜16（statusLeaf、Grid）
│   ├── status_service（menu）→ status_service_1〜5（statusLeaf）
│   └── status_ver（menu）→ status_ver_1〜5（statusLeaf）
├── test（テスト）
│   ├── test_general（menu）→ test_general_1〜4（leaf）
│   ├── test_device（menu）→ test_device_1〜16（leaf、Grid）
│   └── test_func（menu）→ test_func_1〜8（leaf）
└── setting（設定）
    ├── setting_device（menu）→ setting_device_1〜3（leaf）
    ├── setting_model（menu）→ setting_model_1〜2（leaf）
    ├── setting_unit（menu）→ setting_unit_1〜2（leaf）
    └── setting_adjust（menu）→ setting_adjust_1〜3（leaf）
```

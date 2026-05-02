file(READ "${HTML_FILE}" content)

# viewport を 800px 固定に変更 → ブラウザが物理画面に合わせてスケール
# Qt は window.innerWidth=800 を見て 800x480 canvas を作る（resize 処理を触らない）
# 整数倍スケール: initial-scale を JS で動的設定
string(REPLACE
"<meta name=\"viewport\" content=\"width=device-width, height=device-height, user-scalable=0\"/>"
"<meta name=\"viewport\" id=\"vp\" content=\"width=800, initial-scale=1\"/>"
content "${content}")

# センタリング CSS (viewport=800 なので 100vw=800px → #screen がちょうど収まる)
string(REPLACE "</style>"
"      html, body { padding: 0; margin: 0; background: #1a1a1a; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; overflow: hidden; }
      #screen { width: 800px; height: 480px; flex-shrink: 0; }
    </style>" content "${content}")

# 整数スケール: screen サイズから initial-scale を計算して viewport に反映
# window.screen はブラウザの物理ピクセルサイズ (CSS ピクセルではない)
string(REPLACE "<script src=\"${APP_NAME}.js\">"
"<script src=\"coi-serviceworker.js\"></script>
    <script>
      (function() {
        var s = Math.max(1, Math.floor(Math.min(screen.width / 800, screen.height / 480)));
        document.getElementById('vp').content =
          'width=800, initial-scale=' + s + ', minimum-scale=' + s + ', maximum-scale=' + s;
      })();
    </script>
    <script src=\"${APP_NAME}.js\">"
content "${content}")

file(WRITE "${HTML_FILE}" "${content}")
message(STATUS "Patched ${HTML_FILE}")

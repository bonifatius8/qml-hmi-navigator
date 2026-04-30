import QtQuick
import HmiNavigator

Window {
    width: 800
    height: 480
    visible: true
    title: "qml-hmi-navigator"

    FontLoader { source: "qrc:/qt/qml/HmiNavigator/qml/fonts/migmix-2p-regular.ttf" }
    FontLoader { source: "qrc:/qt/qml/HmiNavigator/qml/fonts/migmix-2p-bold.ttf" }

    Component.onCompleted: {
        var menu       = "qrc:/qt/qml/HmiNavigator/qml/screens/MenuScreen.qml"
        var leaf       = "qrc:/qt/qml/HmiNavigator/qml/screens/LeafScreenA.qml"
        var statusLeaf = "qrc:/qt/qml/HmiNavigator/qml/screens/StatusLeafScreen.qml"

        // ── ノード定義 ──────────────────────────────
        NavigationTree.registerNode("root",           "",               "ホーム")

        // ステータス
        NavigationTree.registerNode("status",          "root",            "ステータス")
        NavigationTree.registerNode("status_general",  "status",          "動作状態")          // 直接leaf

        // デバイス運転状態（menu → leaf ×2: 各8台分）
        NavigationTree.registerNode("status_ope",      "status",          "デバイス運転状態")
        NavigationTree.registerRepeat("status_ope",    "status_ope",      "デバイス運転状態", {from: 1, to: 2})

        // デバイス詳細（menu → leaf ×16: Grid）
        NavigationTree.registerNode("status_detail",   "status",          "デバイス詳細")
        NavigationTree.registerRepeat("status_detail", "status_detail",   "デバイス", {from: 1, to: 16})

        // サービス（menu → leaf ×5）
        NavigationTree.registerNode("status_service",  "status",          "サービス")
        NavigationTree.registerRepeat("status_service","status_service",  "サービス", {from: 1, to: 5})

        // ソフトバージョン（menu → leaf ×5: IO版 + 4グループ）
        NavigationTree.registerNode("status_ver",      "status",          "ソフトバージョン")
        NavigationTree.registerRepeat("status_ver",    "status_ver",      "バージョン", {from: 1, to: 5})

        // テスト
        NavigationTree.registerNode("test",              "root",          "テスト")
        NavigationTree.registerNode("test_general",      "test",          "一般")
        NavigationTree.registerRepeat("test_general",    "test_general",  "一般", {from: 1, to: 4})
        NavigationTree.registerNode("test_device",       "test",          "デバイス")
        NavigationTree.registerRepeat("test_device",     "test_device",   "デバイス", {from: 1, to: 16})
        NavigationTree.registerNode("test_func",         "test",          "デバイス機能")
        NavigationTree.registerRepeat("test_func",       "test_func",     "デバイス機能", {from: 1, to: 8})

        // 設定（4項目、各々menu中間層を持つ）
        NavigationTree.registerNode("setting",               "root",            "設定")

        // デバイス有効無効（menu → leaf ×3）
        NavigationTree.registerNode("setting_device",        "setting",         "デバイス有効無効")
        NavigationTree.registerRepeat("setting_device",      "setting_device",  "デバイス", {from: 1, to: 3})

        // 型式・保存（menu → leaf ×2）
        NavigationTree.registerNode("setting_model",         "setting",         "型式・保存")
        NavigationTree.registerRepeat("setting_model",       "setting_model",   "型式", {from: 1, to: 2})

        // ユニット設定（menu → leaf ×2）
        NavigationTree.registerNode("setting_unit",          "setting",         "ユニット設定")
        NavigationTree.registerRepeat("setting_unit",        "setting_unit",    "ユニット設定", {from: 1, to: 2})

        // ユニット調整（menu → leaf ×3）
        NavigationTree.registerNode("setting_adjust",        "setting",         "ユニット調整")
        NavigationTree.registerRepeat("setting_adjust",      "setting_adjust",  "ユニット調整", {from: 1, to: 3})

        // ── 画面登録 ───────────────────────────────
        ScreenRegistry.register("root",           menu)
        ScreenRegistry.register("status",         menu)
        ScreenRegistry.register("test",           menu)
        ScreenRegistry.register("setting",        menu)

        ScreenRegistry.register("status_general", statusLeaf)
        ScreenRegistry.register("status_ope",     menu)
        ScreenRegistry.register("status_detail",  menu)
        ScreenRegistry.register("status_service", menu)
        ScreenRegistry.register("status_ver",     menu)
        ScreenRegistry.register("test_general",   menu)
        ScreenRegistry.register("test_device",    menu)
        ScreenRegistry.register("test_func",      menu)
        ScreenRegistry.register("setting_device", menu)
        ScreenRegistry.register("setting_model",  menu)
        ScreenRegistry.register("setting_unit",   menu)
        ScreenRegistry.register("setting_adjust", menu)

        for (var i = 1; i <= 2;  i++) ScreenRegistry.register("status_ope_"      + i, statusLeaf)
        for (var j = 1; j <= 16; j++) ScreenRegistry.register("status_detail_"   + j, statusLeaf)
        for (var k = 1; k <= 5;  k++) ScreenRegistry.register("status_service_"  + k, statusLeaf)
        for (var l = 1; l <= 5;  l++) ScreenRegistry.register("status_ver_"      + l, statusLeaf)
        for (var m = 1; m <= 3;  m++) ScreenRegistry.register("setting_device_"  + m, leaf)
        for (var n = 1; n <= 2;  n++) ScreenRegistry.register("setting_model_"   + n, leaf)
        for (var o = 1; o <= 2;  o++) ScreenRegistry.register("setting_unit_"    + o, leaf)
        for (var p = 1; p <= 3;  p++) ScreenRegistry.register("setting_adjust_"  + p, leaf)

        for (var gi = 1; gi <= 4;  gi++) ScreenRegistry.register("test_general_" + gi, leaf)
        for (var di = 1; di <= 16; di++) ScreenRegistry.register("test_device_"  + di, leaf)
        for (var fi = 1; fi <= 8;  fi++) ScreenRegistry.register("test_func_"    + fi, leaf)

        NavigationTree.navigate("root")
    }

    NavigatorShell {
        anchors.fill: parent
    }
}

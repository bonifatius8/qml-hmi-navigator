import QtQuick
import HmiNavigator

Window {
    width: 800
    height: 480
    visible: true
    title: "qml-hmi-navigator"

    Component.onCompleted: {
        var menu = "qrc:/qt/qml/HmiNavigator/qml/screens/MenuScreen.qml"
        var leaf = "qrc:/qt/qml/HmiNavigator/qml/screens/LeafScreenA.qml"

        // ── ノード定義 ──────────────────────────────
        NavigationTree.registerNode("root",           "",               "ホーム")

        // ステータス
        NavigationTree.registerNode("status",         "root",           "ステータス")
        NavigationTree.registerNode("status_general", "status",         "動作状態")
        NavigationTree.registerRepeat("status_ope",   "status",         "デバイス運転状態", {from: 1, to: 4})
        NavigationTree.registerNode("status_service", "status",         "サービス")
        NavigationTree.registerRepeat("status_ver",   "status",         "ソフトバージョン", {from: 1, to: 2})

        // テスト
        NavigationTree.registerNode("test",           "root",           "テスト")
        NavigationTree.registerNode("test_general",   "test",           "一般")
        NavigationTree.registerNode("test_device",    "test",           "デバイス")
        NavigationTree.registerNode("test_func",      "test",           "デバイス機能")

        // 設定
        NavigationTree.registerNode("setting",        "root",           "設定")
        NavigationTree.registerNode("setting_device", "setting",        "デバイス有効無効")
        NavigationTree.registerNode("setting_model",  "setting",        "型式・保存")
        NavigationTree.registerRepeat("setting_unit", "setting",        "ユニット設定", {from: 1, to: 4})

        // ── 画面登録 ───────────────────────────────
        ScreenRegistry.register("root",           menu)
        ScreenRegistry.register("status",         menu)
        ScreenRegistry.register("test",           menu)
        ScreenRegistry.register("setting",        menu)

        ScreenRegistry.register("status_general", leaf)
        ScreenRegistry.register("status_service", leaf)
        ScreenRegistry.register("test_general",   leaf)
        ScreenRegistry.register("test_device",    leaf)
        ScreenRegistry.register("test_func",      leaf)
        ScreenRegistry.register("setting_device", leaf)
        ScreenRegistry.register("setting_model",  leaf)

        for (var i = 1; i <= 4; i++) ScreenRegistry.register("status_ope_" + i, leaf)
        for (var j = 1; j <= 2; j++) ScreenRegistry.register("status_ver_" + j, leaf)
        for (var k = 1; k <= 4; k++) ScreenRegistry.register("setting_unit_" + k, leaf)

        NavigationTree.navigate("root")
    }

    NavigatorShell {
        anchors.fill: parent
    }
}

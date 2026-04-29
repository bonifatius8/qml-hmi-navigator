import QtQuick
import HmiNavigator

Window {
    width: 800
    height: 600
    visible: true
    title: "qml-hmi-navigator"

    Component.onCompleted: {
        NavigationTree.registerNode("root",  "",       "Home")
        NavigationTree.registerNode("menu1", "root",   "Section 1")
        NavigationTree.registerNode("menu2", "root",   "Section 2")
        NavigationTree.registerNode("sub1a", "menu1",  "Item 1-A")
        NavigationTree.registerNode("sub1b", "menu1",  "Item 1-B")
        NavigationTree.registerNode("sub2a", "menu2",  "Item 2-A")

        var base = "qrc:/qt/qml/HmiNavigator/screens/"
        ScreenRegistry.register("root",  base + "MenuScreen.qml")
        ScreenRegistry.register("menu1", base + "MenuScreen.qml")
        ScreenRegistry.register("menu2", base + "MenuScreen.qml")
        ScreenRegistry.register("sub1a", base + "LeafScreenA.qml")
        ScreenRegistry.register("sub1b", base + "LeafScreenA.qml")
        ScreenRegistry.register("sub2a", base + "LeafScreenA.qml")

        NavigationTree.navigate("root")
    }

    NavigatorShell {
        anchors.fill: parent
    }
}

import QtQuick
import QtQuick.Controls
import HmiNavigator

Window {
    width: 800
    height: 600
    visible: true
    title: "qml-hmi-navigator"

    Component.onCompleted: {
        NavigationTree.registerNode("root",  "",       "Root")
        NavigationTree.registerNode("menu1", "root",   "Menu 1")
        NavigationTree.registerNode("menu2", "root",   "Menu 2")
        NavigationTree.registerNode("sub1a", "menu1",  "Sub 1-A")
        NavigationTree.navigate("root")
    }

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: "current: " + NavigationTree.currentNode
            font.pixelSize: 18
        }

        Text {
            text: "breadcrumbs: " + NavigationTree.breadcrumbs.map(b => b.label).join(" > ")
            font.pixelSize: 14
        }

        Text {
            text: "menu: " + NavigationTree.menuModel.map(m => m.label).join(", ")
            font.pixelSize: 14
        }

        Row {
            spacing: 8
            Repeater {
                model: NavigationTree.menuModel
                Button {
                    text: modelData.label
                    onClicked: NavigationTree.navigate(modelData.name)
                }
            }
        }

        Button {
            text: "← Back"
            onClicked: NavigationTree.goBack()
        }
    }
}

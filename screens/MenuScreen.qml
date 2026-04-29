import QtQuick
import HmiNavigator

Item {
    Rectangle {
        anchors.fill: parent
        color: ThemeObject.background
    }

    Flow {
        anchors.centerIn: parent
        spacing: ThemeObject.spacing

        Repeater {
            model: NavigationTree.menuModel
            NavButton {
                text: modelData.label
                onClicked: NavigationTree.navigate(modelData.name)
            }
        }
    }
}

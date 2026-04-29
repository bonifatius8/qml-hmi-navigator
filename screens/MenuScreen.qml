import QtQuick
import HmiNavigator

Item {
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

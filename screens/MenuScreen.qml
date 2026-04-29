import QtQuick
import QtQuick.Controls
import HmiNavigator

Item {
    Flow {
        anchors.centerIn: parent
        spacing: 16

        Repeater {
            model: NavigationTree.menuModel
            Button {
                text: modelData.label
                width: 160
                height: 60
                onClicked: NavigationTree.navigate(modelData.name)
            }
        }
    }
}

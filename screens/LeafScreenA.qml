import QtQuick
import HmiNavigator

Item {
    Rectangle {
        anchors.centerIn: parent
        width: 320
        height: 160
        color: "#313244"
        radius: 8

        Text {
            anchors.centerIn: parent
            text: "Screen A\n" + NavigationTree.currentNode
            color: "#cdd6f4"
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
        }
    }
}

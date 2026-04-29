import QtQuick
import QtQuick.Controls
import HmiNavigator

Item {
    id: root

    // Header
    Rectangle {
        id: header
        width: parent.width
        height: 56
        color: "#1e1e2e"

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16
            spacing: 12

            Button {
                text: "←"
                visible: NavigationTree.breadcrumbs.length > 1
                onClicked: NavigationTree.goBack()
            }

            Text {
                color: "#cdd6f4"
                font.pixelSize: 16
                text: NavigationTree.breadcrumbs.map(b => b.label).join("  ›  ")
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Content
    Loader {
        id: contentLoader
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        source: ScreenRegistry.sourceFor(NavigationTree.currentNode)
    }
}

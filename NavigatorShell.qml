import QtQuick
import HmiNavigator

Item {
    id: root

    NavHeader {
        id: header
    }

    Loader {
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        source: ScreenRegistry.sourceFor(NavigationTree.currentNode)
    }
}

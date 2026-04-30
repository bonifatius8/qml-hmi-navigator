import QtQuick
import HmiNavigator

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: ThemeObject.background
    }

    NavHeader {
        id: header
    }

    Loader {
        id: contentLoader
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        source: ScreenRegistry.sourceFor(NavigationTree.currentNode)
    }

    // ── 左右兄弟ノード移動矢印 (CH Arrow_Button 相当) ────────
    Item {
        anchors.left: parent.left
        anchors.verticalCenter: contentLoader.verticalCenter
        width: 36
        height: 200
        visible: NavigationTree.isLeaf && NavigationTree.siblingIndex > 0
        z: 10

        HmiIcon {
            anchors.centerIn: parent
            width: 24; height: 44
            type: "arrowLeft"
            iconColor: ThemeObject.textSecondary
        }

        TapHandler { onTapped: NavigationTree.navigateSibling(-1) }
    }

    Item {
        anchors.right: parent.right
        anchors.verticalCenter: contentLoader.verticalCenter
        width: 36
        height: 200
        visible: NavigationTree.isLeaf && NavigationTree.siblingIndex < NavigationTree.siblings.length - 1
        z: 10

        HmiIcon {
            anchors.centerIn: parent
            width: 24; height: 44
            type: "arrowRight"
            iconColor: ThemeObject.textSecondary
        }

        TapHandler { onTapped: NavigationTree.navigateSibling(1) }
    }
}

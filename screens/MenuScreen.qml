import QtQuick
import HmiNavigator

Item {
    id: root
    anchors.fill: parent

    property int page: 0
    readonly property var allItems: NavigationTree.menuModel
    readonly property int itemsPerPage: 5
    readonly property int totalPages: Math.max(1, Math.ceil(allItems.length / itemsPerPage))

    Connections {
        target: NavigationTree
        function onCurrentNodeChanged() { root.page = 0 }
    }

    Rectangle {
        anchors.fill: parent
        color: ThemeObject.background
    }

    Column {
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8

        Repeater {
            model: root.allItems.slice(root.page * root.itemsPerPage,
                                       root.page * root.itemsPerPage + root.itemsPerPage)
            NavButton {
                text: modelData.label
                onClicked: NavigationTree.navigate(modelData.name)
            }
        }
    }

    // Page navigation — visible only when multi-page
    Row {
        visible: root.totalPages > 1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 16
        spacing: 8

        Rectangle {
            width: 80; height: 44; radius: 6
            color: root.page > 0 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page > 0 ? 1.0 : 0.4
            Text { anchors.centerIn: parent; text: "◀ 前"; color: "white"; font.pixelSize: ThemeObject.fontSizeSmall }
            TapHandler { enabled: root.page > 0; onTapped: root.page-- }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: (root.page + 1) + " / " + root.totalPages
            color: ThemeObject.textSecondary
            font.pixelSize: ThemeObject.fontSizeSmall
        }

        Rectangle {
            width: 80; height: 44; radius: 6
            color: root.page < root.totalPages - 1 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page < root.totalPages - 1 ? 1.0 : 0.4
            Text { anchors.centerIn: parent; text: "次 ▶"; color: "white"; font.pixelSize: ThemeObject.fontSizeSmall }
            TapHandler { enabled: root.page < root.totalPages - 1; onTapped: root.page++ }
        }
    }
}

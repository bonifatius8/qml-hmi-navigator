import QtQuick
import HmiNavigator

Item {
    id: root
    anchors.fill: parent

    property int page: 0
    readonly property var allItems: NavigationTree.menuModel
    readonly property int itemsPerPage: 5
    readonly property int totalPages: Math.max(1, Math.ceil(allItems.length / itemsPerPage))

    // Map node name → icon type; empty string = no icon
    function iconType(name) {
        if (name === "status")  return "status"
        if (name === "test")    return "test"
        if (name === "setting") return "setting"
        return ""
    }

    readonly property bool isIconGrid: {
        var items = allItems
        for (var i = 0; i < items.length; i++) {
            if (iconType(items[i].name) !== "") return true
        }
        return false
    }

    Connections {
        target: NavigationTree
        function onCurrentNodeChanged() { root.page = 0 }
    }

    Rectangle {
        anchors.fill: parent
        color: ThemeObject.background
    }

    // ── Icon grid (root level) ────────────────────────────────
    Row {
        visible: root.isIconGrid
        anchors.centerIn: parent
        spacing: 32

        Repeater {
            model: root.allItems

            Item {
                width: 160
                height: 150
                visible: root.isIconGrid

                Rectangle {
                    id: tile
                    anchors.fill: parent
                    color: tileArea.pressed ? ThemeObject.btnGradBot : "white"
                    radius: ThemeObject.radius
                    border.color: ThemeObject.border
                    border.width: 1

                    HmiIcon {
                        id: icon
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        width: 80
                        height: 80
                        type: root.iconType(modelData.name)
                        iconColor: tileArea.pressed ? "white" : ThemeObject.btnGradBot
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 16
                        text: modelData.label
                        color: tileArea.pressed ? "white" : ThemeObject.titleColor
                        font.pixelSize: ThemeObject.fontSizeSmall
                        font.family: ThemeObject.fontFamily
                    }
                }

                TapHandler {
                    id: tileArea
                    onTapped: NavigationTree.navigate(modelData.name)
                }
            }
        }
    }

    // ── Text list (sub-menu level) ────────────────────────────
    Column {
        visible: !root.isIconGrid
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

    // ── Pagination (sub-menu only) ────────────────────────────
    Row {
        visible: !root.isIconGrid && root.totalPages > 1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 16
        spacing: 8

        Rectangle {
            width: 80; height: 44; radius: 6
            color: root.page > 0 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page > 0 ? 1.0 : 0.4
            Text { anchors.centerIn: parent; text: "◀ 前"; color: "white"; font.pixelSize: ThemeObject.fontSizeSmall; font.family: ThemeObject.fontFamily }
            TapHandler { enabled: root.page > 0; onTapped: root.page-- }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: (root.page + 1) + " / " + root.totalPages
            color: ThemeObject.textSecondary
            font.pixelSize: ThemeObject.fontSizeSmall
            font.family: ThemeObject.fontFamily
        }

        Rectangle {
            width: 80; height: 44; radius: 6
            color: root.page < root.totalPages - 1 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page < root.totalPages - 1 ? 1.0 : 0.4
            Text { anchors.centerIn: parent; text: "次 ▶"; color: "white"; font.pixelSize: ThemeObject.fontSizeSmall; font.family: ThemeObject.fontFamily }
            TapHandler { enabled: root.page < root.totalPages - 1; onTapped: root.page++ }
        }
    }
}

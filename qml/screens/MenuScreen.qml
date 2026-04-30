import QtQuick
import HmiNavigator

Item {
    id: root
    anchors.fill: parent

    readonly property var allItems: NavigationTree.menuModel

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

    // ── Text list / Grid (sub-menu level) ────────────────────
    readonly property bool useGrid: !isIconGrid && allItems.length > 6

    // Column: ≤6 items
    Column {
        visible: !root.isIconGrid && !root.useGrid
        anchors.centerIn: parent
        spacing: ThemeObject.spacing

        Repeater {
            model: root.allItems
            NavButton {
                text: modelData.label
                onClicked: NavigationTree.navigate(modelData.name)
            }
        }
    }

    // Grid: >6 items (CH TestPage_Burner 相当)
    Grid {
        visible: root.useGrid
        anchors.centerIn: parent
        columns: root.allItems.length > 12 ? 4 : 3
        columnSpacing: 12
        rowSpacing: 12

        Repeater {
            model: root.allItems

            Rectangle {
                width: 160
                height: 55
                radius: 8
                gradient: Gradient {
                    GradientStop { position: 0.0; color: ThemeObject.btnGradTop }
                    GradientStop { position: 1.0; color: ThemeObject.btnGradBot }
                }

                Text {
                    anchors.centerIn: parent
                    text: modelData.label
                    color: "white"
                    font.pixelSize: ThemeObject.fontSizeSmall
                    font.family: ThemeObject.fontFamily
                }

                TapHandler { onTapped: NavigationTree.navigate(modelData.name) }
            }
        }
    }


}

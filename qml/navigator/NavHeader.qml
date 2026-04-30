import QtQuick
import HmiNavigator

Rectangle {
    width: parent.width
    height: ThemeObject.headerHeight
    color: "transparent"

    // ── right: global mode buttons ────────────────────────────
    Row {
        id: globalRow
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        function sectionActive(node) {
            var bc = NavigationTree.breadcrumbs
            if (bc.length <= 1) return true
            return bc[1].name === node
        }

        Item {
            width: 44; height: 44
            opacity: globalRow.sectionActive("status") ? 1.0 : 0.3
            HmiIcon { anchors.fill: parent; type: "status"; iconColor: ThemeObject.btnGradBot }
            TapHandler { onTapped: NavigationTree.navigate("status") }
        }

        Item {
            width: 44; height: 44
            opacity: globalRow.sectionActive("test") ? 1.0 : 0.3
            HmiIcon { anchors.fill: parent; type: "test"; iconColor: ThemeObject.btnGradBot }
            TapHandler { onTapped: NavigationTree.navigate("test") }
        }

        Item {
            width: 44; height: 44
            opacity: globalRow.sectionActive("setting") ? 1.0 : 0.3
            HmiIcon { anchors.fill: parent; type: "setting"; iconColor: ThemeObject.btnGradBot }
            TapHandler { onTapped: NavigationTree.navigate("setting") }
        }
    }

    // ── left: back button + breadcrumbs (幅制約 + xScale) ─────
    Item {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.right: globalRow.left
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height

        Row {
            id: leftRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 16

            transformOrigin: Item.Left
            transform: Scale {
                xScale: (leftRow.width > 0 && leftRow.width > leftRow.parent.width)
                        ? leftRow.parent.width / leftRow.width : 1.0
            }

            // Back button
            Item {
                width: 50
                height: 50
                visible: NavigationTree.breadcrumbs.length > 1
                anchors.verticalCenter: parent.verticalCenter

                HmiIcon {
                    anchors.fill: parent
                    type: "back"
                    iconColor: backHover.containsMouse ? "#1a6fa8" : ThemeObject.btnGradBot
                }

                HoverHandler { id: backHover }
                TapHandler { onTapped: NavigationTree.goBack() }
            }

            // Breadcrumbs
            Repeater {
                model: NavigationTree.breadcrumbs

                Row {
                    visible: index > 0
                    spacing: 6
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        text: index > 1 ? " / " : ""
                        color: "#8899bb"
                        font.pixelSize: ThemeObject.fontSizeBase
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: modelData.label
                        color: index === NavigationTree.breadcrumbs.length - 1
                               ? ThemeObject.titleColor : "#8899bb"
                        font.pixelSize: ThemeObject.fontSizeTitle
                        font.family: ThemeObject.fontFamily
                        anchors.verticalCenter: parent.verticalCenter

                        TapHandler {
                            enabled: index < NavigationTree.breadcrumbs.length - 1
                            onTapped: NavigationTree.navigate(modelData.name)
                        }
                    }
                }
            }
        }
    }
}

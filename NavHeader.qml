import QtQuick
import HmiNavigator

Rectangle {
    width: parent.width
    height: ThemeObject.headerHeight
    color: "transparent"

    // ── left: back button + breadcrumbs ──────────────────────
    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 12
        spacing: 16

        // Back button
        Item {
            width: 50
            height: 50
            visible: NavigationTree.breadcrumbs.length > 1

            HmiIcon {
                anchors.fill: parent
                type: "back"
                iconColor: backHover.containsMouse ? "#1a6fa8" : ThemeObject.btnGradBot  // blue square on gray bg
            }

            HoverHandler { id: backHover }
            TapHandler { onTapped: NavigationTree.goBack() }
        }

        // Breadcrumbs (root=index 0 は非表示、区切り " / ")
        Repeater {
            model: NavigationTree.breadcrumbs

            Row {
                visible: index > 0
                spacing: 6

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

    // ── right: global mode buttons (CH GlobalButtons 相当) ────
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        function sectionActive(node) {
            var bc = NavigationTree.breadcrumbs
            if (bc.length <= 1) return true   // root: all active (CH mode === -1)
            return bc[1].name === node
        }

        Item {
            width: 44; height: 44
            opacity: parent.sectionActive("status") ? 1.0 : 0.3
            HmiIcon { anchors.fill: parent; type: "status"; iconColor: ThemeObject.btnGradBot }
            TapHandler { onTapped: NavigationTree.navigate("status") }
        }

        Item {
            width: 44; height: 44
            opacity: parent.sectionActive("test") ? 1.0 : 0.3
            HmiIcon { anchors.fill: parent; type: "test"; iconColor: ThemeObject.btnGradBot }
            TapHandler { onTapped: NavigationTree.navigate("test") }
        }

        Item {
            width: 44; height: 44
            opacity: parent.sectionActive("setting") ? 1.0 : 0.3
            HmiIcon { anchors.fill: parent; type: "setting"; iconColor: ThemeObject.btnGradBot }
            TapHandler { onTapped: NavigationTree.navigate("setting") }
        }
    }
}

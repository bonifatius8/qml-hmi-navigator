import QtQuick
import HmiNavigator

Rectangle {
    width: parent.width
    height: ThemeObject.headerHeight
    color: ThemeObject.headerBg

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 12
        spacing: 16

        // Back button
        Rectangle {
            width: 50
            height: 50
            radius: 6
            color: backHover.containsMouse ? "#1a6fa8" : "#195A8C"
            visible: NavigationTree.breadcrumbs.length > 1

            Text {
                anchors.centerIn: parent
                text: "◀"
                color: "white"
                font.pixelSize: 22
            }

            HoverHandler { id: backHover }
            TapHandler { onTapped: NavigationTree.goBack() }
        }

        // Breadcrumbs
        Repeater {
            model: NavigationTree.breadcrumbs

            Row {
                spacing: 8

                Text {
                    text: index > 0 ? "›" : ""
                    color: "#a8d4ff"
                    font.pixelSize: ThemeObject.fontSizeBase
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: modelData.label
                    color: index === NavigationTree.breadcrumbs.length - 1
                           ? "white" : "#a8d4ff"
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

import QtQuick
import HmiNavigator

Rectangle {
    width: parent.width
    height: ThemeObject.headerHeight
    color: ThemeObject.background

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: ThemeObject.spacing
        spacing: 8

        // Back button
        NavButton {
            text: "←"
            width: 40
            height: 36
            visible: NavigationTree.breadcrumbs.length > 1
            onClicked: NavigationTree.goBack()
        }

        // Breadcrumbs
        Repeater {
            model: NavigationTree.breadcrumbs

            Row {
                spacing: 8

                Text {
                    text: index > 0 ? "›" : ""
                    color: ThemeObject.textSecondary
                    font.pixelSize: ThemeObject.fontSizeBase
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: modelData.label
                    color: index === NavigationTree.breadcrumbs.length - 1
                           ? ThemeObject.textPrimary
                           : ThemeObject.primary
                    font.pixelSize: ThemeObject.fontSizeBase
                    font.family: ThemeObject.fontFamily
                    anchors.verticalCenter: parent.verticalCenter

                    HoverHandler { id: crumbHover }

                    TapHandler {
                        enabled: index < NavigationTree.breadcrumbs.length - 1
                        onTapped: NavigationTree.navigate(modelData.name)
                    }
                }
            }
        }
    }
}

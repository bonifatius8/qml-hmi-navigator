import QtQuick
import HmiNavigator

Item {
    id: root

    property string label: ""
    property bool active: false
    signal clicked(bool value)

    width: 460
    height: ThemeObject.buttonHeight

    Row {
        anchors.fill: parent
        spacing: 0

        // Label area
        Rectangle {
            width: parent.width - 120
            height: parent.height
            color: ThemeObject.surface
            border.color: ThemeObject.border
            border.width: 1

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 16
                text: root.label
                color: ThemeObject.textPrimary
                font.pixelSize: ThemeObject.fontSizeBase
                font.family: ThemeObject.fontFamily
            }
        }

        // ON button
        Rectangle {
            width: 60
            height: parent.height
            color: root.active ? ThemeObject.onColor : ThemeObject.surface
            border.color: ThemeObject.border
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: "ON"
                color: root.active ? "white" : ThemeObject.textSecondary
                font.pixelSize: ThemeObject.fontSizeSmall
                font.bold: root.active
            }

            TapHandler { onTapped: root.clicked(true) }
        }

        // OFF button
        Rectangle {
            width: 60
            height: parent.height
            color: !root.active ? "#cc4444" : ThemeObject.surface
            border.color: ThemeObject.border
            border.width: 1
            radius: 0

            Text {
                anchors.centerIn: parent
                text: "OFF"
                color: !root.active ? "white" : ThemeObject.textSecondary
                font.pixelSize: ThemeObject.fontSizeSmall
                font.bold: !root.active
            }

            TapHandler { onTapped: root.clicked(false) }
        }
    }
}

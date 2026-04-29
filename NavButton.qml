import QtQuick
import HmiNavigator

Rectangle {
    id: root

    property alias text: label.text
    signal clicked()

    width: ThemeObject.buttonWidth
    height: ThemeObject.buttonHeight
    radius: ThemeObject.radius
    color: hover.containsMouse ? ThemeObject.surfaceHover : ThemeObject.surface

    Behavior on color { ColorAnimation { duration: 120 } }

    Text {
        id: label
        anchors.centerIn: parent
        color: ThemeObject.textPrimary
        font.pixelSize: ThemeObject.fontSizeBase
        font.family: ThemeObject.fontFamily
    }

    HoverHandler { id: hover }

    TapHandler { onTapped: root.clicked() }
}

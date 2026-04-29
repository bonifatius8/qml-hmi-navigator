import QtQuick
import HmiNavigator

Item {
    id: root

    property alias text: label.text
    signal clicked()

    width: ThemeObject.buttonWidth
    height: ThemeObject.buttonHeight

    Rectangle {
        anchors.fill: parent
        radius: ThemeObject.radius

        gradient: Gradient {
            GradientStop { position: 0.52; color: ThemeObject.btnGradTop }
            GradientStop { position: 0.53; color: ThemeObject.btnGradBot }
        }
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: ThemeObject.btnText
        font.pixelSize: ThemeObject.fontSizeLarge
        font.family: ThemeObject.fontFamily
    }

    TapHandler { onTapped: root.clicked() }
}

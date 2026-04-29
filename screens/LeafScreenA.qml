import QtQuick
import HmiNavigator

Item {
    Rectangle {
        anchors.centerIn: parent
        width: 320
        height: 160
        color: ThemeObject.surface
        radius: ThemeObject.radius

        Text {
            anchors.centerIn: parent
            text: NavigationTree.breadcrumbs.map(b => b.label).join(" › ")
            color: ThemeObject.textPrimary
            font.pixelSize: ThemeObject.fontSizeLarge
            font.family: ThemeObject.fontFamily
            horizontalAlignment: Text.AlignHCenter
        }
    }
}

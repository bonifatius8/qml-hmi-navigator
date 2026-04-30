import QtQuick
import HmiNavigator

Item {
    id: root
    anchors.fill: parent

    readonly property int itemH: ThemeObject.buttonHeight + 8
    readonly property int totalItems: Math.floor(parent.height / itemH)

    property var states: {
        var s = {}
        for (var i = 1; i <= totalItems; i++) s["item" + i] = false
        return s
    }

    Rectangle {
        anchors.fill: parent
        color: ThemeObject.background
    }

    Column {
        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: root.totalItems

            OnOffButton {
                property int idx: index + 1
                label: NavigationTree.breadcrumbs[NavigationTree.breadcrumbs.length - 1].label
                      + " " + String(idx).padStart(2, "0")
                active: root.states["item" + idx] ?? false
                onClicked: function(val) {
                    var s = Object.assign({}, root.states)
                    s["item" + idx] = val
                    root.states = s
                }
            }
        }
    }


}

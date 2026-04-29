import QtQuick
import HmiNavigator

Item {
    id: root

    property int page: 0
    readonly property int itemsPerPage: 6
    readonly property int totalItems: 12
    readonly property int totalPages: Math.ceil(totalItems / itemsPerPage)

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
        x: 40
        y: 20
        spacing: ThemeObject.spacing

        Repeater {
            model: Math.min(itemsPerPage, totalItems - root.page * itemsPerPage)

            OnOffButton {
                property int idx: root.page * root.itemsPerPage + index + 1
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

    // Page navigation
    Row {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 16
        spacing: 8

        Rectangle {
            width: 80
            height: 44
            radius: 6
            color: root.page > 0 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page > 0 ? 1.0 : 0.4

            Text {
                anchors.centerIn: parent
                text: "◀ 前"
                color: "white"
                font.pixelSize: ThemeObject.fontSizeSmall
            }

            TapHandler {
                enabled: root.page > 0
                onTapped: root.page--
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: (root.page + 1) + " / " + root.totalPages
            color: ThemeObject.textSecondary
            font.pixelSize: ThemeObject.fontSizeSmall
        }

        Rectangle {
            width: 80
            height: 44
            radius: 6
            color: root.page < root.totalPages - 1 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page < root.totalPages - 1 ? 1.0 : 0.4

            Text {
                anchors.centerIn: parent
                text: "次 ▶"
                color: "white"
                font.pixelSize: ThemeObject.fontSizeSmall
            }

            TapHandler {
                enabled: root.page < root.totalPages - 1
                onTapped: root.page++
            }
        }
    }
}

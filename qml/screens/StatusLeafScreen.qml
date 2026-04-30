import QtQuick
import HmiNavigator

Item {
    id: root
    anchors.fill: parent

    property int page: 0
    readonly property int itemsPerPage: 5
    readonly property int totalItems: 10

    readonly property var dummyData: [
        { label: "現在値 01", value: "85.3",  unit: "°C"    },
        { label: "現在値 02", value: "1.04",  unit: "MPa"   },
        { label: "現在値 03", value: "12.5",  unit: "L/min" },
        { label: "現在値 04", value: "24.0",  unit: "V"     },
        { label: "現在値 05", value: "2.4",   unit: "A"     },
        { label: "現在値 06", value: "320",   unit: "rpm"   },
        { label: "現在値 07", value: "0.98",  unit: "MPa"   },
        { label: "現在値 08", value: "43.1",  unit: "°C"    },
        { label: "現在値 09", value: "99.7",  unit: "%"     },
        { label: "現在値 10", value: "18.2",  unit: "kW"    }
    ]

    readonly property int totalPages: Math.ceil(totalItems / itemsPerPage)

    Rectangle { anchors.fill: parent; color: ThemeObject.background }

    Column {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.right: parent.right
        anchors.rightMargin: 40
        spacing: 8

        Repeater {
            model: Math.min(itemsPerPage, totalItems - root.page * itemsPerPage)

            Rectangle {
                property var entry: root.dummyData[root.page * root.itemsPerPage + index]
                width: parent.width
                height: 60
                color: "white"
                radius: 8
                border.color: ThemeObject.border
                border.width: 1

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    text: entry.label
                    color: ThemeObject.titleColor
                    font.pixelSize: ThemeObject.fontSizeBase
                    font.family: ThemeObject.fontFamily
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 6

                    Text {
                        text: entry.value
                        color: ThemeObject.titleColor
                        font.pixelSize: ThemeObject.fontSizeLarge
                        font.family: ThemeObject.fontFamily
                    }
                    Text {
                        anchors.baseline: parent.children[0].baseline
                        text: entry.unit
                        color: ThemeObject.textSecondary
                        font.pixelSize: ThemeObject.fontSizeSmall
                        font.family: ThemeObject.fontFamily
                    }
                }
            }
        }
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 16
        spacing: 8

        Rectangle {
            width: 80; height: 44; radius: 6
            color: root.page > 0 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page > 0 ? 1.0 : 0.4
            Text { anchors.centerIn: parent; text: "◀ 前"; color: "white"; font.pixelSize: ThemeObject.fontSizeSmall; font.family: ThemeObject.fontFamily }
            TapHandler { enabled: root.page > 0; onTapped: root.page-- }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: (root.page + 1) + " / " + root.totalPages
            color: ThemeObject.textSecondary
            font.pixelSize: ThemeObject.fontSizeSmall
            font.family: ThemeObject.fontFamily
        }

        Rectangle {
            width: 80; height: 44; radius: 6
            color: root.page < root.totalPages - 1 ? ThemeObject.btnGradBot : ThemeObject.border
            opacity: root.page < root.totalPages - 1 ? 1.0 : 0.4
            Text { anchors.centerIn: parent; text: "次 ▶"; color: "white"; font.pixelSize: ThemeObject.fontSizeSmall; font.family: ThemeObject.fontFamily }
            TapHandler { enabled: root.page < root.totalPages - 1; onTapped: root.page++ }
        }
    }
}

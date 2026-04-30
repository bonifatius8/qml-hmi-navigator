import QtQuick
import HmiNavigator

Item {
    id: root
    anchors.fill: parent

    readonly property int itemH: ThemeObject.buttonHeight + ThemeObject.spacing
    readonly property int totalItems: Math.min(Math.floor(parent.height / itemH), dummyData.length)

    readonly property var dummyData: [
        { label: "現在値 01", value: "85.3",  unit: "°C"    },
        { label: "現在値 02", value: "1.04",  unit: "MPa"   },
        { label: "現在値 03", value: "12.5",  unit: "L/min" },
        { label: "現在値 04", value: "24.0",  unit: "V"     },
        { label: "現在値 05", value: "2.4",   unit: "A"     },
        { label: "現在値 06", value: "320",   unit: "rpm"   },
        { label: "現在値 07", value: "0.98",  unit: "MPa"   },
        { label: "現在値 08", value: "43.1",  unit: "°C"    }
    ]

    Rectangle { anchors.fill: parent; color: ThemeObject.background }

    Column {
        anchors.centerIn: parent
        width: parent.width - 80
        spacing: ThemeObject.spacing

        Repeater {
            model: root.totalItems

            Rectangle {
                property var entry: root.dummyData[index]
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


}

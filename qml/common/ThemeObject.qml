pragma Singleton
import QtQuick

QtObject {
    // Colors — CH blue scheme
    readonly property color background:    "#EBEBEB"
    readonly property color surface:       "#f0f4f8"
    readonly property color btnGradTop:    "#195A8C"
    readonly property color btnGradBot:    "#004682"
    readonly property color btnText:       "#ffffff"
    readonly property color titleColor:    "#004682"
    readonly property color textPrimary:   "#222222"
    readonly property color textSecondary: "#555555"
    readonly property color border:        "#cccccc"
    readonly property color headerBg:      "#004682"
    readonly property color onColor:       "#2ecc71"
    readonly property color offColor:      "#aaaaaa"

    // Typography
    readonly property string fontFamily: "MigMix 2P"
    readonly property int fontSizeSmall:  16
    readonly property int fontSizeBase:   20
    readonly property int fontSizeLarge:  28
    readonly property int fontSizeTitle:  30

    // Layout
    readonly property int headerHeight:   70
    readonly property int buttonHeight:   60
    readonly property int buttonWidth:    300
    readonly property int spacing:        15
    readonly property int radius:         10
}

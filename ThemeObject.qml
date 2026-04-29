pragma Singleton
import QtQuick

QtObject {
    // Colors
    readonly property color background:    "#1e1e2e"
    readonly property color surface:       "#313244"
    readonly property color surfaceHover:  "#45475a"
    readonly property color primary:       "#89b4fa"
    readonly property color primaryFg:     "#1e1e2e"
    readonly property color textPrimary:   "#cdd6f4"
    readonly property color textSecondary: "#a6adc8"
    readonly property color border:        "#45475a"

    // Typography
    readonly property string fontFamily: "sans-serif"
    readonly property int fontSizeSmall:  12
    readonly property int fontSizeBase:   14
    readonly property int fontSizeLarge:  18
    readonly property int fontSizeTitle:  22

    // Layout
    readonly property int headerHeight:   56
    readonly property int buttonHeight:   56
    readonly property int buttonWidth:    160
    readonly property int spacing:        16
    readonly property int radius:          8
}

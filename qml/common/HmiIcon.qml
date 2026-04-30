import QtQuick
import HmiNavigator

Canvas {
    id: root
    property string type: "back"
    property color iconColor: ThemeObject.btnGradBot

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        ctx.fillStyle   = Qt.color(iconColor)
        ctx.strokeStyle = Qt.color(iconColor)

        if      (type === "back")       _drawBack(ctx)
        else if (type === "status")     _drawStatus(ctx)
        else if (type === "test")       _drawTest(ctx)
        else if (type === "setting")    _drawSetting(ctx)
        else if (type === "arrowLeft")  _drawArrow(ctx, -1)
        else if (type === "arrowRight") _drawArrow(ctx,  1)
    }

    onTypeChanged:      requestPaint()
    onIconColorChanged: requestPaint()
    onWidthChanged:     requestPaint()
    onHeightChanged:    requestPaint()

    // ── helpers ──────────────────────────────────────────────

    function _rr(ctx, x, y, w, h, r) {
        ctx.beginPath()
        ctx.moveTo(x + r, y)
        ctx.lineTo(x + w - r, y)
        ctx.arcTo(x + w, y,     x + w, y + r,     r)
        ctx.lineTo(x + w, y + h - r)
        ctx.arcTo(x + w, y + h, x + w - r, y + h, r)
        ctx.lineTo(x + r, y + h)
        ctx.arcTo(x,     y + h, x,     y + h - r, r)
        ctx.lineTo(x,    y + r)
        ctx.arcTo(x,     y,     x + r, y,          r)
        ctx.closePath()
    }

    // ── icons ─────────────────────────────────────────────────

    function _drawBack(ctx) {
        // btn_back.svg (56×55px): TL/TR/BL=square corner, BR=large bezier curve
        var W = width, H = height
        ctx.fillStyle = Qt.color(iconColor)
        ctx.beginPath()
        ctx.moveTo(0, 0)
        ctx.lineTo(W, 0)
        ctx.lineTo(W, H * 0.364)        // curve start point (y≈20/55)
        ctx.bezierCurveTo(W * 1.0, H * 0.542,  W * 0.986, H * 0.674,  W * 0.890, H * 0.823)
        ctx.bezierCurveTo(W * 0.765, H * 0.945, W * 0.641, H * 1.0,   W * 0.469, H)
        ctx.lineTo(0, H)
        ctx.closePath()
        ctx.fill()
        // white left-pointing arrow derived from SVG path2 (translate 28,14)
        ctx.fillStyle = "white"
        ctx.beginPath()
        ctx.moveTo(W * 0.500, H * 0.255)   // head top
        ctx.lineTo(W * 0.500, H * 0.382)   // shaft inner top
        ctx.lineTo(W * 0.661, H * 0.382)   // shaft right-top
        ctx.lineTo(W * 0.661, H * 0.618)   // shaft right-bottom
        ctx.lineTo(W * 0.500, H * 0.618)   // shaft inner bottom
        ctx.lineTo(W * 0.500, H * 0.745)   // head bottom
        ctx.lineTo(W * 0.232, H * 0.509)   // tip (left)
        ctx.closePath()
        ctx.fill()
    }

    function _drawStatus(ctx) {
        // bar chart: 4 bars of varying height, bottom-aligned
        var W = width, H = height
        var bw  = W * 0.16   // bar width
        var gap = W * 0.08   // gap between bars
        var totalW = 4 * bw + 3 * gap
        var ox = (W - totalW) / 2  // left offset to center
        var heights = [0.40, 0.70, 0.55, 0.90]
        for (var i = 0; i < 4; i++) {
            var bh = H * heights[i]
            ctx.fillRect(ox + i * (bw + gap), H - bh, bw, bh)
        }
    }

    function _drawTest(ctx) {
        // btn_test_off.svg (32×35px): clipboard body + checkmark
        var W = width, H = height

        // path1: clipboard body (3 sub-paths, evenodd)
        // outer rect, clip hole, U-shape inner hole
        ctx.beginPath()
        ctx.rect(0, 0, W, H)
        ctx.rect(W * 10/32, H * 2/35, W * 12/32, H * 4/35)
        ctx.moveTo(W *  5/32, H *  4/35)
        ctx.lineTo(W *  5/32, H * 30/35)
        ctx.lineTo(W * 27/32, H * 30/35)
        ctx.lineTo(W * 27/32, H *  4/35)
        ctx.lineTo(W * 24/32, H *  4/35)
        ctx.lineTo(W * 24/32, H *  8/35)
        ctx.lineTo(W *  8/32, H *  8/35)
        ctx.lineTo(W *  8/32, H *  4/35)
        ctx.closePath()
        ctx.fill("evenodd")

        // path2: checkmark (translate 20,12 in SVG → normalized)
        ctx.fillStyle = Qt.color(iconColor)
        ctx.beginPath()
        ctx.moveTo(W * 0.625, H * 0.343)
        ctx.bezierCurveTo(W * 0.663, H * 0.352, W * 0.706, H * 0.362, W * 0.750, H * 0.371)
        ctx.bezierCurveTo(W * 0.706, H * 0.457, W * 0.657, H * 0.523, W * 0.590, H * 0.593)
        ctx.bezierCurveTo(W * 0.565, H * 0.619, W * 0.565, H * 0.619, W * 0.539, H * 0.646)
        ctx.bezierCurveTo(W * 0.519, H * 0.665, W * 0.519, H * 0.665, W * 0.500, H * 0.686)
        ctx.bezierCurveTo(W * 0.385, H * 0.671, W * 0.325, H * 0.654, W * 0.250, H * 0.571)
        ctx.bezierCurveTo(W * 0.260, H * 0.543, W * 0.271, H * 0.515, W * 0.281, H * 0.486)
        ctx.bezierCurveTo(W * 0.309, H * 0.494, W * 0.337, H * 0.502, W * 0.365, H * 0.511)
        ctx.bezierCurveTo(W * 0.466, H * 0.525, W * 0.466, H * 0.525, W * 0.516, H * 0.478)
        ctx.bezierCurveTo(W * 0.555, H * 0.435, W * 0.590, H * 0.389, W * 0.625, H * 0.343)
        ctx.closePath()
        ctx.fill()
    }

    function _drawSetting(ctx) {
        var cx = width  / 2
        var cy = height / 2
        var maxR   = Math.min(width, height) / 2 - 1
        var toothR = maxR
        var outerR = maxR * 0.76
        var innerR = maxR * 0.44
        var teeth  = 8
        var step   = Math.PI * 2 / teeth
        var half   = step * 0.22

        ctx.beginPath()
        for (var i = 0; i < teeth; i++) {
            var a = i * step - Math.PI / 2
            ctx.lineTo(cx + Math.cos(a - half) * outerR, cy + Math.sin(a - half) * outerR)
            ctx.lineTo(cx + Math.cos(a - half) * toothR, cy + Math.sin(a - half) * toothR)
            ctx.lineTo(cx + Math.cos(a + half) * toothR, cy + Math.sin(a + half) * toothR)
            ctx.lineTo(cx + Math.cos(a + half) * outerR, cy + Math.sin(a + half) * outerR)
        }
        ctx.closePath()
        // inner hole (evenodd)
        ctx.moveTo(cx + innerR, cy)
        ctx.arc(cx, cy, innerR, 0, Math.PI * 2, true)
        ctx.fill("evenodd")
    }

    function _drawArrow(ctx, dir) {
        var cx = width  / 2
        var cy = height / 2
        var s  = height * 0.28
        ctx.lineWidth  = 3
        ctx.lineCap    = "round"
        ctx.lineJoin   = "round"
        ctx.beginPath()
        ctx.moveTo(cx - dir * s * 0.5, cy - s)
        ctx.lineTo(cx + dir * s * 0.5, cy)
        ctx.lineTo(cx - dir * s * 0.5, cy + s)
        ctx.stroke()
    }
}

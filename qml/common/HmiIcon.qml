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

        // path2: checkmark (SVG 512×512 → clipboard inner area x=6..26, y=9..29 / 32×35)
        ctx.save()
        ctx.transform((W * 20/32) / 512, 0, 0, (H * 20/35) / 512, W * 6/32, H * 9/35)
        ctx.fillStyle = Qt.color(iconColor)
        ctx.beginPath()
        ctx.moveTo(469.402, 35.492)
        ctx.bezierCurveTo(334.09, 110.664, 197.114, 324.5, 197.114, 324.5)
        ctx.lineTo(73.509, 184.176)
        ctx.lineTo(0, 254.336)
        ctx.lineTo(178.732, 476.508)
        ctx.lineTo(243.882, 474.004)
        ctx.bezierCurveTo(327.414, 223.414, 512, 55.539, 512, 55.539)
        ctx.lineTo(469.402, 35.492)
        ctx.closePath()
        ctx.fill()
        ctx.restore()
    }

    function _drawSetting(ctx) {
        // SVG ref: 512x512 viewBox, 12 teeth, outer≈0.97R, body≈0.75R, hole≈0.33R
        var cx = width  / 2
        var cy = height / 2
        var R      = Math.min(width, height) / 2 * 0.96
        var tipR   = R              // tooth tip radius
        var bodyR  = R * 0.755     // tooth root / gear body
        var holeR  = R * 0.325     // center hole
        var teeth     = 8
        var step      = Math.PI * 2 / teeth
        var tHalfBase = step * 0.28  // 歯基部の半角 (広い)
        var tHalfTip  = step * 0.18  // 歯先端の半角 (狭い) → 台形

        ctx.beginPath()
        var aStart = -Math.PI / 2 - step + tHalfBase
        ctx.moveTo(cx + bodyR * Math.cos(aStart), cy + bodyR * Math.sin(aStart))
        for (var i = 0; i < teeth; i++) {
            var a = i * step - Math.PI / 2
            var aValS      = a - step + tHalfBase   // 前の歯 trailing edge から開始
            var aLeadBase  = a - tHalfBase
            var aLeadTip   = a - tHalfTip
            var aTrailTip  = a + tHalfTip
            var aTrailBase = a + tHalfBase
            // 谷弧 (bodyR, continuous)
            ctx.arc(cx, cy, bodyR, aValS, aLeadBase, false)
            // 前フランク (斜め: bodyR基部 → tipR先端)
            ctx.lineTo(cx + tipR * Math.cos(aLeadTip), cy + tipR * Math.sin(aLeadTip))
            // 歯先弧 (tipR)
            ctx.arc(cx, cy, tipR, aLeadTip, aTrailTip, false)
            // 後フランク (斜め: tipR先端 → bodyR基部)
            ctx.lineTo(cx + bodyR * Math.cos(aTrailBase), cy + bodyR * Math.sin(aTrailBase))
        }
        ctx.closePath()
        // Center hole (evenodd)
        ctx.moveTo(cx + holeR, cy)
        ctx.arc(cx, cy, holeR, 0, Math.PI * 2, true)
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

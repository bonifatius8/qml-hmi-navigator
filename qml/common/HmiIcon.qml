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
        // blue rounded rect background
        ctx.fillStyle = Qt.color(iconColor)
        _rr(ctx, 0, 0, width, height, 6)
        ctx.fill()
        // white filled left arrow
        ctx.fillStyle = "white"
        var cx = width * 0.47
        var cy = height / 2
        var s  = height * 0.28
        ctx.beginPath()
        ctx.moveTo(cx - s,       cy)
        ctx.lineTo(cx + s * 0.5, cy - s * 1.1)
        ctx.lineTo(cx + s * 0.5, cy + s * 1.1)
        ctx.closePath()
        ctx.fill()
    }

    function _drawStatus(ctx) {
        // circle outline
        var r = Math.min(width, height) / 2 - 3
        ctx.lineWidth = 3.5
        ctx.beginPath()
        ctx.arc(width / 2, height / 2, r, 0, Math.PI * 2)
        ctx.stroke()
    }

    function _drawTest(ctx) {
        // clipboard body
        var bw = width  * 0.58
        var bh = height * 0.72
        var bx = (width  - bw) / 2
        var by = height * 0.20
        ctx.lineWidth = 2
        _rr(ctx, bx, by, bw, bh, 2)
        ctx.stroke()
        // clip tab
        var tw = bw * 0.42
        var th = 6
        ctx.fillStyle = Qt.color(iconColor)
        _rr(ctx, bx + (bw - tw) / 2, by - th / 2, tw, th, 2)
        ctx.fill()
        // checkmark
        ctx.lineWidth  = 2.5
        ctx.lineCap    = "round"
        ctx.lineJoin   = "round"
        var ckx = width  / 2 - 1
        var cky = by + bh * 0.58
        ctx.beginPath()
        ctx.moveTo(ckx - 7, cky)
        ctx.lineTo(ckx - 1, cky + 6)
        ctx.lineTo(ckx + 9, cky - 7)
        ctx.stroke()
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

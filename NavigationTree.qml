pragma Singleton
import QtQuick

QtObject {
    id: root

    property string currentNode: ""

    readonly property var breadcrumbs:   _buildBreadcrumbs(currentNode)
    readonly property var menuModel:     _buildMenuModel(currentNode)
    readonly property var siblings:      _buildSiblings(currentNode)
    readonly property int siblingIndex:  _buildSiblingIndex(currentNode)

    property var _nodes: ({})

    function registerNode(name, parentName, label) {
        var updated = Object.assign({}, _nodes)
        if (!updated[name]) {
            updated[name] = { label: label, parent: parentName ?? "", children: [] }
        }
        if (parentName && updated[parentName]) {
            if (updated[parentName].children.indexOf(name) === -1) {
                updated[parentName].children.push(name)
            }
        }
        _nodes = updated
    }

    function navigate(name) {
        if (_nodes[name] !== undefined) {
            currentNode = name
        }
    }

    // registerRepeat("item", "menu1", "Item", {from:1, to:5})
    // → item_1〜item_5 を parentName の子として登録
    function registerRepeat(idPrefix, parentName, labelPrefix, range) {
        for (var i = range.from; i <= range.to; i++) {
            registerNode(idPrefix + "_" + i, parentName, labelPrefix + " " + i)
        }
    }

    function goBack() {
        var node = _nodes[currentNode]
        if (node && node.parent) {
            currentNode = node.parent
        }
    }

    function navigateSibling(offset) {
        var idx = siblingIndex + offset
        if (idx >= 0 && idx < siblings.length) {
            navigate(siblings[idx].name)
        }
    }

    function _buildSiblings(name) {
        if (!name || !_nodes[name]) return []
        var parentName = _nodes[name].parent
        if (!parentName || !_nodes[parentName]) return []
        return _nodes[parentName].children.map(function(c) {
            return { name: c, label: _nodes[c] ? _nodes[c].label : c }
        })
    }

    function _buildSiblingIndex(name) {
        var sibs = _buildSiblings(name)
        for (var i = 0; i < sibs.length; i++) {
            if (sibs[i].name === name) return i
        }
        return 0
    }

    function _buildBreadcrumbs(name) {
        var crumbs = []
        var cur = name
        while (cur && _nodes[cur]) {
            crumbs.unshift({ name: cur, label: _nodes[cur].label })
            cur = _nodes[cur].parent
        }
        return crumbs
    }

    function _buildMenuModel(name) {
        if (!name || !_nodes[name]) return []
        return _nodes[name].children.map(function(child) {
            return { name: child, label: _nodes[child] ? _nodes[child].label : child }
        })
    }
}

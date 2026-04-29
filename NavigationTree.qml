pragma Singleton
import QtQuick

QtObject {
    id: root

    property string currentNode: ""

    readonly property var breadcrumbs: _buildBreadcrumbs(currentNode)
    readonly property var menuModel: _buildMenuModel(currentNode)

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

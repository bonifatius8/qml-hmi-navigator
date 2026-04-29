pragma Singleton
import QtQuick

QtObject {
    property var _registry: ({})

    function register(nodeName, qmlPath) {
        var updated = Object.assign({}, _registry)
        updated[nodeName] = qmlPath
        _registry = updated
    }

    function sourceFor(nodeName) {
        return _registry[nodeName] ?? ""
    }
}

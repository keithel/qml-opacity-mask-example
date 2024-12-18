import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    id: base
    property var sources
    property var masks
    property string source
    property string mask

    RowLayout {
        id: sourceLayout
        Component.onCompleted: {
            for (let i = 0; i < base.sources.length; i++) {
                if (source.toLowerCase() === sources[i].toLowerCase()) {
                    sourceLayout.children[i+1].toggle()
                }
            }
        }

        ButtonGroup {
            id: sourceButGroup
            Component.onCompleted: {
                if (typeof(sourceLayout.children.filter) === "function")
                    sourceButGroup.buttons = Qt.binding(function() {
                        return sourceLayout.children.filter(child => child instanceof RadioButton)}
                    )
                else
                    sourceButGroup.buttons = Qt.binding(function() { return sourceLayout.children })
            }
            onClicked: (but) => {
                base.source = but.text.toLowerCase()
            }
        }

        Label {
            text: "Source"
        }
        Repeater {
            model: base.sources
            RadioButton {
                required property string modelData
                text: modelData
            }
        }
    }
    RowLayout {
        id: maskLayout
        Component.onCompleted: {
            for (let i = 0; i < base.masks.length; i++) {
                if (mask.toLowerCase() === masks[i].toLowerCase()) {
                    maskLayout.children[i+1].toggle()
                }
            }
        }

        ButtonGroup {
            id: maskButGroup
            Component.onCompleted: {
                if (typeof(maskLayout.children.filter) === "function")
                    maskButGroup.buttons = Qt.binding(function() {
                        return maskLayout.children.filter(child => child instanceof RadioButton)}
                    )
                else
                    maskButGroup.buttons = Qt.binding(function() { return maskLayout.children })
            }
            onClicked: (but) => {
                base.mask = but.text.toLowerCase()
            }
        }

        Label {
            text: "Mask"
        }
        Repeater {
            model: base.masks
            RadioButton {
                required property string modelData
                text: modelData
            }
        }
    }
}

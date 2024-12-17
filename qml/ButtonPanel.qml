import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    id: top
    property var sources
    property var masks
    property string source
    property string mask

    RowLayout {
        id: sourceLayout
        Component.onCompleted: {
            for (let i = 0; i < sources.length; i++) {
                if (source.toLowerCase() === sources[i].toLowerCase()) {
                    sourceLayout.children[i+1].toggle()
                }
            }
        }

        ButtonGroup {
            buttons: sourceLayout.children
            onClicked: (but) => {
                top.source = but.text.toLowerCase()
            }
        }

        Label {
            text: "Source"
        }
        Repeater {
            model: sources
            RadioButton {
                text: sources[index]
            }
        }
    }
    RowLayout {
        id: maskLayout
        Component.onCompleted: {
            for (let i = 0; i < masks.length; i++) {
                if (mask.toLowerCase() === masks[i].toLowerCase()) {
                    maskLayout.children[i+1].toggle()
                }
            }
        }

        ButtonGroup {
            buttons: maskLayout.children
            onClicked: (but) => {
                console.log("but.text: " + but.text + " lower: " + but.text.toLowerCase())
                top.mask = but.text.toLowerCase()
            }
        }

        Label {
            text: "Mask"
        }
        Repeater {
            model: masks
            RadioButton {
                text: masks[index]
            }
        }
    }
}

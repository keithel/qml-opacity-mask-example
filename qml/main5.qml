/****************************************************************************
**
** Copyright (C) 2024 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 300
    height: 300
    visible: true

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    ColumnLayout {
        anchors.fill: parent
        visible: true

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: true

            Map {
                id: map
                anchors.fill: parent
                opacity: 0
                plugin: mapPlugin
                center: QtPositioning.coordinate(59.91, 10.75) // Oslo
                zoomLevel: 14
                Shortcut {
                    enabled: map.zoomLevel < map.maximumZoomLevel
                    sequence: StandardKey.ZoomIn
                    onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
                }
                Shortcut {
                    enabled: map.zoomLevel > map.minimumZoomLevel
                    sequence: StandardKey.ZoomOut
                    onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
                }
            }

            Image {
                id: bug
                anchors.fill: parent
                source: "images/bug.jpg"
                sourceSize: Qt.size(parent.width, parent.height)
                smooth: true
                visible: false
            }

            Image {
                id: butterflyMask
                anchors.fill: parent
                source: "images/butterfly.png"
                sourceSize: Qt.size(parent.width, parent.height)
                smooth: true
                visible: false
            }

            Rectangle {
                id: rectangleMask
                anchors.fill: parent
                radius: width/2
                visible: false
            }

            OpacityMask {
                id: opacityMask
                anchors.fill: bug
                source: bug
                maskSource: butterflyMask
            }
        }

        ButtonPanel {
            sources: [ "Bug", "Map" ]
            masks: [ "Butterfly", "Rectangle"]
            source: "bug"
            mask: "butterfly"
            onSourceChanged: {
                if (source === "bug")
                    opacityMask.source = bug
                else if (source === "map")
                    opacityMask.source = map
                else
                    console.log("No such source " + source)
            }
            onMaskChanged: {
                if (mask === "butterfly")
                {
                    opacityMask.maskSource = butterflyMask
                }
                else if (mask === "rectangle") {
                    opacityMask.maskSource = rectangleMask
                }
                else
                    console.log("No such mask " + mask)
            }
        }
    }
}

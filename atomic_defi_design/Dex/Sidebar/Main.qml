import QtQuick 2.12
import QtQuick.Layouts 1.15

import "../Components"
import "../Constants"
import Dex.Themes 1.0 as Dex

Item
{
    id: root

    enum LineType
    {
        Portfolio,
        Wallet,
        DEX,         // DEX == Trading page
        Addressbook,
        Support
    }

    property real   lineHeight: 44
    property var    currentLineType: Main.LineType.Portfolio
    property alias  _selectionCursor: _selectionCursor
    property bool   containsMouse: mouseArea.containsMouse

    signal lineSelected(var lineType)
    signal settingsClicked()
    signal supportClicked()
    signal addCryptoClicked()
    signal privacySwitched(var checked)

    width: 160
    height: parent.height

    // Background Rectangle
    DefaultRectangle
    {
        radius: 0
        anchors.fill: parent
        anchors.rightMargin : - border.width
        anchors.bottomMargin:  - border.width
        anchors.leftMargin: - border.width
        border.width: 1
        border.color: Dex.CurrentTheme.lineSeparatorColor
        color: Dex.CurrentTheme.sidebarBgColor
    }


    // Selection Cursor
    AnimatedRectangle
    {
        id: _selectionCursor

        y:
        {
            if (currentLineType === Main.LineType.Support) return bottom.y + lineHeight + bottom.spacing;
            else return center.y + currentLineType * (lineHeight + center.spacing);
        }

        anchors.left: parent.left
        anchors.leftMargin: 8
        radius: 16
        width: parent.width - 8
        height: lineHeight

        opacity: .7

        gradient: Gradient
        {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.125; color: Dex.CurrentTheme.sidebarCursorStartColor }
            GradientStop { position: 0.933; color: Dex.CurrentTheme.sidebarCursorEndColor }
        }

        Behavior on y
        {
            NumberAnimation { duration: 180 }
        }
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        ColumnLayout
        {
            spacing: 0
            anchors.fill: parent
            Top
            {
                id: top
                width: parent.width
                Layout.alignment: Qt.AlignHCenter
            }

            Item // Spacer
            {
                Layout.fillHeight: true
            }

            Center
            {
                id: center
                width: parent.width
                onLineSelected:
                {
                    if (currentLineType === lineType)
                        return;
                    currentLineType = lineType;
                    root.lineSelected(lineType);
                }
            }

            Bottom
            {
                id: bottom
                width: parent.width
                onAddCryptoClicked: root.addCryptoClicked()
                onSettingsClicked: root.settingsClicked()
                onSupportClicked: root.supportClicked()
            }
        }
    }
}

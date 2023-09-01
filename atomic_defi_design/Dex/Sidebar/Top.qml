import QtQuick 2.12

import "../Components"
import "../Constants"
import App 1.0
import Dex.Themes 1.0 as Dex

MouseArea
{
    id: root
    hoverEnabled: true
    width: parent.width
    height: 200

    DefaultImage
    {
        id: dexLogo
        anchors.horizontalCenter: parent.horizontalCenter

        Component.onCompleted:
        {
            sourceSize.width = 190
            source = Dex.CurrentTheme.bigLogoPath
            scale = .8
        }

        Connections
        {
            target: Dex.CurrentTheme
            function onThemeChanged()
            {
                dexLogo.source = Dex.CurrentTheme.bigLogoPath
            }
        }
    }

    DefaultText
    {
        id: versionLabel
        anchors.horizontalCenter: dexLogo.horizontalCenter
        anchors.top: dexLogo.bottom
        anchors.topMargin: 25

        text_value: General.version_string
        font: DexTypo.caption
        color: Dex.CurrentTheme.sidebarVersionTextColor

        Component.onCompleted: opacity = 1
    }
}

import QtQuick 2.12
import QtQuick.Layouts 1.2

import App 1.0
import "../Components"
import "../Constants"
import Dex.Themes 1.0 as Dex

MouseArea
{
    property alias spacing: _columnLayout.spacing

    signal lineSelected(var lineType)

    height: lineHeight * 5
    hoverEnabled: true

    // Selection List
    ColumnLayout
    {
        id: _columnLayout
        width: parent.width
        height: parent.height
        spacing: 0
        FigurativeLine
        {
            id: _portfolioLine

            Layout.fillWidth: true
            type: Main.LineType.Portfolio
            label.text: qsTr("Portfolio")
            icon.source: General.image_path + "menu-assets-portfolio.svg"
            onClicked: lineSelected(type)
        }

        FigurativeLine
        {
            id: _walletLine

            Layout.fillWidth: true
            type: Main.LineType.Wallet
            label.text: qsTr("Wallet")
            icon.source: General.image_path + "menu-assets-white.svg"
            onClicked: lineSelected(type)
        }

        FigurativeLine
        {
            id: _dexLine

            Layout.fillWidth: true
            type: Main.LineType.DEX
            label.text: qsTr("DEX")
            icon.source: General.image_path + "menu-exchange-white.svg"
            onClicked: lineSelected(type)
        }

        FigurativeLine
        {
            id: _addressBookLine

            Layout.fillWidth: true
            type: Main.LineType.Addressbook
            label.text: qsTr("Address Book")
            icon.source: General.image_path + "menu-news-white.svg"
            onClicked: lineSelected(type)
        }

        FigurativeLine
        {
            id: _fiatLine

            label.enabled: false
            icon.enabled: false
            Layout.fillWidth: true
            label.text: qsTr("Fiat")
            icon.source: General.image_path + "bill.svg"
        }
    }
}

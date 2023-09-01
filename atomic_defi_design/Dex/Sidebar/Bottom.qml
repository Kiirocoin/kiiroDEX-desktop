import QtQuick 2.12
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.15
import App 1.0
import Dex.Themes 1.0 as Dex

import "../Components"
import "../Constants"

MouseArea
{
    id: root

    signal addCryptoClicked()
    signal supportClicked()
    signal settingsClicked()

    height: lineHeight * 4
    hoverEnabled: true
    propagateComposedEvents: true


    ColumnLayout
    {
        anchors.fill: parent
        height: parent.height
        spacing: 0
        FigurativeLine
        {
            id: addCryptoLine

            Layout.fillWidth: true
            label.text: qsTr("Add Crypto")
            icon.source: General.image_path + "bank-plus.svg"
            onClicked: addCryptoClicked()
        }
        FigurativeLine
        {
            id: settingsLine

            Layout.fillWidth: true
            label.text: qsTr("Settings")
            icon.source: General.image_path + "menu-settings-white.svg"
            onClicked: settingsClicked()
        }
        FigurativeLine
        {
            id: supportLine

            Layout.fillWidth: true
            label.text: qsTr("Support")
            icon.source: General.image_path + "menu-support-white.png"
            onClicked: supportClicked(type)
        }

        Line
        {
            id: privacyLine

            Layout.fillWidth: true
            label.text: qsTr("Privacy")

            onClicked:
            {
                if (General.privacy_mode) {
                    privacySwitch.checked = true
                    var wallet_name = API.app.wallet_mgr.wallet_default_name
                    
                    let dialog = app.getText(
                    {
                        title: qsTr("Disable Privacy?"),
                        text: qsTr("Enter wallet password to confirm"),
                        standardButtons: Dialog.Yes | Dialog.Cancel,
                        closePolicy: Popup.NoAutoClose,
                        warning: true,
                        iconColor: Dex.CurrentTheme.warningColor,
                        isPassword: true,
                        placeholderText: qsTr("Type password"),
                        yesButtonText: qsTr("Confirm"),
                        cancelButtonText: qsTr("Cancel"),

                        onAccepted: function(text)
                        {
                            if (API.app.wallet_mgr.confirm_password(wallet_name, text))
                            {
                                General.privacy_mode = false;
                                privacySwitch.checked = false
                                app.showDialog(
                                {
                                    title: qsTr("Privacy status"),
                                    text: qsTr("Privacy mode disabled successfully"),
                                    yesButtonText: qsTr("Ok"), titleBold: true,
                                    showCancelBtn: false,
                                    standardButtons: Dialog.Ok
                                })
                            }
                            else
                            {
                                app.showDialog(
                                {
                                    title: qsTr("Wrong password!"),
                                    text: "%1 ".arg(wallet_name) + qsTr("wallet password is incorrect"),
                                    warning: true,
                                    showCancelBtn: false,
                                    standardButtons: Dialog.Ok, titleBold: true,
                                    yesButtonText: qsTr("Ok"),
                                })
                            }
                            dialog.close()
                            dialog.destroy()
                        }
                    })
                }
                else {
                    General.privacy_mode = true;
                    privacySwitch.checked = true
                }
            }

            DefaultSwitch
            {
                id: privacySwitch

                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                scale: 0.5
                mouseArea.hoverEnabled: true
                onClicked: parent.clicked()
            }
        }
    }
}

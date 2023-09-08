import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import Qaterial 1.0 as Qaterial

import Dex.Themes 1.0 as Dex
import "../../../Constants"
import "../../../Components"
import "../../Trade"
import "../../ProView"
// Best Order
import "../../Trade/BestOrder/" as BestOrder

Widget
{
    width: 450
    property alias currentIndex: tabView.currentIndex
    collapsable: false
    header: null
    background: null
    margins: 0

    Connections
    {
        target: exchange_trade
        function onOrderSelected() { tabView.currentIndex = 0; }
    }

    Qaterial.LatoTabBar
    {
        id: tabView
        property int pair_chart_idx: 0
        property int order_idx: 1
        property int history_idx: 2
        background: null
        Layout.margins: 0

        Qaterial.LatoTabButton
        {
            text: qsTr("Chart")
            font.pixelSize: 14
            textColor: checked ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            textSecondaryColor: Dex.CurrentTheme.foregroundColor2
            indicatorColor: Dex.CurrentTheme.foregroundColor
        }
        Qaterial.LatoTabButton
        {
            text: qsTr("Orders")
            font.pixelSize: 14
            textColor: checked ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            textSecondaryColor: Dex.CurrentTheme.foregroundColor2
            indicatorColor: Dex.CurrentTheme.foregroundColor
        }
        Qaterial.LatoTabButton
        {
            text: qsTr("History")
            font.pixelSize: 14
            textColor: checked ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            textSecondaryColor: Dex.CurrentTheme.foregroundColor2
            indicatorColor: Dex.CurrentTheme.foregroundColor
        }
    }

    Rectangle
    {
        Layout.fillHeight: true
        width: parent.width
        color: 'red' // Dex.CurrentTheme.floatingBackgroundColor
        radius: 10

        Qaterial.SwipeView
        {
            id: swipeView
            clip: true
            interactive: false
            currentIndex: tabView.currentIndex
            width: 450
            Layout.fillHeight: true

            ColumnLayout
            {
                spacing: 0
                height: parent.height
                // Chart
                Chart
                {
                    id: chart
                    width: 450
                    height: 245
                }
                // Price comparison to CEX
//                PriceLineSimplified
//                {
//                    id: price_line
//                    width: 450
//                    height: 120
//                }
                // Best Orders
                BestOrder.List
                {
                    id: bestOrders
                    width: 440
                    Layout.minimumHeight: 300
                    Layout.fillHeight: true
                }
            }

            onCurrentIndexChanged:
            {
                swipeView.currentItem.update();
            }

            OrdersPage
            {
                clip: true
                width: 440
                height: 400
            }

            OrdersPage
            {
                height: parent.height
                width: parent.width
                is_history: true
                clip: true
            }
        }
    }
}

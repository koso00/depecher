import QtQuick 2.0
import Sailfish.Silica 1.0
import tdlibQtEnums 1.0
import TelegramModels 1.0
import QtGraphicalEffects 1.0
import "items"
import "components"

Page {
    id: page
    allowedOrientations: Orientation.All

    property string titleHeader: "Depecher"
    //for search in pageStack
    property bool __chat_page: true
    property string _opened_chat_id: ""
    Connections {
        target: c_telegramWrapper
        onErrorReceivedMap: {
            if(errorObject["code"] === 401)
                pageStack.replace(Qt.resolvedUrl("AuthorizeDialog.qml"),{},PageStackAction.Immediate)
        }
    }
    onStatusChanged: {
        if (status == PageStatus.Active)
            if(c_telegramWrapper.authorizationState == TdlibState.AuthorizationStateWaitPhoneNumber)
                pageStack.replace(Qt.resolvedUrl("AuthorizeDialog.qml"),{},PageStackAction.Immediate)

    }

    SilicaListView {
        quickScroll: true;
        anchors.fill: parent;
        header: PageHeader{
            title:qsTr("Telegram")
        }
        PullDownMenu {

            MenuItem {
                text:qsTr("Reset dialogs")
                onClicked: chatsModel.reset()
            }
            MenuItem {
                text:qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text:qsTr("Contacts")
                onClicked: pageStack.push(Qt.resolvedUrl("ContactsPage.qml"))
            }
        }
        model:   ChatsModel {
            id:chatsModel
        }
        delegate:
            ListItem {
            id: delegateChat;
            width : parent.width
            height : 150 + Theme.paddingLarge
            anchors {
                leftMargin:  Theme.paddingLarge
                bottomMargin: Theme.paddingLarge
            }
            Rectangle {
                width:150
                height: 150
                id: fallbackitem
                anchors.top : parent.top
                anchors.leftMargin:  Theme.paddingLarge
                anchors.left : parent.left
                color: Theme.highlightBackgroundColor
                opacity:       photo ? 0 : 1
                //radius: width * 0.5
                Label {
                    id: fallbacktext
                    font { bold: true; pixelSize: Theme.fontSizeLarge }
                    anchors.centerIn: parent
                    color: Theme.primaryColor
                    text : title.charAt(0)
                }
            }
            Image {
                asynchronous : true
                id: avatar
                width:150
                height: 150
                visible: photo ? true : false
                anchors.top : parent.top
                anchors.left : parent.left
                anchors.leftMargin:  Theme.paddingLarge
                property bool rounded: true
                property bool adapt: true
                source: photo ? "image://depecherDb/"+photo : ""
                //fallbackText: title.charAt(0)
                //fallbackItemVisible: photo ? false : true
                layer.enabled: rounded
                /* layer.effect: OpacityMask {
                    cached :true
                    maskSource: Item {
                        width: 150
                        height:150
                        Rectangle {
                            anchors.centerIn: parent
                            width: 150
                            height: 150
                            radius: 150
                        }
                    }
                }*/
            }

            Label {
                width : parent.width - (topRightInfo.width + Theme.paddingLarge * 4 + 150)
                id: titleLabel
                anchors {
                    top : parent.top
                    left :fallbackitem.right
                    leftMargin:  Theme.paddingLarge
                }
                font.pixelSize: 50
                text : title
            }
            Image {
                anchors.top : parent.top
                anchors.left : titleLabel.right
                //anchors.leftMargin: Theme.paddingLarge
                id: iconMute
                source: mute_for > 0  ? "image://theme/icon-m-speaker-mute?"
                                        +  "gray" :
                                        ""
                visible: mute_for > 0
                height: 50
                width: implicitWidth
                asynchronous : true
                fillMode: Image.PreserveAspectFit
            }
            Row {
                id : topRightInfo
                anchors {
                    right : parent.right
                    rightMargin: Theme.paddingLarge
                    top : parent.top
                }
                spacing: Theme.paddingMedium
                width : is_outgoing ?  sending_state_icon_.width + Theme.paddingMedium + messageTimestamp.width :  messageTimestamp.width

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    id : sending_state_icon_
                    font.pixelSize: Theme.fontSizeTiny
                    width: implicitWidth
                    color: Theme.secondaryColor
                    visible: is_outgoing
                    text: sending_state_icon
                }

                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    id:messageTimestamp
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 40
                    color: Theme.secondaryColor
                    text: date
                }
            }




            Row {
                id : leftBottomInfo
                spacing : Theme.paddingMedium
                anchors {
                    right : parent.right
                    rightMargin: Theme.paddingLarge
                    bottom : parent.bottom
                }
                //width : mentionWrapper.width + counterWrapper.width + iconPinned.width
                Rectangle{
                    id:mentionWrapper
                    color: pressed ? Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity*2) : Theme.highlightBackgroundColor
                    radius: 90
                    width: visible ? Math.max(60,mention.width+Theme.paddingMedium*2) : 0
                    height: 60
                    visible: unread_mention_count > 0 ? true : false
                    Label{
                        id:mention
                        text:"@"
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeTiny
                        color: Theme.primaryColor
                    }
                }
                Rectangle{
                    id:counterWrapper
                    property bool muted: mute_for > 0
                    color: pressed ? Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity*2) : backgroundColor
                    property color backgroundColor: muted ? Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity) :Theme.highlightBackgroundColor
                    radius: 90
                    width: visible ? Math.max(60,counter.width+Theme.paddingMedium*2) : 0
                    height: 60
                    visible: unread_count > 0 || is_marked_unread
                    Label{
                        id:counter
                        text:is_marked_unread ? "" : unread_count
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeTiny
                        color: Theme.primaryColor
                    }
                }

                Image {
                    id: iconPinned
                    source: is_pinned ? "image://theme/icon-s-task?"+ Theme.primaryColor :
                                        ""
                    visible: unread_count == 0
                    width: implicitWidth
                    fillMode: Image.PreserveAspectFit
                    asynchronous : true
                }
                /*
                Image {
                    id: iconSponsored
                    source:  "image://theme/icon-m-favorite?ffffff"
                    visible: is_sponsored
                    height: 50
                    width: implicitWidth
                    //fillMode: Image.PreserveAspectFit
                    asynchronous : true
                }*/
            }
            Row {
                width : parent.width - 150 - Theme.paddingLarge * 3 - leftBottomInfo.width
                anchors {
                    bottom : fallbackitem.bottom
                    left :fallbackitem.right
                    leftMargin:  Theme.paddingLarge
                }
                spacing: Theme.paddingMedium
                Label {
                    id:lastMessageAuthor
                    color: Theme.secondaryHighlightColor
                    text: last_message_author+":"
                    font.pixelSize: Theme.fontSizeExtraSmall
                    visible: type == TdlibState.BasicGroup || type==TdlibState.Supergroup ? true : false
                    width: implicitWidth
                }
                Label {
                    //width:lastMessageAuthor.width == 0 ?parent.width - mentions.width  : parent.width  - lastMessageAuthor.width - mentions.width  - parent.spacing
                    text:action ?  action : last_message ? last_message : ""
                    font.pixelSize: Theme.fontSizeExtraSmall
                    maximumLineCount: 1
                    truncationMode:TruncationMode.Fade
                    color: Theme.primaryColor
                    width : parent.width - lastMessageAuthor.width - Theme.paddingMedium
                }
            }

            /*Row {

                width:parent.width - Theme.paddingLarge * 3 - 150
*/

               /* Row{
                    id: mentions
                    height: 100
                    spacing: Theme.paddingSmall*/




               // }
            //}
            /*
            menu:  ContextMenu {
                id : contextMenu
                MenuItem {
                    text: mute_for > 0 ? qsTr("Unmute") : qsTr("Mute")
                    onClicked: chatsModel.changeNotificationSettings(id,!(mute_for > 0))
                }
                MenuItem {
                    text: is_marked_unread ? qsTr("Mark as read") : qsTr("Mark as unread")
                    onClicked: chatsModel.markAsUnread(id,!is_marked_unread)
                }
            }*/

            onClicked:{
                var page = pageStack.find(function (page) {
                    return page.__messaging_page !== undefined
                });
                if(_opened_chat_id !== id)
                {
                    _opened_chat_id = id
                    if(is_marked_unread)
                        chatsModel.markAsUnread(id,false)
                    pageStack.pushAttached("MessagingPage.qml",{chatId:id})
                }
                pageStack.navigateForward()
            }
        }/*ChatItem {
                id: chatDelegate
                anchors.top : sibling.bottom

                ListView.onAdd: AddAnimation {
                    target: chatDelegate
                }

                ListView.onRemove: RemoveAnimation {
                    target: chatDelegate
                }


            }*/
        VerticalScrollDecorator { flickable: parent; }
    }

}





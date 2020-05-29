import QtQuick 2.0
import Sailfish.Silica 1.0
import tdlibQtEnums 1.0 //org.blacksailer.depecher.sharechat
import "../../js/utils.js" as Utils
import "../items"

ListItem {
    id : item
    width:parent.width
    height : 160

    CircleImage {
        asynchronous : true
        id: avatar
        width:height
        height: 150
        anchors.top : parent.top
        anchors.left : parent.left
        source: photo ? "image://depecherDb/"+photo : ""
        //fallbackText: title.charAt(0)
        fallbackItemVisible: photo ? false : true
    }
    Label {
        //title
        id : titleLabel
        anchors.top : parent.top
        anchors.left : avatar.right
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeSmall
        text: title
        truncationMode: TruncationMode.Fade
    }
    Label{
        id:messageTimestamp
        anchors.top : titleLabel.bottom
        anchors.left : avatar.right
        horizontalAlignment: Text.AlignRight
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.secondaryColor
        text: date
    }
     /*Column{
        //title,date,text
        //icon-m-speaker-mute
        //width:parent.width-avatar.width-parent.spacing
        height: 200
        Row {
            width:parent.width
            height: 100
            spacing: Theme.paddingSmall
            Row {
                //width:parent.width - iconGroup.width - messageTimestamp.width - parent.spacing
                height:100

                /*Image {
                    id: iconSponsored
                    source: mute_for > 0  ? "image://theme/icon-m-favorite?"
                                            +  "gray" :
                                            ""
                    visible: is_sponsored
                    height: Theme.fontSizeSmall
                    anchors.verticalCenter: parent.verticalCenter
                    width: implicitWidth
                    fillMode: Image.PreserveAspectFit
                    asynchronous : true
                }
                Image {
                    id: iconMute
                    source: mute_for > 0  ? "image://theme/icon-m-speaker-mute?"
                                            +  "gray" :
                                            ""
                    visible: mute_for > 0
                    height: Theme.fontSizeSmall
                    anchors.verticalCenter: parent.verticalCenter
                    width: implicitWidth
                    fillMode: Image.PreserveAspectFit
                }
            }

        }
        Row {
            width:parent.width
            height: 100
            spacing: Theme.paddingSmall
           Label {
                id:lastMessageAuthor
                anchors.verticalCenter: parent.verticalCenter
                color:pressed ? Theme.highlightColor : Theme.secondaryHighlightColor
                text: last_message_author+":"
                font.pixelSize: Theme.fontSizeExtraSmall
                visible: action ? false : type == TdlibState.BasicGroup || type==TdlibState.Supergroup ? true : false
                width: implicitWidth
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                width:lastMessageAuthor.width == 0 ?parent.width - mentions.width  : parent.width  - lastMessageAuthor.width - mentions.width  - parent.spacing
                text:action ?  action : last_message ? last_message : ""
                font.pixelSize: Theme.fontSizeExtraSmall
                maximumLineCount: 1
                truncationMode:TruncationMode.Fade
                color: Theme.primaryColor
            }
            Row{
                id: mentions
                height: 100
                spacing: Theme.paddingSmall
                Label {
                    font.pixelSize: Theme.fontSizeTiny
                    width: implicitWidth
                    color:pressed ? Theme.secondaryHighlightColor : Theme.secondaryColor
                    visible: !(type["type"] == TdlibState.Supergroup && type["is_channel"])
                    anchors.verticalCenter: counterWrapper.verticalCenter
                    text: sending_state_icon
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
                Rectangle{
                    id:mentionWrapper
                    color: pressed ? Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity*2) : Theme.highlightBackgroundColor
                    radius: 90
                    width: Theme.paddingSmall*2
                    height: 100
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

                    width: visible ? Math.max(50,counter.width+Theme.paddingSmall*2) : 0
                    height: 100
                    visible: unread_count > 0 || is_marked_unread
                    Label{
                        id:counter
                        text:is_marked_unread ? "" : unread_count
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeTiny
                        color: Theme.primaryColor
                    }
                }
            }

        }

    }*/


}


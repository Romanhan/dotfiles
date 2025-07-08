import "Components"
import QtGraphicalEffects 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Pane {
    id: root

    property color selectedText: Qt.lighter(root.palette.highlight, 2)
    property color selectionColor: Qt.lighter(Qt.rgba(root.palette.highlight.r, root.palette.highlight.g, root.palette.highlight.b, 0.5))
    property bool leftleft: config.HaveFormBackground == "true" && config.PartialBlur == "false" && config.FormPosition == "left" && config.BackgroundImageHAlignment == "left"
    property bool leftcenter: config.HaveFormBackground == "true" && config.PartialBlur == "false" && config.FormPosition == "left" && config.BackgroundImageHAlignment == "center"
    property bool rightright: config.HaveFormBackground == "true" && config.PartialBlur == "false" && config.FormPosition == "right" && config.BackgroundImageHAlignment == "right"
    property bool rightcenter: config.HaveFormBackground == "true" && config.PartialBlur == "false" && config.FormPosition == "right" && config.BackgroundImageHAlignment == "center"

    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.ScreenWidth
    LayoutMirroring.enabled: config.ForceRightToLeft == "true" ? true : Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true
    padding: config.ScreenPadding
    palette.button: "transparent"
    palette.highlight: config.AccentColor
    palette.text: config.MainColor
    palette.buttonText: config.MainColor
    palette.window: config.BackgroundColor
    font.family: config.Font
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80)
    focus: true

    Item {
        id: sizeHelper

        anchors.fill: parent
        height: parent.height
        width: parent.width

        Rectangle {
            id: tintLayer

            anchors.fill: parent
            width: parent.width
            height: parent.height
            color: "black"
            opacity: config.DimBackgroundImage
            z: 1
        }

        Rectangle {
            id: formBackground

            anchors.fill: form
            anchors.centerIn: form
	    color: config.PartialBlur == "true" ? "transparent" : "#43434380" // Semi-transparent white
            visible: config.HaveFormBackground == "true" ? true : false
            opacity: config.PartialBlur == "true" ? 0.3 : 1
            z: 1


	    // Add border properties
	    border.color: "#40FFFFFF" // Semi-transparent white border
	    border.width: 2
	    radius: 25 // Rounded corners
    
	    // Add drop shadow effect
	    layer.enabled: true
	    layer.effect: DropShadow {
	    horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            color: "#40000000" // Semi-transparent black shadow
            transparentBorder: true
	}

        }

        LoginForm {
            id: form

            height: parent.height * 0.8
            width: parent.width / 3.5
            anchors.horizontalCenter: config.FormPosition == "center" ? parent.horizontalCenter : undefined
	    anchors.verticalCenter: parent.verticalCenter
            anchors.left: config.FormPosition == "left" ? parent.left : undefined
            anchors.right: config.FormPosition == "right" ? parent.right : undefined
	    anchors.rightMargin: config.FormPosition == "right" ? 50 : 0
            z: 1
        }

        Image {
            id: backgroundImage

            height: parent.height
            width: config.HaveFormBackground == "true" && config.FormPosition != "center" && config.PartialBlur != "true" ? parent.width - formBackground.width : parent.width
            anchors.left: leftleft || leftcenter ? formBackground.right : undefined
            anchors.right: rightright || rightcenter ? formBackground.left : undefined
            horizontalAlignment: config.BackgroundImageHAlignment == "left" ? Image.AlignLeft : config.BackgroundImageHAlignment == "right" ? Image.AlignRight : Image.AlignHCenter
            verticalAlignment: config.BackgroundImageVAlignment == "top" ? Image.AlignTop : config.BackgroundImageVAlignment == "bottom" ? Image.AlignBottom : Image.AlignVCenter
            source: config.background || config.Background
            fillMode: config.ScaleImageCropped == "true" ? Image.PreserveAspectCrop : Image.PreserveAspectFit
            asynchronous: true
            cache: true
            clip: true
            mipmap: true
        }

        MouseArea {
            anchors.fill: backgroundImage
            onClicked: parent.forceActiveFocus()
        }

        ShaderEffectSource {
            id: blurMask

            sourceItem: backgroundImage
            width: form.width
            height: parent.height
            anchors.centerIn: form
            sourceRect: Qt.rect(x, y, width, height)
            visible: config.FullBlur == "true" || config.PartialBlur == "true" ? true : false
        }

        GaussianBlur {
            id: blur

            height: parent.height
            width: config.FullBlur == "true" ? parent.width : form.width
            source: config.FullBlur == "true" ? backgroundImage : blurMask
            radius: config.BlurRadius
            samples: config.BlurRadius * 2 + 1
            cached: true
            anchors.centerIn: config.FullBlur == "true" ? parent : form
            visible: config.FullBlur == "true" || config.PartialBlur == "true" ? true : false
        }

    }

}

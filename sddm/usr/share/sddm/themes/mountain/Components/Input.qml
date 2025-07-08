import QtGraphicalEffects 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Column {
    id: inputContainer

    property Control exposeSession: sessionSelect.exposeSession
    property bool failed

    Layout.fillWidth: true

    // Constants for consistent sizing
    readonly property real fieldHeight: root.font.pointSize * 4.5
    readonly property real inputHeight: root.font.pointSize * 3.5
    readonly property real fieldWidth: parent.width / 2
    readonly property real smallFontSize: root.font.pointSize * 0.8
    readonly property int animationDuration: 150

    // Common styling properties
    readonly property color borderColor: root.palette.text
    readonly property color highlightTextColor: root.palette.highlight.hslLightness >= 0.7 ? "#444" : "white"
    readonly property color normalTextColor: root.palette.window.hslLightness >= 0.8 ? 
        (root.palette.highlight.hslLightness >= 0.8 ? "#444" : root.palette.highlight) : "white"

    Item {
        id: usernameField
        height: fieldHeight
        width: fieldWidth
        anchors.horizontalCenter: parent.horizontalCenter

        ComboBox {
            id: selectUser
            
            readonly property var popkey: config.ForceRightToLeft == "true" ? Qt.Key_Right : Qt.Key_Left

            displayText: ""
            width: parent.height
            height: parent.height
            anchors.left: parent.left
            z: 2
            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"
            hoverEnabled: true
            
            KeyNavigation.down: username
            KeyNavigation.right: username
            
            Keys.onPressed: {
                if (event.key == Qt.Key_Down && !popup.opened)
                    username.forceActiveFocus();
                if ((event.key == Qt.Key_Up || event.key == popkey) && !popup.opened)
                    popup.open();
            }
            
            onActivated: username.text = currentText

            states: [
                State {
                    name: "pressed"
                    when: selectUser.down
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: borderColor
                    }
                },
                State {
                    name: "hovered"
                    when: selectUser.hovered
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: root.selectedText
                    }
                },
                State {
                    name: "focused"
                    when: selectUser.activeFocus
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: root.selectedText
                    }
                }
            ]
            
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "color, border.color, icon.color"
                        duration: animationDuration
                    }
                }
            ]

            delegate: ItemDelegate {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                highlighted: parent.highlightedIndex === index

                contentItem: Text {
                    text: model.name
                    font.pointSize: smallFontSize
                    font.capitalization: Font.Capitalize
                    color: selectUser.highlightedIndex === index ? highlightTextColor : normalTextColor
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background: Rectangle {
                    color: selectUser.highlightedIndex === index ? root.palette.highlight : "transparent"
                }
            }

            indicator: Button {
                id: usernameIcon
                width: selectUser.height * 0.8
                height: parent.height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: selectUser.height * 0.125
                icon.height: parent.height * 0.25
                icon.width: parent.height * 0.25
                enabled: false
                icon.color: borderColor
                icon.source: Qt.resolvedUrl("../Assets/User.svgz")
            }

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            popup: Popup {
                y: parent.height - username.height / 3
                x: config.ForceRightToLeft == "true" ? -loginButton.width + selectUser.width : 0
                rightMargin: config.ForceRightToLeft == "true" ? root.padding + usernameField.width / 2 : undefined
                width: usernameField.width
                implicitHeight: contentItem.implicitHeight
                padding: 10

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight + 20
                    model: selectUser.popup.visible ? selectUser.delegateModel : null
                    currentIndex: selectUser.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    radius: config.RoundCorners / 2
                    color: root.palette.window
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 10 * config.InterfaceShadowSize
                        radius: 20 * config.InterfaceShadowSize
                        samples: 41 * config.InterfaceShadowSize
                        cached: true
                        color: Qt.hsla(0, 0, 0, config.InterfaceShadowOpacity)
                    }
                }

                enter: Transition {
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                    }
                }
            }
        }

        TextField {
            id: username
            color: root.palette.text
            selectedTextColor: root.selectedText
            selectionColor: root.selectionColor
            text: config.ForceLastUser == "true" ? selectUser.currentText : ""
            font.capitalization: config.AllowBadUsernames == "false" ? Font.Capitalize : Font.MixedCase
            anchors.centerIn: parent
            height: inputHeight
            width: parent.width
            placeholderText: config.TranslatePlaceholderUsername || textConstants.userName
            selectByMouse: true
            horizontalAlignment: TextInput.AlignHCenter
            renderType: Text.QtRendering
            z: 1
            
            KeyNavigation.down: password
            
            onFocusChanged: {
                if (focus) selectAll();
            }
            onAccepted: loginButton.clicked()

            background: Rectangle {
                color: "transparent"
                border.color: borderColor
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }
        }
    }

    Item {
        id: passwordField
        height: fieldHeight
        width: fieldWidth
        anchors.horizontalCenter: parent.horizontalCenter
        
        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color"
                    duration: animationDuration
                }
            }
        ]

        TextField {
            id: password
            color: root.palette.text
            selectedTextColor: root.selectedText
            selectionColor: root.selectionColor
            anchors.centerIn: parent
            height: inputHeight
            width: parent.width
            focus: config.ForcePasswordFocus == "true"
            selectByMouse: true
            echoMode: revealSecret.checked ? TextInput.Normal : TextInput.Password
            placeholderText: config.TranslatePlaceholderPassword || textConstants.password
            horizontalAlignment: TextInput.AlignHCenter
            passwordCharacter: "•"
            passwordMaskDelay: config.ForceHideCompletePassword == "true" ? undefined : 1000
            renderType: Text.QtRendering
            
            KeyNavigation.down: revealSecret
            onAccepted: loginButton.clicked()

            background: Rectangle {
                color: "transparent"
                border.color: borderColor
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }
        }
    }

    Item {
        id: secretCheckBox
        height: root.font.pointSize * 4
        width: fieldWidth
        anchors.horizontalCenter: parent.horizontalCenter
        
        states: [
            State {
                name: "hovered"
                when: revealSecret.hovered
                PropertyChanges {
                    target: indicatorLabel
                    color: root.selectedText
                }
            }
        ]
        
        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color, opacity"
                    duration: animationDuration
                }
            }
        ]

        CheckBox {
            id: revealSecret
            width: parent.width
            hoverEnabled: true
            
            KeyNavigation.down: loginButton
            
            Keys.onReturnPressed: toggle()
            Keys.onEnterPressed: toggle()

            indicator: Rectangle {
                id: indicator
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 3
                anchors.leftMargin: 4
                implicitHeight: root.font.pointSize
                implicitWidth: root.font.pointSize
                color: "transparent"
                border.color: borderColor
                border.width: parent.activeFocus ? 2 : 1

                Rectangle {
                    id: dot
                    anchors.centerIn: parent
                    implicitHeight: parent.width - 6
                    implicitWidth: parent.width - 6
                    color: borderColor
                    opacity: revealSecret.checked ? 1 : 0
                }
            }

            contentItem: Text {
                id: indicatorLabel
                text: config.TranslateShowPassword || "Show Password"
                anchors.verticalCenter: indicator.verticalCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: indicator.right
                anchors.leftMargin: indicator.width / 2
                font.pointSize: smallFontSize
                color: borderColor
            }
        }
    }

    Item {
        height: root.font.pointSize * 2.3
        width: fieldWidth
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: errorMessage
            width: parent.width
            text: failed ? 
                (config.TranslateLoginFailedWarning || textConstants.loginFailed + "!") :
                (keyboard.capsLock ? (config.TranslateCapslockWarning || textConstants.capslockWarning) : "")
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: smallFontSize
            font.bold: true
            color: borderColor
            opacity: 0
            
            states: [
                State {
                    name: "visible"
                    when: failed || keyboard.capsLock
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                }
            ]
            
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 100
                    }
                }
            ]
        }
    }

    Item {
        id: login
        height: fieldHeight
        width: fieldWidth
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            id: loginButton
            opacity: 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            text: config.TranslateLogin || textConstants.login
            height: inputHeight
            implicitWidth: parent.width
            enabled: config.AllowEmptyPassword == "true" || (username.text !== "" && password.text !== "")
            hoverEnabled: true
            
            KeyNavigation.down: sessionSelect.exposeSession
            
            Keys.onReturnPressed: clicked()
            Keys.onEnterPressed: clicked()
            
            onClicked: {
                const user = config.AllowBadUsernames == "false" ? username.text.toLowerCase() : username.text;
                sddm.login(user, password.text, sessionSelect.selectedSession);
            }

            states: [
                State {
                    name: "hovered"
                    when: loginButton.hovered
                    PropertyChanges {
                        target: loginButton.contentItem
                        color: root.selectedText
                    }
                    PropertyChanges {
                        target: buttonBackground
                        border.width: root.font.pointSize / 5
                    }
                },
                State {
                    name: "focused"
                    when: loginButton.activeFocus
                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                    }
                },
                State {
                    name: "enabled"
                    when: loginButton.enabled
                    PropertyChanges {
                        target: buttonBackground
                        color: root.palette.highlight
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                    }
                }
            ]
            
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity, color, border.width"
                        duration: 300
                    }
                }
            ]

            contentItem: Text {
                text: parent.text
                color: config.OverrideLoginButtonTextColor || highlightTextColor
                font.pointSize: root.font.pointSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: 0.9
            }

            background: Rectangle {
                id: buttonBackground
                color: root.selectionColor
                border.color: borderColor
                radius: config.RoundCorners || 0
            }
        }
    }

    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
        loginButtonWidth: loginButton.background.width
    }

    Connections {
        target: sddm
        onLoginSucceeded: {
            // Login successful - could add success feedback here
        }
        onLoginFailed: {
            failed = true;
            resetError.running ? resetError.restart() : resetError.start();
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

RowLayout {
    property var suspend: ["Suspend", config.TranslateSuspend || textConstants.suspend, sddm.canSuspend]
    property var hibernate: ["Hibernate", config.TranslateHibernate || textConstants.hibernate, sddm.canHibernate]
    property var restart: ["Restart", config.TranslateRestart || textConstants.reboot, sddm.canReboot]
    property var shutdown: ["Shutdown", config.TranslateShutdown || textConstants.shutdown, sddm.canPowerOff]
    property Control exposedSession

    spacing: root.font.pointSize

    Repeater {
        id: systemButtons

        model: [suspend, hibernate, restart, shutdown]

        RoundButton {
            text: modelData[1]
            font.pointSize: root.font.pointSize * 0.8
            Layout.alignment: Qt.AlignHCenter
            icon.source: modelData ? Qt.resolvedUrl("../Assets/" + modelData[0] + ".svgz") : ""
            icon.height: 2 * Math.round((root.font.pointSize * 3) / 2)
            icon.width: 2 * Math.round((root.font.pointSize * 3) / 2)
            display: AbstractButton.TextUnderIcon
            visible: config.ForceHideSystemButtons != "true" && modelData[2]
            hoverEnabled: true
            palette.buttonText: root.palette.text
            Keys.onReturnPressed: clicked()
            onClicked: {
                parent.forceActiveFocus();
                index == 0 ? sddm.suspend() : index == 1 ? sddm.hibernate() : index == 2 ? sddm.reboot() : sddm.powerOff();
            }
            KeyNavigation.up: exposedSession
            KeyNavigation.left: parent.children[index - 1]
            states: [
                State {
                    name: "pressed"
                    when: parent.children[index].down

                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: Qt.darker(root.palette.highlight, 1.1)
                    }

                },
                State {
                    name: "hovered"
                    when: parent.children[index].hovered

                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: root.selectedText
                    }

                },
                State {
                    name: "focused"
                    when: parent.children[index].activeFocus

                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: root.selectedText
                    }

                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "palette.buttonText, border.color"
                        duration: 150
                    }

                }
            ]

            background: Rectangle {
                height: 2
                color: "transparent"
                border.color: "transparent"
            }
        }

    }
}

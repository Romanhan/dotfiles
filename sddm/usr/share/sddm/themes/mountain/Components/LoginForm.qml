import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    
    // Public properties
    property alias systemButtonVisibility: systemButtons.visible
    property alias clockVisibility: clock.visible
    
    // Private properties for better readability
    readonly property int screenPadding: config.ScreenPadding
    readonly property string formPosition: config.FormPosition
    readonly property bool hasPadding: screenPadding != "0"
    readonly property bool isLeftAligned: formPosition == "left"
    readonly property bool isRightAligned: formPosition == "right"
    
    // Calculate margin based on position and padding
    readonly property int horizontalMargin: {
        if (!hasPadding) return 0;
        if (isLeftAligned) return -screenPadding;
        if (isRightAligned) return screenPadding;
        return 0;
    }
    
    // Layout constants
    readonly property real clockHeight: root.height / 4
    readonly property real inputHeight: root.height / 10
    readonly property real systemButtonsHeight: root.height / 4
    
    // Spacing constants - centralized spacing control
    readonly property real baseSpacing: root.font.pointSize
    readonly property real clockToInputSpacing: baseSpacing * 0.5
    readonly property real inputToButtonsSpacing: baseSpacing * 5  
    readonly property real componentSpacing: baseSpacing * 0.3
    
    SDDM.TextConstants {
        id: textConstants
    }
    
    Clock {
        id: clock
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        Layout.preferredHeight: clockHeight
        Layout.leftMargin: horizontalMargin
        Layout.bottomMargin: clockToInputSpacing
    }
    
    Input {
        id: input
        Layout.alignment: Qt.AlignVCenter
        Layout.preferredHeight: inputHeight
        Layout.leftMargin: horizontalMargin
        Layout.topMargin: 0
        Layout.bottomMargin: inputToButtonsSpacing
    }
    
    SystemButtons {
        id: systemButtons
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        Layout.preferredHeight: systemButtonsHeight
        Layout.maximumHeight: systemButtonsHeight
        Layout.leftMargin: horizontalMargin
        exposedSession: input.exposeSession
    }
}

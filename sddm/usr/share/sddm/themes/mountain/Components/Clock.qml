import QtQuick 2.11
import QtQuick.Controls 2.4

Column {
    id: clock
    
    spacing: 0
    width: parent.width / 2
    
    // Constants for font sizes
    readonly property real headerFontSize: root.font.pointSize * 4
    readonly property real timeFontSize: root.font.pointSize * 2
    readonly property real dateFontSize: root.font.pointSize * 1 

    // Spacing constants
    readonly property real headerSpacing: root.font.pointSize * 0.5
    readonly property real clockSpacing: root.font.pointSize * 0.3
    
    // Locale and format properties
    readonly property var locale: Qt.locale(config.Locale)
    readonly property string timeFormat: "HH:mm:ss"  // 24-hour format
    readonly property int dateFormat: {
        if (config.DateFormat == "short") return Locale.ShortFormat;
        if (config.DateFormat !== "") return config.DateFormat;
        return Locale.LongFormat;
    }    

    Component.onCompleted: updateAllTime()

    
    function updateAllTime() {
        timeLabel.updateTime();
        dateLabel.updateTime();
    }
    
    Label {
        id: headerLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: config.HeaderText !== "" ? headerFontSize : 0
        color: root.palette.text
        renderType: Text.QtRendering
        text: config.HeaderText
        visible: config.HeaderText !== ""
    }

    // Spacer after header/welcome text
    Item {
        height: config.HeaderText !== "" ? headerSpacing : 0
        width: 1
    }
    
    Label {
        id: timeLabel
        
        function updateTime() {
            text = new Date().toLocaleTimeString(locale, timeFormat);
        }
        
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: timeFontSize
        font.weight: Font.Normal
        color: root.palette.text
        renderType: Text.QtRendering
    }

    // Spacer after time
    Item {
        height: clockSpacing
        width: 1
    }
    
    Label {
        id: dateLabel
        
        function updateTime() {
            text = new Date().toLocaleDateString(locale, dateFormat);
        }
        
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: dateFontSize  
        font.weight: Font.Medium      
        color: root.palette.text
        renderType: Text.QtRendering
    }
    
    Timer {
        id: clockTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: updateAllTime()
    }
}

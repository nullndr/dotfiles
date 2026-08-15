import QtQuick
import Quickshell

PanelWindow {
  id: root

  visible: false

  implicitWidth: 280
  implicitHeight: 60

  anchors {
    top: true
    right: true
  }

  margins {
    top: 12
    right: 12
  }

  exclusionMode: ExclusionMode.Ignore
  color: "transparent"

  property string osdIcon: ""
  property string osdText: ""
  property real osdValue: 0
  property bool hasValue: false

  function showOsd(icon, text, value) {
    root.osdIcon = icon;
    root.osdText = text;
    root.osdValue = value;
    root.hasValue = true;

    root.visible = true;
    hideTimer.restart();
  }

  function showMessage(icon, text) {
    root.osdIcon = icon;
    root.osdText = text;
    root.osdValue = 0;
    root.hasValue = false;

    root.visible = true;
    hideTimer.restart();
  }

  Timer {
    id: hideTimer
    interval: 1200
    repeat: false

    onTriggered: root.visible = false
  }

  Rectangle {
    anchors.fill: parent

    radius: 10
    color: "#383c4a"

    Row {
      anchors {
        fill: parent
        margins: 16
      }

      spacing: 14

      Text {
        anchors.verticalCenter: parent.verticalCenter

        text: root.osdIcon
        color: "white"

        font {
          family: "Symbols Nerd Font"
          pixelSize: 26
        }
      }

      Column {
        anchors.verticalCenter: parent.verticalCenter

        width: parent.width - 54
        spacing: 8

        Text {
          text: root.osdText
          color: "white"

          font {
            pixelSize: 14
            weight: Font.Medium
          }
        }

        Rectangle {
          visible: root.hasValue

          width: parent.width
          height: 6

          radius: 3
          color: "#555a6a"

          Rectangle {
            width: parent.width * root.osdValue
            height: parent.height

            radius: parent.radius
            color: "#7aa2f7"

            Behavior on width {
              NumberAnimation {
                duration: 100
              }
            }
          }
        }
      }
    }
  }
}

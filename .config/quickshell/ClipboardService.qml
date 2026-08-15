import QtQuick
import Quickshell
import Quickshell.Io

Scope {
  id: root

  required property var osd
  property bool initialized: false

  Process {
    id: clipboardWatcher

    running: true

    command: ["wl-paste", "--type", "text", "--watch", "sh", "-c", "printf 'copied\\n'"]

    stdout: SplitParser {
      onRead: data => {
        if (!root.initialized) {
          root.initialized = true;
          return;
        }

        root.osd.showMessage("󰅍", "Text Copied");
      }
    }

    onRunningChanged: {
      if (!running)
        running = true;
    }
  }
}

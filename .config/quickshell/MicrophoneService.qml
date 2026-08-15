import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Scope {
  id: root

  required property var osd

  property var source: Pipewire.defaultAudioSource
  property bool ready: false

  PwObjectTracker {
    objects: root.source ? [root.source] : []
  }

  onSourceChanged: {
    root.ready = false;
    initTimer.restart();
  }

  Timer {
    id: initTimer

    interval: 300
    repeat: false

    onTriggered: root.ready = true
  }

  Connections {
    target: root.source ? root.source.audio : null

    function onVolumeChanged() {
      if (root.ready) {
        root.showMicrophone();
      }
    }

    function onMutedChanged() {
      if (root.ready) {
        root.showMicrophone();
      }
    }
  }

  function showMicrophone() {
    if (!root.source || !root.source.audio)
      return;
    const volume = root.source.audio.volume;
    const muted = root.source.audio.muted;
    const percent = Math.round(volume * 100);

    if (muted) {
      root.osd.showOsd("󰍭", "Muted", 0);
    } else {
      root.osd.showOsd("󰍬", percent + "%", volume);
    }
  }
}

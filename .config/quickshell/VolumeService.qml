import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Scope {
  id: root

  required property var osd

  property var sink: Pipewire.defaultAudioSink

  property real previousVolume: -1
  property bool previousMuted: false

  onSinkChanged: {
    previousVolume = -1;
  }

  PwObjectTracker {
    objects: [root.sink]
  }

  Connections {
    target: root.sink ? root.sink.audio : null

    function onVolumeChanged() {
      if (!target) {
        return;
      }

      const volume = target.volume;

      if (root.previousVolume < 0) {
        root.previousVolume = volume;
        root.previousMuted = target.muted;
      } else {
        root.previousVolume = volume;
        root.showVolume();
      }
    }

    function onMutedChanged() {
      if (!target) {
        return;
      }

      if (root.previousVolume < 0) {
        root.previousVolume = target.volume;
        root.previousMuted = target.muted;
        return;
      }

      root.previousMuted = target.muted;

      root.showVolume();
    }
  }

  function showVolume() {
    if (!sink || !sink.audio)
      return;
    const volume = sink.audio.volume;
    const muted = sink.audio.muted;
    const percent = Math.round(volume * 100);

    let icon;

    if (muted || volume === 0)
      icon = "󰝟";
    else if (volume < 0.33)
      icon = "󰕿";
    else if (volume < 0.66)
      icon = "󰖀";
    else
      icon = "󰕾";

    if (muted)
      osd.showOsd(icon, "Muted", 0);
    else
      osd.showOsd(icon, percent + "%", volume);
  }
}

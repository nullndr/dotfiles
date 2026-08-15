import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
  Osd {
    id: osd
  }

  VolumeService {
    osd: osd
  }

  MicrophoneService {
    osd: osd
  }

  BrightnessService {
    osd: osd
  }

  ClipboardService {
    osd: osd
  }

  Process {
    running: true
    command: ["waybar", "--config", "/home/andrea/.config/waybar/hypr-config.jsonc"]
  }
}

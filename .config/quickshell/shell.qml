import Quickshell
import Quickshell.Io

ShellRoot {
  Process {
    running: true
    command: [
      "waybar",
      "--config",
      "/home/andrea/.config/waybar/hypr-config.jsonc"
    ]
  }
}
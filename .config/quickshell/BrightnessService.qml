import QtQuick
import Quickshell
import Quickshell.Io

Scope {
  id: root

  required property var osd

  property int currentBrightness: 0
  property int maximumBrightness: 120000

  readonly property real minimumPercent: 0.02
  readonly property int minimumBrightness: Math.round(maximumBrightness * minimumPercent)

  readonly property int step: Math.round(maximumBrightness / 100)

  property int pendingDirection: 0

  function increment(): void {
    pendingDirection = 1;
    readBrightness.running = true;
  }

  function decrement(): void {
    pendingDirection = -1;
    readBrightness.running = true;
  }

  function applyBrightness(value: int): void {
    const clamped = Math.max(minimumBrightness, Math.min(maximumBrightness, value));

    currentBrightness = clamped;

    setBrightness.exec(["brightnessctl", "-c", "backlight", "set", clamped.toString()]);

    showOsd(clamped);
  }

  function showOsd(value: int): void {
    const normalized = (value - minimumBrightness) / (maximumBrightness - minimumBrightness);

    const percent = Math.round(normalized * 100);

    root.osd.showOsd("󰃠", percent + "%", normalized);
  }

  Process {
    id: readBrightness

    command: ["brightnessctl", "-c", "backlight", "get"]

    stdout: StdioCollector {
      onStreamFinished: {
        const current = parseInt(text.trim());

        if (isNaN(current))
          return;
        root.currentBrightness = current;

        if (root.pendingDirection > 0) {
          root.applyBrightness(current + root.step);
        } else if (root.pendingDirection < 0) {
          root.applyBrightness(current - root.step);
        }

        root.pendingDirection = 0;
      }
    }
  }

  Process {
    id: setBrightness
  }

  IpcHandler {
    target: "brightness"

    function increment(): void {
      root.increment();
    }

    function decrement(): void {
      root.decrement();
    }
  }
}

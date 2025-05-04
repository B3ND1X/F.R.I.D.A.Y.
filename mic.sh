#!/bin/bash

LOCK_SCRIPT="$HOME/.mic_volume_lock.sh"
AUTOSTART_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/autostart"
AUTOSTART_FILE="$AUTOSTART_DIR/mic_volume.desktop"
DEFAULT_PA="/etc/pulse/default.pa"
DEFAULT_PA_BAK="/etc/pulse/default.pa.bak"

# Function to get the USB microphone source name
get_usb_mic_source() {
  pactl list short sources | awk '{print $2}' | grep '^alsa_input\.usb' | head -n 1
}

# Set mic volume to 150%
set_volume() {
  MIC=$(get_usb_mic_source)
  if [ -z "$MIC" ]; then
    echo "Error: No USB microphone found."
    exit 1
  fi
  echo "Setting mic '$MIC' volume to 150%..."
  pactl set-source-volume "$MIC" 150% || {
    echo "Error: Failed to set volume for '$MIC'."
    exit 1
  }
}

# Create persistent lock script
create_lock_script() {
  MIC=$(get_usb_mic_source)
  cat <<EOF > "$LOCK_SCRIPT"
#!/bin/bash
while true; do
  pactl set-source-volume "$MIC" 150% >/dev/null 2>&1
  sleep 5
done
EOF
  chmod +x "$LOCK_SCRIPT"
}

# Disable AGC-related PulseAudio modules
disable_agc_modules() {
  if [ -f "$DEFAULT_PA" ]; then
    if [ ! -f "$DEFAULT_PA_BAK" ]; then
      echo "Creating backup: $DEFAULT_PA_BAK"
      sudo cp "$DEFAULT_PA" "$DEFAULT_PA_BAK"
    fi
    echo "Disabling AGC-related modules in default.pa..."
    sudo sed -i '/module-echo-cancel/d' "$DEFAULT_PA"
    sudo sed -i '/load-module module-udev-detect/d' "$DEFAULT_PA"
  else
    echo "Warning: PulseAudio config file not found at $DEFAULT_PA"
  fi
}

# Add the lock script to autostart
enable_autostart() {
  mkdir -p "$AUTOSTART_DIR"
  cat <<EOF > "$AUTOSTART_FILE"
[Desktop Entry]
Type=Application
Exec=$LOCK_SCRIPT
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Mic Volume Lock
EOF
}

# Revert changes: restore config, remove scripts, kill process
revert_changes() {
  echo "Reverting mic lock configuration..."
  if [ -f "$DEFAULT_PA_BAK" ]; then
    echo "Restoring original PulseAudio config..."
    sudo cp "$DEFAULT_PA_BAK" "$DEFAULT_PA"
  fi
  echo "Cleaning up..."
  rm -f "$LOCK_SCRIPT"
  rm -f "$AUTOSTART_FILE"
  pkill -f "$LOCK_SCRIPT" >/dev/null 2>&1
  echo "Restarting PulseAudio..."
  pulseaudio -k && pulseaudio --start
  echo "Revert complete."
  exit 0
}

# MAIN LOGIC
if [ "$1" = "--revert" ]; then
  revert_changes
fi

# Kill old version if running
pkill -f "$LOCK_SCRIPT" >/dev/null 2>&1

# Apply setup
set_volume
create_lock_script
disable_agc_modules
enable_autostart

# Restart PulseAudio
pulseaudio -k && pulseaudio --start

# Run the lock script in the background
bash "$LOCK_SCRIPT" &

echo "USB mic volume is now locked at 150% and will persist across reboots."


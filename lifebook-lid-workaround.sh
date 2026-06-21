#!/bin/bash

#SUSPEND_MODE=suspend
SUSPEND_MODE=suspend-then-hibernate
#SUSPEND_MODE=hibernate

# Script to suspend when the lid is closed.
cat << 'EOF' | sudo tee /usr/local/bin/lid-monitor.sh
#!/bin/bash

# Prevent executing twice.
PIDFILE=/var/run/lid-monitor.pid
if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    exit 1
fi
echo $$ > "$PIDFILE"

LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

while true; do
    if [ -f "$LID_STATE_FILE" ]; then
        # Obtain lid state (open/closed)
        STATE=$(awk '{print $2}' "$LID_STATE_FILE")

        if [ "$STATE" = "closed" ]; then
            # Choose one of the three commands as a sleep action.
            systemctl $SUSPEND_MODE
            # Just after resume, sleep 5 seconds to prevent the false closed-state detection.
            sleep 5
        fi
    fi
    sleep 1
done
EOF
sudo chmod +x /usr/local/bin/lid-monitor.sh

# Deploy the script as Systemd service.
cat << 'EOF' | sudo tee /etc/systemd/system/lid-monitor.service
[Unit]
Description=Monitor ACPI Lid State and Suspend
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/local/bin/lid-monitor.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Start service.
sudo systemctl daemon-reload
sudo systemctl enable --now lid-monitor.service

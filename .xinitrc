#exec dbus-launch --exit-with-session awesome

# Needed for gnome-terminal to work
systemctl --user import-environment DISPLAY XAUTHORITY
if which dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

exec awesome

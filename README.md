# net.mullvad.mullvadvpn (Flatpak)

Unofficial Flatpak for the **Mullvad VPN** desktop client on Linux.

This package provides the **official Mullvad VPN desktop application (GUI + CLI)** running inside a Flatpak sandbox.
To establish a VPN tunnel it requires a **Mullvad VPN daemon** running on the host system (outside Flatpak).

> Important: This project is **not** affiliated with or endorsed by Mullvad.
> It only repackages the official Mullvad binaries into a Flatpak manifest.
> Please do not report Flatpak-specific issues to Mullvad; use this repository’s issue tracker instead.

---

## Features

- Runs the **official Mullvad VPN desktop GUI** (Electron) in a Flatpak sandbox.
- Includes the `mullvad` CLI inside the sandbox.
- Integrates with:
  - Wayland/X11
  - System tray (`org.kde.StatusNotifierWatcher`)
  - `org.freedesktop.NetworkManager` and `org.freedesktop.secrets` over the system D-Bus
- Relies on Flatpak’s sandbox; the Chromium SUID helper (`chrome-sandbox`) is removed.

---

## Requirements

- Flatpak installed and configured with Flathub.
- Runtimes:
  - `org.freedesktop.Platform//25.08`
  - `org.freedesktop.Sdk//25.08` (for building)
- **Mullvad VPN daemon running on the host** and exposing its RPC socket under `/run/mullvad-vpn`.

Without the daemon, the Flatpak will start, but it will not be able to establish a VPN tunnel and will show errors such as:

- “No connection established to daemon”
- “Failed to connect to daemon before the deadline”

---

## Build and install locally

First install `flatpak-builder` with your package manager.

Then build and install for your user:

```bash
flatpak-builder --force-clean --user --install-deps-from=flathub \
  --repo=repo --install builddir net.mullvad.mullvadvpn.yaml
```

After installation, run the app with:

```bash
flatpak run net.mullvad.mullvadvpn
```

---

## Running the Mullvad daemon (example: Arch Linux)

On Arch Linux, you can install Mullvad VPN (daemon + native GUI) from AUR:

```bash
yay -S mullvad-vpn
```

Enable and start the daemon:

```bash
sudo systemctl enable --now mullvad-daemon.service
systemctl status mullvad-daemon.service
```

Ensure the RPC socket directory exists:

```bash
ls -l /run/mullvad-vpn /var/run/mullvad-vpn 2>/dev/null
```

If you need to force the socket path to `/run/mullvad-vpn`, create a systemd override:

```bash
sudo systemctl edit mullvad-daemon.service
```

Add:

```ini
[Service]
Environment=MULLVAD_RPC_SOCKET_PATH=/run/mullvad-vpn
```

Then reload and restart:

```bash
sudo systemctl daemon-reload
sudo systemctl restart mullvad-daemon.service
ls -l /run/mullvad-vpn
```

Once the daemon and socket are available, start the Flatpak:

```bash
flatpak run net.mullvad.mullvadvpn
```

The GUI should now be able to connect to the daemon and control the VPN tunnel.

---

## Contributing

Contributions are welcome! Feel free to open issues and pull requests for:

- Manifest improvements
- Runtime/runtime-version updates
- Packaging fixes for new Mullvad releases


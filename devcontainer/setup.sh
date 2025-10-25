#!/bin/bash
set -e

echo "Setting up Flatpak environment for Mullvad VPN..."

echo "Updating system..."
apt update

echo "Installing additional tools..."
apt install -y curl wget git

echo "Configuring Flathub..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing Flatpak SDK..."
flatpak install -y flathub org.freedesktop.Sdk//24.08
flatpak install -y flathub org.freedesktop.Platform//24.08

chmod +x build.sh
chmod +x test.sh

echo "Environment configured successfully!"
echo ""
echo "Available commands:"
echo "  ./build.sh          - Build the Flatpak package"
echo "  ./test.sh           - Test the application"
echo "  flatpak-builder --help - Flatpak builder help"
echo ""
echo "Project files:"
echo "  net.mullvad.mullvadvpn.yaml     - Package configuration"
echo "  net.mullvad.mullvadvpn.metainfo.xml - Application metadata"
echo "  net.mullvad.mullvadvpn.desktop  - Desktop file"

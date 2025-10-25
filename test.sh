#!/bin/bash
set -e

echo "Testing Mullvad VPN application..."
echo "================================="

if [ ! -d "build-dir" ]; then
    echo "Error: build-dir not found"
    echo "Run first: ./build.sh"
    exit 1
fi

if [ ! -f "build-dir/files/bin/mullvad" ]; then
    echo "Error: mullvad binary not found"
    echo "Build may have failed"
    exit 1
fi

echo "Binary found: build-dir/files/bin/mullvad"

echo "Testing direct execution..."
echo "Command: flatpak run net.mullvad.mullvadvpn"
echo ""

if flatpak run net.mullvad.mullvadvpn --help 2>/dev/null; then
    echo "Application running correctly!"
    echo ""
    echo "Package information:"
    flatpak info net.mullvad.mullvadvpn 2>/dev/null || echo "   (Package not installed on system)"
else
    echo "Application not installed on system"
    echo "To install it, run:"
    echo "flatpak-builder --repo=repo --install build-dir net.mullvad.mullvadvpn.yaml"
fi

echo ""
echo "Generated files:"
echo "  build-dir/files/bin/mullvad - Main binary"
echo "  build-dir/files/share/applications/ - Desktop files"
echo "  build-dir/files/share/metainfo/ - Metadata"
echo "  build-dir/files/share/icons/ - Icons"

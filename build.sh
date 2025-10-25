#!/bin/bash
set -e

echo "Building Mullvad VPN Flatpak package..."
echo "======================================"

if [ ! -f "net.mullvad.mullvadvpn.yaml" ]; then
    echo "Error: net.mullvad.mullvadvpn.yaml not found"
    echo "Make sure to run this script from the project directory"
    exit 1
fi

echo "Cleaning previous build..."
rm -rf build-dir

echo "Checking dependencies..."
if ! command -v flatpak-builder &> /dev/null; then
    echo "Error: flatpak-builder is not installed"
    echo "Run: apt install flatpak-builder"
    exit 1
fi

echo "Starting build process..."
echo "This may take several minutes..."
flatpak-builder --force-clean --install-deps-from=flathub build-dir net.mullvad.mullvadvpn.yaml

echo ""
echo "Build completed successfully!"
echo ""
echo "To test the application:"
echo "  ./test.sh"
echo ""
echo "Generated files:"
echo "  build-dir/ - Build directory"
echo ""
echo "To install on system:"
echo "  flatpak-builder --repo=repo --install build-dir net.mullvad.mullvadvpn.yaml"

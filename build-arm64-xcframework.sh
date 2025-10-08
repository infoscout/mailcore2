#!/bin/bash
set -e

echo "=========================================="
echo "Building MailCore2 XCFramework with ARM64 Simulator Support"
echo "=========================================="

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Set environment variables
export NOBITCODE=1
export build_for_external=1

echo ""
echo "Step 1: Building ctemplate-ios..."
cd scripts
./build-ctemplate-ios.sh
if [ $? -ne 0 ]; then
    echo "ERROR: ctemplate-ios build failed"
    exit 1
fi
echo "✓ ctemplate-ios built successfully"

echo ""
echo "Step 2: Building tidy-html5-ios..."  
./build-tidy-ios.sh
if [ $? -ne 0 ]; then
    echo "ERROR: tidy-html5-ios build failed"
    exit 1
fi
echo "✓ tidy-html5-ios built successfully"

echo ""
echo "Step 3: Building libetpan-ios (with ARM64 simulator support)..."
./build-libetpan-ios.sh
if [ $? -ne 0 ]; then
    echo "ERROR: libetpan-ios build failed"
    exit 1
fi
echo "✓ libetpan-ios built successfully"

echo ""
echo "Step 4: Building MailCore2 iOS XCFramework..."
cd "$SCRIPT_DIR"
./scripts/build-mailcore2-xcframework.sh
if [ $? -ne 0 ]; then
    echo "ERROR: XCFramework build failed"
    exit 1
fi

echo ""
echo "=========================================="
echo "✓ Build Complete!"
echo "=========================================="
echo ""
echo "XCFramework location: .build/MailCore2.xcframework"
echo ""
echo "Verifying architectures..."
if [ -f ".build/MailCore2.xcframework/ios-arm64_x86_64-simulator/MailCore.framework/MailCore" ]; then
    lipo -info ".build/MailCore2.xcframework/ios-arm64_x86_64-simulator/MailCore.framework/MailCore"
elif [ -f ".build/MailCore2.xcframework/ios-x86_64_arm64-simulator/MailCore.framework/MailCore" ]; then
    lipo -info ".build/MailCore2.xcframework/ios-x86_64_arm64-simulator/MailCore.framework/MailCore"
else
    echo "Could not find simulator framework to verify"
fi

#!/bin/bash

# Run the tests on the 3.5" Retina iPhone Simulator
DEVICE="iPhone Retina (4-inch)"

# Run the tests on iOS 7.0
VERSION=6.1

OUTPUT_DIR=reports
mkdir -p "$OUTPUT_DIR"
PROJECT_DIR=$PWD
YOUR_PROJECT=linphone.xcworkspace

# Returns 0 on success, 1 on failure
# Log output and screenshots will be placed in $OUTPUT_DIR
"$PROJECT_DIR/Pods/Subliminal/Supporting Files/CI/subliminal-test" \
    -workspace "$YOUR_PROJECT" \
    -scheme "Integration Tests" \
    -sim_device "$DEVICE" \
    -sim_version "$VERSION" \
    -output "$OUTPUT_DIR" \
    --quiet_build


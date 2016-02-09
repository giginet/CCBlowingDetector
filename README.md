# CCBlowingDetector

It enable to detect blowing via microphone for cocos2d-x

It is implemented for GGJ 2016

This plugin supports iOS only.

# How to integrate

1. All header/implementation in `CCBlowingDetector` directory add to your Xcode project
2. Build and Run

# Sample

```cpp
#include "CCBlowingDetector.h"

bool YourScene::init() {
    auto detector = BlowingDetector::getInstance();
    // Initialize detector
    // iOS will appears dialog to use microphone when this method was called.
    detector->initialize();

    // Set average threshold.
    // When average power exceed this value, it will be detected as blowing.
    detector->setAverageThreshold(-5);

    // Set duration in seconds which required to be detected.
    detector->setRequiredBrowingDuration(0.3);

    // Set callback function when blowing is detected.
    detector->setOnDetectedCallback([this](float peak, float average) {
        cocos2d::log("detected");
    });
    // Set callback function when power is updated.
    detector->setOnPowerUpdatedCallback([this](float peak, float average) {
        cocos2d::log("updated");
    });
    this->scheduleUpdate();
    return true;
}

void YourScene::update(float dt)
{
    auto detector = BlowingDetector::getInstance();
    detector->update(dt);
}

```


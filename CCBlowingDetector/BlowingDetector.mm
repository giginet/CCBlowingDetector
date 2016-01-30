#include "BlowingDetector.h"
#import <AVFoundation/AVFoundation.h>
#import "BlowingDetectorImpl.h"

BlowingDetector* BlowingDetector::_instance = nullptr;

BlowingDetector::BlowingDetector()
: _onDetectedCallback(nullptr)
{
    
}

BlowingDetector *BlowingDetector::getInstance()
{
    if (_instance == nullptr) {
        _instance = new BlowingDetector();
        
    }
    return _instance;
}

void BlowingDetector::initialize()
{
    [[BlowingDetectorImpl sharedDetector] initialize];
}

void BlowingDetector::setOnDetectedCallback(OnDetectedCallback callback)
{
    _onDetectedCallback = callback;
}

void BlowingDetector::update(float dt)
{
    BlowingDetectorImpl *detector = [BlowingDetectorImpl sharedDetector];
    if ([detector isDetected]) {
        if (_onDetectedCallback != nullptr) {
            _onDetectedCallback([detector averagePowerForChannel:0]);
        }
    }
}
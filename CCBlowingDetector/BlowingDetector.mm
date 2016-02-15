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

void BlowingDetector::setOnPowerUpdatedCallback(OnUpdatedCallback callback)
{
    _onPowerUpdatedCallback = callback;
}

void BlowingDetector::update(float dt)
{
    BlowingDetectorImpl *detector = [BlowingDetectorImpl sharedDetector];
    float peak = [detector peakPowerForChannel:0];
    float average = [detector averagePowerForChannel:0];
    if (_onPowerUpdatedCallback != nullptr) {
        _onPowerUpdatedCallback(peak, average);
    }
    
    if ([detector isDetected:dt]) {
        if (_onDetectedCallback != nullptr) {
            _onDetectedCallback(peak, average);
        }
    }
}

bool BlowingDetector::isGranted()
{
    return [[BlowingDetectorImpl sharedDetector] isGranted];
}

float BlowingDetector::getAveragePowerForChannel(int channel)
{
    return [[BlowingDetectorImpl sharedDetector] averagePowerForChannel:channel];
}

float BlowingDetector::getPeakPowerForChannel(int channel)
{
    return [[BlowingDetectorImpl sharedDetector] peakPowerForChannel:channel];
}

void BlowingDetector::setRequiredBrowingDuration(float blowingDuration)
{
    [[BlowingDetectorImpl sharedDetector] setRequireBlowingDuration:blowingDuration];
}

void BlowingDetector::setAverageThreshold(float threshold)
{
    [[BlowingDetectorImpl sharedDetector] setAverageThreshold:threshold];
}
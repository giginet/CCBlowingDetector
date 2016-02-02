#ifndef BlowingDetector_hpp
#define BlowingDetector_hpp

typedef std::function<void (float peak)> OnDetectedCallback;
typedef std::function<void (float peak, float average)> OnUpdatedCallback;

class BlowingDetector 
{
    static BlowingDetector* _instance;
    OnDetectedCallback _onDetectedCallback;
    OnUpdatedCallback _onPowerUpdatedCallback;
public:
    static BlowingDetector* getInstance();
    BlowingDetector();
    
    float getAveragePowerForChannel(int channel);
    float getPeakPowerForChannel(int channel);
    
    void update(float dt);
    void initialize();
    void setRequiredBrowingDuration(float blowingDuration);
    void setAverageThreshold(float threshold);
    void setOnDetectedCallback(OnDetectedCallback callback);
    void setOnPowerUpdatedCallback(OnUpdatedCallback callback);

};

#endif /* BlowingDetector_hpp */

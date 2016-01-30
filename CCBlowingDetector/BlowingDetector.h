#ifndef BlowingDetector_hpp
#define BlowingDetector_hpp

typedef std::function<void (float peak)> OnDetectedCallback;

class BlowingDetector 
{
    static BlowingDetector* _instance;
    OnDetectedCallback _onDetectedCallback;
public:
    static BlowingDetector* getInstance();
    float getAveragePowerForChannel(int channel);
    void setOnDetectedCallback(OnDetectedCallback callback);
    BlowingDetector();
    void update(float dt);
    void initialize();
    void setRequiredBrowingDuration(float blowingDuration);
    void setAverageThreshold(float threshold);
};

#endif /* BlowingDetector_hpp */

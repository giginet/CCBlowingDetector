#ifndef BlowingDetector_hpp
#define BlowingDetector_hpp

typedef std::function<void (float peak)> OnDetectedCallback;

class BlowingDetector 
{
    static BlowingDetector* _instance;
    OnDetectedCallback _onDetectedCallback;
public:
    static BlowingDetector* getInstance();
    void setOnDetectedCallback(OnDetectedCallback callback);
    BlowingDetector();
    void update(float dt);
    void initialize();
};

#endif /* BlowingDetector_hpp */

#include <iostream>
#include <thread>
#include <chrono>

class CountdownTimer {
public:
    CountdownTimer(int minutes, int seconds)
        : minutes_(minutes), seconds_(seconds) {}

    void Start() {
        while (!breakLoop_) {
            std::this_thread::sleep_for(std::chrono::seconds(1));

            if (seconds_ > 0) {
                --seconds_;
            } else {
                if (minutes_ > 0) {
                    --minutes_;
                    seconds_ = 59;
                } else {
                    breakLoop_ = true;
                    OnCelebration();
                }
            }

            UpdateHUD();
        }
    }

private:
    int minutes_;
    int seconds_;
    bool breakLoop_ = false;

    void UpdateHUD() {
        if (seconds_ >= 10) {
            std::cout << minutes_ << ":" << seconds_ << std::endl;
        } else {
            std::cout << minutes_ << ":0" << seconds_ << std::endl;
        }
    }

    void OnCelebration() {
        std::cout << "Celebration Time!" << std::endl;
    }
};

int main() {
    CountdownTimer timer(0, 20);
    timer.Start();
    return 0;
}

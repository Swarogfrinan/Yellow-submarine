import Foundation

struct TimerModel {
    
    var fishTimer = Timer()
    var secondFishTimer = Timer()
    var krakenTimer = Timer()
    var jellyfishTimer = Timer()
    var sharkTimer = Timer()
    var boatTimer = Timer()
    var oxygenTimer = Timer()
    
    func randomTimerNumber(in range: ClosedRange<Double>) -> Double {
        return(Double.random(in: 11...120))
    }
    
    func randomDuration(in range: ClosedRange<Double>) -> Double {
        return(Double.random(in: 3...12))
    }
    
    func createTimer(completion : @escaping () -> ()) {
        print("START TIMER")
        Timer.scheduledTimer(withTimeInterval: randomTimerNumber(in: 4...9), repeats: true) { _ in
        }
    }
    
    func invalidateGameTimers() {
        let timerArray = [fishTimer, secondFishTimer, boatTimer, sharkTimer, jellyfishTimer, krakenTimer, oxygenTimer]
        for timers in timerArray {
            timers.invalidate()
        }
    }
}


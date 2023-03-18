import Foundation

struct TimerModel {
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
}


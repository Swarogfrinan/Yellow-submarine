import Foundation
import AVFoundation

class AudioBrain {
    
    private var audioPlayer = AVAudioPlayer()
    
     func playerWillAppear() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "submarineOst", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        } catch {
            fatalError("Game music submarineOst cannot be played")
        }
    }
    
     func switchPlayer() {
         if audioPlayer.isPlaying {
             audioPlayer.stop()
         } else {
             audioPlayer.play()
         }
    }
    }


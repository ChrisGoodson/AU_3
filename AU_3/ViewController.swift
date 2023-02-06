import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    var timer = Timer()
    var countdownTimer = 60
    var chimeSound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url1 = Bundle.main.url(forResource: "ayntk", withExtension: "mp3") else { return }

        do {
            chimeSound = try AVAudioPlayer(contentsOf: url1)
            chimeSound?.play()
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        timer.invalidate()
        chimeSound?.stop()
    }
    
    @objc func updateTime() {
        if countdownTimer > 0 {
            countdownTimer -= 1
            secondLabel.text = "\(countdownTimer) seconds left"
        } else {
            timer.invalidate()
            chimeSound?.play()
        }
    }
}

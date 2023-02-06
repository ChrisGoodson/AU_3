import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var countdownTimer: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    var countdown = 0
    var chimeSound: AVAudioPlayer?
    var isRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                let currentDateTime = Date()
                let formatter = DateFormatter()
                formatter.timeStyle = .long
                formatter.dateStyle = .short
                let dateTimeString = formatter.string(from: currentDateTime)
                self?.timeLabel.text = dateTimeString
            }
        
        let currentDateTime = Date()
        let formatter = DateFormatter()

        formatter.timeStyle = .long
        formatter.dateStyle = .short

        let dateTimeString = formatter.string(from: currentDateTime)
        timeLabel.text = dateTimeString

        // Do any additional setup after loading the view.
        countdownTimer.datePickerMode = .countDownTimer
        countdownTimer.countDownDuration = 0
        
        guard let url1 = Bundle.main.url(forResource: "ayntk", withExtension: "mp3") else { return }
        
        do {
            chimeSound = try AVAudioPlayer(contentsOf: url1)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }

    
    func startTimer() {
        isRunning = true
        startButton.setTitle("Stop", for: .normal)
        countdown = Int(countdownTimer.countDownDuration)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }



    
    func stopTimer() {
        isRunning = false
        startButton.setTitle("Start", for: .normal)
        timer.invalidate()
        countdown = Int(countdownTimer.countDownDuration)
        countdownLabel.text = "Create a timer"
        chimeSound?.stop()
    }


    
    @objc func updateTime() {
        let hours = Int(countdown / 3600)
        let minutes = Int((countdown % 3600) / 60)
        let seconds = Int(countdown % 60)
        countdownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        if countdown > 0 {
            countdown -= 1
        } else {
            chimeSound?.play()
        }
    }
}

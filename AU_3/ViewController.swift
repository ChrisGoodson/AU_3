//
//  ViewController.swift
//  AU_3
//
//  Created by Chris on 2/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshTapped(_ sender: UIButton) {
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        let dateTimeString = formatter.string(from: currentDateTime)
        timeLabel.text = "Current date and time: " + dateTimeString
        
    }
    
    


}


//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Nehemiah Chandler on 7/28/24.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet var confirmationLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var timeLabel: UILabel!


    private var timer: Timer?
    let minutesToPrepare: Int
    
    init?(coder: NSCoder, minutesToPrepare: Int) {
        self.minutesToPrepare = minutesToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
        
        // Initialize progress view and time label
               progressView.progress = 0.0
        timeLabel.text = formatTime(TimeInterval(minutesToPrepare * 60)) // Convert minutes to seconds
               
               // Start the timer to update the UI
               startTimer()
           }
        // Do any additional setup after loading the view.
    private func startTimer() {
           timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
       }
       
       @objc private func updateUI() {
           // Calculate elapsed time
           guard let startTime = timer?.fireDate else { return }
           let elapsedTime = Date().timeIntervalSince(startTime)
           let totalDuration = TimeInterval(minutesToPrepare * 60)
           let remainingTime = max(totalDuration - elapsedTime, 0)
           
           // Update progress view
           let progress = Float((totalDuration - remainingTime) / totalDuration)
           progressView.setProgress(progress, animated: true)
           
           // Update time label
           timeLabel.text = formatTime(remainingTime)
           
           // Check if time is up
           if remainingTime <= 0 {
               timeLabel.text = "Order Ready!"
               progressView.setProgress(1.0, animated: true)
               timer?.invalidate()
           }
       }
       
       private func formatTime(_ timeInterval: TimeInterval) -> String {
           let minutes = Int(timeInterval) / 60
           let seconds = Int(timeInterval) % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }
   }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



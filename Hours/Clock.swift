//
//  Clock.swift
//  Hours
//
//  Created by Ollie Stokes on 14/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import AVFoundation


class Clock: UIViewController {

    var timer: Timer!
    
     var player: AVAudioPlayer?
    
    @IBOutlet var BG: UIImageView!
    
    @IBOutlet var sunMoon: UIImageView!
    
 

    // Back button uses and unwind segue to go home when finished
        
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
        
    }
        // getting data from segue
    
    private var _alarmSeg = Date()
    var alarmSeg : Date {
        get {
            return _alarmSeg
        }   set {
            _alarmSeg = newValue
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // formatting dates
       
        let format = DateFormatter()
        format.timeStyle = .short
        
        let format2 = DateFormatter()
        
        format2.dateStyle = .full

        // setting labels
        
        TimeLabel.text = format.string(from: Date())
        
        DateLabel.text = format2.string(from: Date())
        
        alarmLabel.text = ("Alarm: " + format.string(from: alarmSeg))
        
        
        // timer to check when alarm is triggered and get current time for alarm clock
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GetTime), userInfo: nil, repeats: true)
    
        
 
    
    

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet var alarmLabel: UILabel!
    
    // dismissing timer
    
    override func viewWillDisappear(_ animated: Bool) {
        
        timer.invalidate()
    }
    
      
    
    func GetTime() {
        
        let format = DateFormatter()
        format.timeStyle = .short
        
        let format2 = DateFormatter()
        format2.dateStyle = .full
        
       

 

        // setting labels
        
        TimeLabel.text = format.string(from: Date())
        
        DateLabel.text = format2.string(from: Date())
        
        alarmLabel.text = ("Alarm: " + format.string(from: _alarmSeg))
        
        var currentDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm:00 a"
        
        var alarmStr = formatter2.string(from: _alarmSeg)
        
        // if alarm time matches current time, play alarm, change background and font colour
        
        if alarmStr == formatter.string(for: currentDate) {
            
           
            BG.image = UIImage(named: "Light BG")
            sunMoon.image = UIImage(named: "sunBlack")
            
            TimeLabel.textColor = UIColor.black
            DateLabel.textColor = UIColor.black
            alarmLabel.textColor = UIColor.black
            
            
            
          
            
            createAlert(titleText: "Alarm", messageText: "Good Morning")
            let alarmSound = Bundle.main.url(forResource: "AlarmS", withExtension: "mp3")!
            
            // play alarm sound
            
            do {
                player = try AVAudioPlayer(contentsOf: alarmSound)
                guard let player = player else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
            
        }

 
        
    }
  // create alert
    
    func createAlert (titleText : String , messageText : String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            self.player?.stop()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
   
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  Home.swift
//  Hours
//
//  Created by Ollie Stokes on 11/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import AVFoundation



//Global:



class Home: UIViewController {
    
    var player: AVAudioPlayer?
    

    
    
    var alarmTimer: Timer!
    
    @IBOutlet var showSw: UISwitch!


    @IBOutlet var rec: UIImageView!
    

    
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) {}
    
    @IBAction func unwindToHome2(segue:UIStoryboardSegue) {}
    
    private var _alarmSeg = Date()
    var alarmSeg : Date {
        get {
            return _alarmSeg
        }   set {
            _alarmSeg = newValue
        }
        
    }
    
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "unwindToHome2", sender: self)
    }
   
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let format = DateFormatter()
        format.timeStyle = .short
        
        let format2 = DateFormatter()
        format2.dateFormat = "hh:mm:00 a"
        
      
       
        
       
        
        if self.navigationController?.viewControllers.index(of: self) == 0 {
            rec.isHidden = true
            showSw.isHidden = true
            displayAlarm2.isHidden = true
            
        }
            
        else {
            rec.isHidden = false
            showSw.isHidden = false
            displayAlarm2.isHidden = false
        }
        

        
   
        
        
        
       
        
        alarmTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(alarmAlert), userInfo: nil, repeats: true)
        
        
        
        displayAlarm2.text = format.string(from:_alarmSeg)
       
        
       

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet var displayAlarm2: UILabel!
    
    
        
    
    
    
    
    func createAlert (titleText : String , messageText : String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
             self.player?.stop()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
  
    
    
    func alarmAlert(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm:00 a"
        
        var currentDate = Date()
        
       
        if showSw.isOn {
        

        
        var alarmStr = formatter2.string(from: _alarmSeg)
            
    
    if alarmStr == formatter.string(from: currentDate) {
    createAlert(titleText: "Alarm", messageText: "Alarm message")
        let alarmSound = Bundle.main.url(forResource: "AlarmS", withExtension: "mp3")!
        
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
    
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        alarmTimer.invalidate()
    }



}


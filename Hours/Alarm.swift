//
//  Alarm.swift
//  Hours
//
//  Created by Ollie Stokes on 14/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit



class Alarm: UIViewController {
    
   


    @IBOutlet var timePicker: UIDatePicker!

    @IBOutlet var timeDisplay: UILabel!

    @IBOutlet var currentTimeDisplay: UILabel!
   
    @IBOutlet var sleepSwitch: UISwitch!
    
    var alarmTimer: Timer!
    

    // Button that either segues to the clock class or home class with the alarm time value from date picker based on the value from the alarm clock mode switch
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:00 a"
        
        var _alarmSeg = alarmTime
        
        if sleepSwitch.isOn {
          performSegue(withIdentifier: "Clock", sender: _alarmSeg)
           
            
            
        }
            
        else {
            
            
            performSegue(withIdentifier: "Home", sender: _alarmSeg)
            
            
        }
        

    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // changing text color for date picker
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        
        // Timer to check if alarm matches current time
    
        alarmTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timePickerValue), userInfo: nil, repeats: true)
        
        

   

        // Do any additional setup after loading the view.
    }
    
    
    
    var alarmTime = Date()
    
    var currentDate = Date()
    
   // creating alert
    func createAlert (titleText : String, messageText : String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    // Getting value from datepicker
    
    @IBAction func timePickerValue(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        
        currentDate = Date()
        
        
       alarmTime = timePicker.date
        
        
    
     // checking if alarm time matches current time
        
        if formatter.string(for: alarmTime) == formatter.string(for: currentDate) {
            createAlert(titleText: "Alarm", messageText: "Alarm message")
        }
        
    
        
    }
    
    // preparing for segue to other classes
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sleepSwitch.isOn {
            
            
            if let destination = segue.destination as? Clock{
                if let alarm = sender as? Date {
                    
                    destination.alarmSeg = alarm
                }
            }
            
            

        }
        
        else {
            
            if let destination = segue.destination as? Home{
                if let alarm = sender as? Date {
                    
                    destination.alarmSeg = alarm
        }
           }
        }
    }
   





    
    
    // dismiss timer
    override func viewWillDisappear(_ animated: Bool) {
        
        alarmTimer.invalidate()
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

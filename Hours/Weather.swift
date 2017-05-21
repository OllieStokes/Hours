//
//  Weather.swift
//  Hours
//
//  Created by Ollie Stokes on 21/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class Weather: UIViewController, UISearchBarDelegate{
    @IBOutlet var searchBar: UISearchBar!

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var degreeLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var currentWeather: UILabel!
    

    
    @IBOutlet var BG: UIImageView!
    
    var degree: Int!
    var condition: String!
    var imgURL: String!
    var city: String!
    

    
    var exists: Bool = true
    
    

  

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // delegate is assigned to search bar where user enters name of city
        
        searchBar.delegate = self
        
        
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // URL request is used to initial API request
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let urlRequest = URLRequest(url: URL(string: "https://api.apixu.com/v1/current.json?key=2ca32904563a4969a0370706172105&q=\(searchBar.text!)")!)
        
        // URL session task is created to get data
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {       // checks for error
                do {        // initiates try/catch for error
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    // variables used to store weather data
                    
                    if let current = json["current"] as? [String : AnyObject] {
                        if let temp = current["temp_c"] as? Int {
                            self.degree = temp
                        }
                        
                        if let condition = current["condition"] as? [String : AnyObject] {
                            self.condition = condition["text"] as! String
                            self.imgURL = condition["icon"] as! String
                        }
                        
                        
                    }
                    
                    if let location = json["location"] as? [String : AnyObject] {
                        self.city = location["name"] as! String
                    }
                    // checking if the city name validates
                    if let _ = json["error"] {
                        self.exists = false
                    }
                    
                    DispatchQueue.main.async {
                        if self.exists{
                            
                            // setting labels to weather data
                            self.degreeLabel.text = self.degree.description + "°"
                            self.cityLabel.text = self.city
                            self.conditionLabel.text = self.condition
                            self.currentWeather.text = "Current Weather:"
                        }
                        
                        else {  // if city doesn't match, labels are hidden
                            self.degreeLabel.isHidden = true
                           
                            self.conditionLabel.isHidden = true
                            self.imgView.isHidden = true
                             self.cityLabel.text = "No matching city"
                            self.exists = true
                        }
                    }
                    
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
            
        }
        
        task.resume()

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

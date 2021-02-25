//
//  HistoryViewController.swift
//  unit converter app
//
//  Created by Ahmed Abokor on 26/02/18.
//

import UIKit

class customCell: UITableViewCell
{
    
    @IBOutlet weak var labelCell1: UILabel!
}


class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    
    @IBOutlet weak var tableView1: UITableView!

    
    
    
    @IBOutlet weak var weight: UIButton!
    @IBOutlet weak var temp: UIButton!
    @IBOutlet weak var liquidVolume: UIButton!
    @IBOutlet weak var solidVolume: UIButton!
    @IBOutlet weak var distance: UIButton!
    @IBOutlet weak var speed: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        self.dismiss(animated: true) {
            
        }
    }
    
    var saveArray : [[String : Double]] = [[:]]
   
    var saveStringArray :[String] = ["SAVE HISTORY"]
    
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1.delegate = self
        tableView1.dataSource = self

       
        
        weight.sendActions(for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       
            print("SAVE ARRAY COUNT : \(saveStringArray.count)")
           
            if (saveStringArray.count >= 6)
            {
                return 6
            }
            else
            {
                 return saveStringArray.count
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! customCell
            
        cell.labelCell1.text = saveStringArray[indexPath.row]
            return cell
         }

    
    
    @IBAction func weightPressed(_ sender: Any)
    {
        
        weight.backgroundColor = UIColor.gray
        temp.backgroundColor = UIColor.white
        solidVolume.backgroundColor = UIColor.white
        liquidVolume.backgroundColor = UIColor.white
        speed.backgroundColor = UIColor.white
        distance.backgroundColor = UIColor.white
        
        
        clear()
        var labelSentence : String = ""
        
        
        if (userDefaults.array(forKey: "WeightSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "WeightSaveHistory") as! [[String : Double]]//to prevent reading null list
            
            let saveCount = saveArray.count
            var saveDictionary : [String:Double] = ["ounce" : 0.0, "pound" : 0.0, "gram" : 0.0, "stone" : 0.0, "kilogram" : 0.0]
            
            for j in 0...saveCount-1
            {
              
                let i = saveCount - j - 1
                
                
                saveDictionary = saveArray[i]
                if(saveArray[i] != [:])
                {
                    labelSentence = "\(saveDictionary["ounce"]!) oz" + " = " + "\(saveDictionary["pound"]!) pounds" + " = " + "\(saveDictionary["gram"]!) gms"  + " = " + "\(saveDictionary["stone"]!) stones"  + " = " + "\(saveDictionary["kilogram"]!) kgs"
                    
                    saveStringArray.append(labelSentence)
                }
            }
            
        }
        
        tableView1.reloadData()
    
    }
    
   
    @IBAction func tempPressed(_ sender: Any)
    {
        weight.backgroundColor = UIColor.white
        temp.backgroundColor = UIColor.gray
        solidVolume.backgroundColor = UIColor.white
        liquidVolume.backgroundColor = UIColor.white
        speed.backgroundColor = UIColor.white
        distance.backgroundColor = UIColor.white
        
        
        clear()
        var labelSentence : String = ""
        
        if (userDefaults.array(forKey: "TemperatureSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "TemperatureSaveHistory") as! [[String : Double]]
            
            let saveCount = saveArray.count
            var saveDictionary : [String:Double] = ["celsius" : 0.0, "farh" : 0.0, "Kelvin" : 0.0]
            
            for j in 0...saveCount-1
            {
                let i = saveCount - j - 1
                saveDictionary = saveArray[i]
                
                labelSentence = "\(saveDictionary["celsius"]!) C" + " = " + "\(saveDictionary["farh"]!) F" + " = " + "\(saveDictionary["Kelvin"]!) K"
                
                saveStringArray.append(labelSentence)
                
                
            }
        }
        
       tableView1.reloadData()
        
    }
    
   
    @IBAction func liquidVolumePressed(_ sender: Any)
    {
        
        weight.backgroundColor = UIColor.white
        temp.backgroundColor = UIColor.white
        solidVolume.backgroundColor = UIColor.white
        liquidVolume.backgroundColor = UIColor.gray
        speed.backgroundColor = UIColor.white
        distance.backgroundColor = UIColor.white
        
        
        var labelSentence : String = ""
        clear()
        
        if (userDefaults.array(forKey: "LiquidVolumeSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "LiquidVolumeSaveHistory") as! [[String : Double]]
            
            let saveCount = saveArray.count
            var saveDictionary : [String:Double] = ["gallon" : 0.0, "litre" : 0.0, "pint" : 0.0, "fluid-oz" : 0.0]
            
            for j in 0...saveCount-1
            {
                let i = saveCount - j - 1
                saveDictionary = saveArray[i]
                
                labelSentence = "\(saveDictionary["gallon"]!) gal" + " = " + "\(saveDictionary["litre"]!) l" + " = " + "\(saveDictionary["pint"]!) pints" + " = " + "\(saveDictionary["fluid-oz"]!) fl oz"
                
                saveStringArray.append(labelSentence)
           }
           
        }
        tableView1.reloadData()
        
    }
    
    
    
    @IBAction func solidVolumePressed(_ sender: Any)
    {
        
        
        weight.backgroundColor = UIColor.white
        temp.backgroundColor = UIColor.white
        solidVolume.backgroundColor = UIColor.gray
        liquidVolume.backgroundColor = UIColor.white
        speed.backgroundColor = UIColor.white
        distance.backgroundColor = UIColor.white
        
        var labelSentence : String = ""
        clear()
        
        if (userDefaults.array(forKey: "SolidVolumeSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "SolidVolumeSaveHistory") as! [[String : Double]]
           
            let saveCount = saveArray.count
            var saveDictionary : [String:Double] = ["metre" : 0.0, "cm" : 0.0, "litre" : 0.0]
            
            for j in 0...saveCount-1
            {
                let i = saveCount - j - 1
                saveDictionary = saveArray[i]
                
                labelSentence = "\(saveDictionary["metre"]!) m" + " = " + "\(saveDictionary["cm"]!) cm" + " = " + "\(saveDictionary["litre"]!) L"
                
                saveStringArray.append(labelSentence)
            }
           
        }
        
        tableView1.reloadData()
    }
    
    

    @IBAction func distancePressed(_ sender: Any)
    {
        
        
        weight.backgroundColor = UIColor.white
        temp.backgroundColor = UIColor.white
        solidVolume.backgroundColor = UIColor.white
        liquidVolume.backgroundColor = UIColor.white
        speed.backgroundColor = UIColor.white
        distance.backgroundColor = UIColor.gray
        
        var labelSentence : String = ""
        clear()
        
        if (userDefaults.array(forKey: "DistanceSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "DistanceSaveHistory") as! [[String : Double]]
            
            let saveCount = saveArray.count
            var saveDictionary : [String:Double] = ["cm" : 0.0, "metre" : 0.0, "inch" : 0.0, "yard" : 0.0, "milimetre" : 0.0]
            
            for j in 0...saveCount-1
            {
                let i = saveCount - j - 1
                saveDictionary = saveArray[i]
                labelSentence = "\(saveDictionary["cm"]!) cm" + " = " + "\(saveDictionary["metre"]!) m" + " = " + "\(saveDictionary["inch"]!) inches"  + " = " + "\(saveDictionary["yard"]!) yards"  + " = " + "\(saveDictionary["milimetre"]!) mm"
                
                saveStringArray.append(labelSentence)
            }
            
        }
        
        tableView1.reloadData()
    }
    
    @IBAction func speedPressed(_ sender: Any)
    {
        
        
        weight.backgroundColor = UIColor.white
        temp.backgroundColor = UIColor.white
        solidVolume.backgroundColor = UIColor.white
        liquidVolume.backgroundColor = UIColor.white
        speed.backgroundColor = UIColor.gray
        distance.backgroundColor = UIColor.white
        
         var labelSentence : String = ""
        clear()
        
        if (userDefaults.array(forKey: "SpeedSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "SpeedSaveHistory") as! [[String : Double]]
            
            let saveCount = saveArray.count
            var saveDictionary : [String:Double] = ["m/s" : 0.0, "km/hr" : 0.0, "miles/hr" : 0.0]
            for j in 0...saveCount-1
            {
                let i = saveCount - j - 1
                saveDictionary = saveArray[i]
                
                labelSentence = "\(saveDictionary["m/s"]!) mtrs/sec" + " = " + "\(saveDictionary["km/hr"]!) km/hr" + " = " + "\(saveDictionary["miles/hr"]!) miles/hr"
                
                saveStringArray.append(labelSentence)
                
            }
            
        }
        
        tableView1.reloadData()
    }
    
    func clear()
    {
        saveStringArray.removeAll()
        
        saveStringArray.append("SAVE HISTORY")
        
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


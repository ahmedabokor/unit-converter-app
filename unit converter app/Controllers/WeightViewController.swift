//
//  WeightViewController.swift
//  unit converter app
//
//  Created by Ahmed Abokor on 25/02/18.
//

import UIKit

class WeightViewController: UIViewController, UITextFieldDelegate , KeyboardDelegate{
    
    
    //IBOutlets to the textfiedls for getting and outputing values
    @IBOutlet weak var ounce: UITextField!
    @IBOutlet weak var lb: UITextField!
    @IBOutlet weak var gram: UITextField!
    @IBOutlet weak var stne: UITextField!
    @IBOutlet weak var kilogram: UITextField!
    
    
    @IBOutlet weak var stones: UITextField!
    
    @IBOutlet weak var pounds: UITextField!
    //Link to background view for tap getsure to dismiss keyboard
    @IBOutlet weak var BG: UIView!
    
    @IBOutlet weak var saveButtonBottom: NSLayoutConstraint!
    
    @IBOutlet weak var historyButtomBottom: NSLayoutConstraint!
    
    var decFlag = 0
    
    //If your observer does not inherit from an Objective-C object, you must prefix your function with @objc in order to use it as a selector - when you use #selector
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(ounce.text, forKey: "celciusValue")
        defaults.set(lb.text, forKey: "farValue")
        defaults.set(gram.text, forKey: "kelValue")
        defaults.set(stne.text,forKey:"stone")
        defaults.set(kilogram.text,forKey:"kilo")
        
        
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let celValue = defaults.string(forKey: "celciusValue")
        let farValue = defaults.string(forKey: "farValue")
        let kelValue = defaults.string(forKey: "kelValue")
        let stone = defaults.string(forKey: "stone")
        let kilo = defaults.string(forKey: "kilo")
        ounce.text = celValue
        lb.text = farValue
        gram.text = kelValue
        kilogram.text=kilo
        stne.text=stone
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - VARIABLES
     
     */
    var keyboardHeight : Int = 0
    var check : Int = 0
    var kg : Double = 0.0, stone : Double = 0.0, pound : Double = 0.0,  oz : Double = 0.0, gm : Double = 0.0
    
    var stnePound : Int = 0 , stn : Int = 0
    
    var buttonDim : CGFloat = 0
    
    var orginalY : CGFloat = 0
    
    
    
    
    
    var saveDictionary : [String:Double] = ["ounce" : 0.0, "pound" : 0.0, "gram" : 0.0, "stone" : 0.0, "kilogram" : 0.0]
    var recentDictionary : [String:Double] = ["ounce" : 0.0, "pound" : 0.0, "gram" : 0.0, "stone" : 0.0, "kilogram" : 0.0]
    
    var saveArray : [[String : Double]] = [[:]]
    var recentArray : [[String : Double]] = [[:]]
    
    let userDefaults = UserDefaults.standard
    var saveCount : Int = 0
    var recentCount : Int = 0
    
    
    //Save button clicked, tuples inserted into the user defaults
    
    @IBAction func saveClicked(_ sender: Any)
    {
        saveCount = saveArray.count
        let n = saveCount
        saveCount = 0
        if(saveCount < n)
        {
            
            saveDictionary = ["ounce" : oz, "pound" : pound, "gram" : gm, "stone" : stone, "kilogram" : kg]
            
            if(saveArray[saveCount] == [:])
            {
                saveArray[saveCount] = saveDictionary
            }
                
            else
            {
                saveArray.append(saveDictionary)
            }
            saveCount += 1
            
            
        }
        else
        {
            
            for j in 0...3
            {
                saveArray[j] = saveArray[j+1]
            }
            
            saveDictionary = ["ounce" : oz, "pound" : pound, "gram" : gm, "stone" : stone, "kilogram" : kg]
            saveArray[4] = saveDictionary
        }
        
        userDefaults.set(self.saveArray, forKey: "WeightSaveHistory")
        print(saveArray)
    }
    
    
    
    
    func initialize ()
    {
        if (userDefaults.array(forKey: "WeightSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "WeightSaveHistory") as! [[String : Double]]
            saveCount = saveArray.count
        }
        
        
        
        if (userDefaults.array(forKey: "WeightRecentHistory") != nil)
        {
            recentArray = userDefaults.array(forKey: "WeightRecentHistory") as! [[String : Double]]
            
            recentCount = recentArray.count
        }
        
        print("SAVE ARRAY \(saveArray)")
        print("recent arary  \(recentArray)")
        
    }
    
    /*
    func saveRecent()
    {
        
        recentCount = recentArray.count
        let n = recentCount
        recentCount = 0
        if(recentCount < n )
        {
            
            
            recentDictionary = ["ounce" : oz, "pound" : pound, "gram" : gm, "stone" : stone, "kilogram" : kg]
            
            if(recentArray[recentCount] == [:])
            {
                recentArray[recentCount] = recentDictionary
            }
                
            else
            {
                recentArray.append(recentDictionary)
            }
            recentCount += 1
        }
        else
        {
            
            for j in 0...3
            {
                recentArray[j] = recentArray[j+1]
            }
            
            recentDictionary = ["ounce" : oz, "pound" : pound, "gram" : gm, "stone" : stone, "kilogram" : kg]
            recentArray[4] = recentDictionary
        }
        
        userDefaults.set(self.recentArray, forKey: "WeightRecentHistory")
        
    }
    */
    /*
     // MARK: - VIEW DID LOAD
     
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ounce.becomeFirstResponder()
        //handle the app quitting
        
        
        //notification
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(WeightViewController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        
        // delegates to the UITextField to get
        ounce.delegate = self
        kilogram.delegate = self
        gram.delegate = self
        stne.delegate = self
        lb.delegate = self
        stones.delegate=self
        pounds.delegate=self
        
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        BG.addGestureRecognizer(tap)
        
        
        
        let KeyboardView = keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 241))
        KeyboardView.delegate = self
        
        initialize()
        
        gram.inputView = KeyboardView
        kilogram.inputView = KeyboardView
        ounce.inputView = KeyboardView
        stne.inputView = KeyboardView
        lb.inputView = KeyboardView
        stones.inputView=KeyboardView
        pounds.inputView=KeyboardView
    }
    
    
    
    func keyWasTapped(character: String)
    {
        
        var string : String = ""
        
        if(character == "a")
        {
            if check == 0 && ounce.text?.count != 0
            {
                
                string = String(describing: ounce.text!.prefix((ounce.text?.count)!-1))
                ounce.text = string
                
                if(ounce.text != nil)
                {
                    convert(tag: 0, txt: ounce.text!)
                }
            }
                
                
            else if check == 1 && lb.text?.count != 0
            {
                string = String(describing: lb.text!.prefix((lb.text?.count)!-1))
                lb.text = string
                
                if(lb.text != nil)
                {
                    convert(tag: 1, txt: lb.text!)
                }
            }
                
                
            else if check == 2 && gram.text?.count != 0
            {
                string = String(describing: gram.text!.prefix((gram.text?.count)!-1))
                gram.text = string
                
                if(gram.text != nil)
                {
                    convert(tag: 2, txt: gram.text!)
                }
            }
                
            else if check == 3 && stne.text?.count != 0
            {
                string = String(describing: stne.text!.prefix((stne.text?.count)!-1))
                stne.text = string
                
                if(stne.text != nil)
                {
                    convert(tag: 3, txt: stne.text!)
                }
            }
                
            else if check == 4 && kilogram.text?.count != 0
            {
                string = String(describing: kilogram.text!.prefix((kilogram.text?.count)!-1))
                kilogram.text = string
                
                if(kilogram.text != nil)
                {
                    convert(tag: 4, txt: kilogram.text!)
                }
            }
        
            
        else if check == 5 && stones.text?.count != 0
        {
            string = String(describing: stones.text!.prefix((stones.text?.count)!-1))
            stones.text = string
            
            if(stones.text != nil)
            {
                convert(tag: 5, txt: stones.text!)
            }
        }
         
        else if check == 6 && pounds.text?.count != 0
        {
            string = String(describing: pounds.text!.prefix((pounds.text?.count)!-1))
            pounds.text = string
            
            if(pounds.text != nil)
            {
                convert(tag: 5, txt: pounds.text!)
            }
        }
            
        }
            
            
        else if(character == "-")
        {
            
        }
            
            
       // else if (character == "." && decFlag == 1)
        else if (character == "." && decFlag == 1)
        {
        
            
            var flagDec = true
            
            if check == 0
            {
                let str = ounce.text
                
                for char in str!
                {
                    if(char == ".")
                    {
                        flagDec = false
                    }
                }
                
                if(flagDec == true)
                {
                    ounce.text?.append(character)
                    
                    if(ounce.text != nil)
                    {
                        convert(tag: 0, txt: ounce.text!)
                    }
                }
                
            }
                
                
            else if check == 1
            {
                
                var flagDec = true
                
                let str = lb.text
                
                for char in str!
                {
                    if(char == ".")
                    {
                        flagDec = false
                    }
                }
                
                if(flagDec == true)
                {
                    lb.text?.append(character)
                    
                    if(lb.text != nil)
                    {
                        convert(tag: 1, txt: lb.text!)
                    }
                }
                
            }
                
                
                
            else if check == 2
            {
                var flagDec = true
                
                let str = gram.text
                
                for char in str!
                {
                    if(char == ".")
                    {
                        flagDec = false
                    }
                }
                
                if(flagDec == true)
                {
                    gram.text?.append(character)
                    
                    if(gram.text != nil)
                    {
                        convert(tag: 2, txt: gram.text!)
                    }
                }
                
            }
                
            else if check == 3
            {
                
                var flagDec = true
                
                let str = stne.text
                
                for char in str!
                {
                    if(char == ".")
                    {
                        flagDec = false
                    }
                }
                
                if(flagDec == true)
                {
                    stne.text?.append(character)
                    
                    if(stne.text != nil)
                    {
                        convert(tag: 3, txt: stne.text!)
                    }
                    
                }
            }
                
            else if check == 4
            {
                
                var flagDec = true
                
                let str = kilogram.text
                
                for char in str!
                {
                    if(char == ".")
                    {
                        flagDec = false
                    }
                }
                
                if(flagDec == true)
                {
                    kilogram.text?.append(character)
                    
                    if(kilogram.text != nil)
                    {
                        convert(tag: 4, txt: kilogram.text!)
                    }
                    
                }
            }
            
//            else if check == 5
//            {
//
//                var flagDec = true
//
//                let str = stones.text
//
//                for char in str!
//                {
//                    if(char == ".")
//                    {
//                        flagDec = false
//                    }
//                }
//
//                if(flagDec == true)
//                {
//                    stones.text?.append(character)
//
//                    if(stones.text != nil)
//                    {
//                        convert(tag: 4, txt: stones.text!)
//                    }
//
//                }
//            }
        }
    
        
            
        else
        {
            if(character == ".")
            {
                decFlag = 1
            }
            
            
            if check == 0
            {
                ounce.text?.append(character)
                
                if(ounce.text != nil)
                {
                    convert(tag: 0, txt: ounce.text!)
                }
            }
                
                
            else if check == 1
            {
                
                lb.text?.append(character)
                
                if(lb.text != nil)
                {
                    convert(tag: 1, txt: lb.text!)
                }
            }
                
                
            else if check == 2
            {
                
                gram.text?.append(character)
                
                if(gram.text != nil)
                {
                    convert(tag: 2, txt: gram.text!)
                }
                
            }
                
            else if check == 3
            {
                
                stne.text?.append(character)
                
                if(stne.text != nil)
                {
                    convert(tag: 3, txt: stne.text!)
                }
                
            }
                
            else if check == 4
            {
                
                kilogram.text?.append(character)
                
                if(kilogram.text != nil)
                {
                    convert(tag: 4, txt: kilogram.text!)
                }
                
            }
                
            else if check == 5
            {
                
                stones.text?.append(character)
                
                if(stones.text != nil)
                {
                    convert(tag: 5, txt: stones.text!)
                }
                
            }
            
            else if check == 6
            {
                
                pounds.text?.append(character)
                
                if(pounds.text != nil)
                {
                    convert(tag: 6, txt: pounds.text!)
                }
                
            }
        
        }
    }
    
    
    
    
    /*
     // MARK: - Did begin editing function for textfields
     //required for enabling the (.) decimal button
     */
    
    
    
    /*func textFieldDidBeginEditing(_ textField: UITextField)
    {
        check = textField.tag
        
        saveButtonBottom.constant += 200
        historyButtomBottom.constant += 200
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if(kg != 0)
        {
            saveRecent()
        }
        saveButtonBottom.constant -= 200
        historyButtomBottom.constant -= 200
        
    }*/
    //positions the tab bar and buttons above the keyboard
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        check = textField.tag
        
        var tabBarFrame : CGRect = (self.tabBarController?.tabBar.frame)!
        tabBarFrame.origin.y -= 245
        
        UIView.animate(withDuration: 0.2)
        {
            self.tabBarController?.tabBar.frame = tabBarFrame
            self.saveButtonBottom.constant += 245
            self.historyButtomBottom.constant += 245
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
       var tabBarFrame : CGRect = (self.tabBarController?.tabBar.frame)!
    tabBarFrame.origin.y += 245
        
        UIView.animate(withDuration: 0.2)
        {
            self.tabBarController?.tabBar.frame = tabBarFrame
            self.saveButtonBottom.constant -= 245
            self.historyButtomBottom.constant -= 245
        }
        
    }
    
    
    
    
    /*
     // MARK: - CONVERT FUNCTION
     //converts the selected unit into all the other units
     // Then calls updateFeilds() to update the textFeilds
     */
    func convert(tag: Int, txt: String)
    {
        var txtVal : Double
        
        
        if(Double(txt) == nil)
        {
            txtVal  = 0.0
        }
            
        else
        {
            txtVal  = Double(txt)!
        }
        
        
        
        if tag == 0
        {
            oz = txtVal
            pound = oz * 0.0625
            stone = pound/14
            kg = pound/2.20462
            gm = kg * 1000
            stn = Int(pound/14)
            stnePound = Int(pound - Double(stn * 14))
        }
            
            
        else if tag == 1
        {
            pound = txtVal
            oz = pound/0.0625
            stone = pound/14
            kg = pound/2.20462
            gm = kg * 1000
            stn = Int(pound/14)
            stnePound = Int(pound - Double(stn * 14))
        }
            
            
        else if tag == 2
        {
            gm = txtVal
            kg = gm/1000
            pound = kg*2.20462
            oz = pound/0.0625
            stone = pound/14
            stn = Int(pound/14)
            stnePound = Int(pound - Double(stn * 14))
        }
            
            
        else if tag == 3
        {
            stone = txtVal
            pound = stone * 14
            oz = pound/0.0625
            kg = pound/2.20462
            gm = kg * 1000
            stn = Int(pound/14)
            stnePound = Int(pound - Double(stn * 14))
        }
            
            
            
        else if tag == 4
        {
            kg = txtVal
            gm = kg*1000
            pound = kg*2.20462
            oz = pound/0.0625
            stone = pound/14
            stn = Int(pound/14)
            stnePound = Int(pound - Double(stn * 14))
            
            
        }
          
            
            
        else if tag == 5
        {
            var temp = 0.0
            stn = Int(txtVal)
            print("STOOOOONEEEE  :::::::::: \(stn)")
            if(pounds.text != "")
            {
                temp = Double(pounds.text!)!
            }
           
            pound = Double(stn * 14) + temp
            oz = pound/0.0625
            kg = pound/2.20462
            gm = kg*1000
            stone = pound/14
           
        }
        
        else if tag == 6
        {
            var temp = 0.0
            stnePound = Int(txtVal)
            print("STOOOOONEEEE POOOOUUUNNDDD :::::::::: \(stnePound)")
            if(stones.text != "")
            {
                temp = Double(stones.text!)!
                print("STONE IN POUND ::: :::::: \(temp)")
            }
            
            pound = (temp * 14) + Double(stnePound)
            oz = pound/0.0625
            kg = pound/2.20462
            gm = kg*1000
            stone = pound/14
            
        }
        
        updateFeilds(tag: tag)
    }
    
    
    
    /*
     // MARK: - UPDATE FIELDS
     //updates all the textFeilds with the coverted values
     */
    
    func updateFeilds(tag: Int)
    {
        
        if(tag == 0)
        {
            lb.text = "\(pound.rounded(toPlaces: 4))"
            gram.text = "\(gm.rounded(toPlaces: 4))"
            stne.text = "\(stone.rounded(toPlaces: 4))"
            kilogram.text = "\(kg.rounded(toPlaces: 4))"
            stones.text = "\(stn)"
            pounds.text = "\(stnePound)"
        }
            
            
            
        else if(tag == 1)
        {
            ounce.text = "\(oz.rounded(toPlaces: 4))"
            gram.text = "\(gm.rounded(toPlaces: 4))"
            stne.text = "\(stone.rounded(toPlaces: 4))"
            kilogram.text = "\(kg.rounded(toPlaces: 4))"
            stones.text = "\(stn)"
            pounds.text = "\(stnePound)"
            
        }
            
            
            
        else if(tag == 2)
        {
            ounce.text = "\(oz.rounded(toPlaces: 4))"
            lb.text = "\(pound.rounded(toPlaces: 4))"
            
            stne.text = "\(stone.rounded(toPlaces: 4))"
            kilogram.text = "\(kg.rounded(toPlaces: 4))"
            stones.text = "\(stn)"
            pounds.text = "\(stnePound)"
        }
            
            
            
        else if(tag == 3)
        {
            
            ounce.text = "\(oz.rounded(toPlaces: 4))"
            lb.text = "\(pound.rounded(toPlaces: 4))"
            gram.text = "\(gm.rounded(toPlaces: 4))"
            kilogram.text = "\(kg.rounded(toPlaces: 4))"
            stones.text = "\(stn)"
            pounds.text = "\(stnePound)"
        }
            
            
        else if(tag == 4)
        {
            
            ounce.text = "\(oz.rounded(toPlaces: 4))"
            lb.text = "\(pound.rounded(toPlaces: 4))"
            gram.text = "\(gm.rounded(toPlaces: 4))"
            stne.text = "\(stone.rounded(toPlaces: 4))"
            stones.text = "\(stn)"
            pounds.text = "\(stnePound)"
            
        }
            
        else if(tag == 5)
        {
            
            ounce.text = "\(oz.rounded(toPlaces: 4))"
            lb.text = "\(pound.rounded(toPlaces: 4))"
            gram.text = "\(gm.rounded(toPlaces: 4))"
            stne.text = "\(stone.rounded(toPlaces: 4))"
            kilogram.text = "\(kg.rounded(toPlaces: 4))"
            
        }
        
        else if(tag == 6)
        {
            
            ounce.text = "\(oz.rounded(toPlaces: 4))"
            lb.text = "\(pound.rounded(toPlaces: 4))"
            gram.text = "\(gm.rounded(toPlaces: 4))"
            stne.text = "\(stone.rounded(toPlaces: 4))"
            kilogram.text = "\(kg.rounded(toPlaces: 4))"
            
        }
        
        
        
    }
    
    
    /*
     // MARK: -  DISMISS KEYBOARD
     //dismisses keyboard whenever user uses tap gesture on the BG(background view)
     */
    @objc func dismissKeyboard()
    {
        
        print("Here.... vkmfkmvlfvmfdcvm")
        if check == 0
        {
            ounce.endEditing(true)
        }
            
            
        else if check == 1
        {
            lb.endEditing(true)
        }
            
            
        else if check == 2
        {
            gram.endEditing(true)
        }
            
            
        else if check == 3
        {
            stne.endEditing(true)
        }
            
            
            
        else if check == 4
        {
            kilogram.endEditing(true)
            
        }
        else if check == 5
        {
            pounds.endEditing(true)
            
        }
        else if check == 6
        {
            stones.endEditing(true)
            
        }
    }
}


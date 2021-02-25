//
//  DistanceViewController.swift
//  unit converter app
//
//  Created by Ahmed Abokor on 26/02/18.
//

import UIKit

class DistanceViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {

    
    /*
     // MARK: - IBOutlets
     */
    
    
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var textbox2: UITextField!
    @IBOutlet weak var textbox3: UITextField!
    @IBOutlet weak var textbox4: UITextField!
    @IBOutlet weak var textbox5: UITextField!
    
    @IBOutlet weak var BG: UIView!
    
    @IBOutlet weak var historyButtomBottom: NSLayoutConstraint!
    
    
   
    @IBOutlet weak var saveButtonBottom: NSLayoutConstraint!
    
    
    /*
     // MARK: - VARIABLES
     */
    
    
    
    
    var check : Int = 0
    var keyboardHeight : Int = 0
    
    var mtr : Double = 0.0, cm : Double = 0.0, mm : Double = 0.0, yard : Double = 0.0, inch : Double = 0.0
    
    
    
    var saveDictionary : [String:Double] = ["cm" : 0.0, "metre" : 0.0, "inch" : 0.0, "yard" : 0.0, "milimetre" : 0.0]
    
    
    var saveArray : [[String : Double]] = [[:]]
   
    
    let userDefaults = UserDefaults.standard
    var saveCount : Int = 0
    
    
    
    
    //Save button clicked, tuples inserted into the user defaults
    @IBAction func saveClicked(_ sender: Any)
    {
        saveCount = saveArray.count
        let n = saveCount
        saveCount = 0
        if(saveCount < n)
        {
           
            saveDictionary = ["cm" : cm, "metre" : mtr, "inch" : inch, "yard" : yard, "milimetre" : mm]
            
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
            
           saveDictionary = ["cm" : cm, "metre" : mtr, "inch" : inch, "yard" : yard, "milimetre" : mm]
            saveArray[4] = saveDictionary
        }
        
        userDefaults.set(self.saveArray, forKey: "DistanceSaveHistory")
        print(saveArray)
    }
    
    
    
    
    func initialize ()
    {
        if (userDefaults.array(forKey: "DistanceSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "DistanceSaveHistory") as! [[String : Double]]
            saveCount = saveArray.count
        }
        
        
        
       
        
    }
    
    
  
    
    
    
    /*
     // MARK: - VIEW DID LOAD
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        BG.addGestureRecognizer(tap)
        
        textbox1.delegate = self
        textbox2.delegate = self
        textbox3.delegate = self
        textbox4.delegate = self
        textbox5.delegate = self
        
        initialize()
        
        let KeyboardView = keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 241))
        KeyboardView.delegate = self
        
        textbox1.inputView = KeyboardView
        textbox2.inputView = KeyboardView
        textbox3.inputView = KeyboardView
        textbox4.inputView = KeyboardView
        textbox5.inputView = KeyboardView
        
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     // MARK: - GET KEY PRESS FROM CUSTOM KEYBOARD
     //uses delegate to get value of the key pressed
     */
    
    func keyWasTapped(character: String)
    {
        
        var string : String = ""
        
        if(character == "a")//backspace pressed
        {
            if check == 0 && textbox1.text!.count != 0
            {
                
                string = String(describing: textbox1.text!.prefix((textbox1.text?.count)!-1))//substring creation to duplicate backspace
                textbox1.text = string
                convert(tag: 0, txt: textbox1.text!)
            }
                
                
            else if check == 1 && textbox2.text!.count != 0
            {
                string = String(describing: textbox2.text!.prefix((textbox2.text?.count)!-1))
                textbox2.text = string
                convert(tag: 1, txt: textbox2.text!)
            }
                
                
            else if check == 2 && textbox3.text!.count != 0
            {
                string = String(describing: textbox3.text!.prefix((textbox3.text?.count)!-1))
                textbox3.text = string
                convert(tag: 2, txt: textbox3.text!)
            }
            
            else if check == 3 && textbox4.text!.count != 0
            {
                string = String(describing: textbox4.text!.prefix((textbox4.text?.count)!-1))
                textbox4.text = string
                convert(tag: 3, txt: textbox4.text!)
            }
            
            else if check == 4 && textbox5.text!.count != 0
            {
                string = String(describing: textbox5.text!.prefix((textbox5.text?.count)!-1))
                textbox5.text = string
                convert(tag: 4, txt: textbox5.text!)
            }
        }
        
        
        else if(character == "-")
        {
            
        }
            
            
            
        else//key append to textfield
        {
            if check == 0
            {
                textbox1.text?.append(character)
                convert(tag: 0, txt: textbox1.text!)
            }
                
                
            else if check == 1
            {
                textbox2.text?.append(character)
                convert(tag: 1, txt: textbox2.text!)
            }
                
                
            else if check == 2
            {
                textbox3.text?.append(character)
                convert(tag: 2, txt: textbox3.text!)
            }
            
            else if check == 3
            {
                textbox4.text?.append(character)
                convert(tag: 3, txt: textbox4.text!)
            }
            
            else if check == 4
            {
                textbox5.text?.append(character)
                convert(tag: 4, txt: textbox5.text!)
            }
        }
    }
    
    
    
    /*
     // MARK: - DID_BEGIN_EDITING & DID_END_EDITING
     //required for live updating of other textboxes
     */
    
    
    //positions the tab bar and buttons above the keyboard
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        check = textField.tag
        
        var tabBarFrame : CGRect = (self.tabBarController?.tabBar.frame)!
        tabBarFrame.origin.y = 380
        
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
        tabBarFrame.origin.y = 620
        
        UIView.animate(withDuration: 0.2)
        {
            self.tabBarController?.tabBar.frame = tabBarFrame
            self.saveButtonBottom.constant -= 245
            self.historyButtomBottom.constant -= 245
        }
        
    }
    
    
// dismiss keyboard
    
    @objc func dismissKeyboard()
    {
        
        
        if check == 0
        {
            textbox1.endEditing(true)
        }
            
            
        else if check == 1
        {
            textbox2.endEditing(true)
        }
            
            
        else if check == 2
        {
            textbox3.endEditing(true)
        }
            
            
        else if check == 3
        {
            textbox4.endEditing(true)
        }
            
            
            
        else if check == 4
        {
            textbox5.endEditing(true)
            
        }
    }
    
    
    /*
     // MARK: - CONVERSIONS
     
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
            cm = txtVal
            mtr = cm/100
            inch = mtr * 39.3701
            yard = mtr * 1.09361
            mm = cm * 10
        }
            
            
        else if tag == 1
        {
            mtr = txtVal
            cm = mtr * 100
            inch = mtr * 39.3701
            yard = mtr * 1.09361
            mm = cm * 10
            
        }
            
            
        else if tag == 2
        {
            inch = txtVal
            mtr = inch/39.3701
            cm = mtr * 100
            yard = mtr * 1.09361
            mm = cm * 10
        }
            
            
        else if tag == 3
        {
            yard = txtVal
            mtr = yard/1.09361
            cm = mtr * 100
            inch = mtr * 39.3701
            mm = cm * 10
            
        }
            
            
            
        else if tag == 4
        {
            mm = txtVal
            cm = mm/10
            mtr = cm/100
            inch = mtr * 39.3701
            yard = mtr * 1.09361
            
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
            
            textbox2.text = "\(mtr)"
            textbox3.text = "\(inch)"
            textbox4.text = "\(yard)"
            textbox5.text = "\(mm)"
            
        }
            
            
            
        else if(tag == 1)
        {
            textbox1.text = "\(cm)"
            
            textbox3.text = "\(inch)"
            textbox4.text = "\(yard)"
            textbox5.text = "\(mm)"
        }
            
            
            
        else if(tag == 2)
        {
            textbox1.text = "\(cm)"
            textbox2.text = "\(mtr)"
            
            textbox4.text = "\(yard)"
            textbox5.text = "\(mm)"
        }
            
            
            
        else if(tag == 3)
        {
            textbox1.text = "\(cm)"
            textbox2.text = "\(mtr)"
            textbox3.text = "\(inch)"
            
            textbox5.text = "\(mm)"
            
        }
            
            
        else if(tag == 4)
        {
            
            textbox1.text = "\(cm)"
            textbox2.text = "\(mtr)"
            textbox3.text = "\(inch)"
            textbox4.text = "\(yard)"
            
            
        }
        
        
        
    }
   

}

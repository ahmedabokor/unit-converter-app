//
//  SpeedViewController.swift
//  unit converter app
//
//  Created by Ahmed Abokor on 26/02/18.
//

import UIKit

class SpeedViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {

    
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var textbox2: UITextField!
    @IBOutlet weak var textbox3: UITextField!
    
    @IBOutlet weak var BG: UIView!
    
    
    @IBOutlet weak var saveButtonBottom: NSLayoutConstraint!
    
    @IBOutlet weak var historyButtomBottom: NSLayoutConstraint!
    /*
     // MARK: - VARIABLES
     
     */
    
    var check : Int = 0
    var m_s : Double = 0.0, km_hr : Double = 0.0 , miles_hr : Double = 0.0
    var keyboardHeight : Int = 0
    
    var saveDictionary : [String:Double] = ["m/s" : 0.0, "km/hr" : 0.0, "miles/hr" : 0.0]
    
    
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
            
            saveDictionary = ["m/s" : m_s, "km/hr" : km_hr, "miles/hr" : miles_hr]
            
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
            
            saveDictionary = ["m/s" : m_s, "km/hr" : km_hr, "miles/hr" : miles_hr]
            saveArray[4] = saveDictionary
        }
        
        userDefaults.set(self.saveArray, forKey: "SpeedSaveHistory")
        
    }
    
    
    
    
    func initialize ()
    {
        if (userDefaults.array(forKey: "SpeedSaveHistory") != nil)
        {
            saveArray = userDefaults.array(forKey: "SpeedSaveHistory") as! [[String : Double]]
            saveCount = saveArray.count
        }
    }
    
    
    /*
     // MARK: - VIEW DID LOAD
     
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        textbox1.delegate = self
        textbox2.delegate = self
        textbox3.delegate = self
        
        let KeyboardView = keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 241))
        KeyboardView.delegate = self
        
        textbox1.inputView = KeyboardView
        textbox2.inputView = KeyboardView
        textbox3.inputView = KeyboardView
     
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        BG.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        initialize()
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
    
    
    
    
    
    /*
     // MARK: - kEYBOARD DISMISS
     
     */
    
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
            m_s = txtVal
            km_hr = m_s * 3.6
            miles_hr = km_hr/1.60934
        }
            
            
        else if tag == 1
        {
            km_hr = txtVal
            m_s = km_hr / 3.6
            miles_hr = km_hr/1.60934
            
        }
            
            
        else if tag == 2
        {
            miles_hr = txtVal
            km_hr = miles_hr * 1.60934
            m_s = km_hr / 3.6
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
        {textbox2.text = "\(km_hr)"
            textbox3.text = "\(miles_hr)"
        }
        else if(tag == 1)
        {
            textbox1.text = "\(m_s)"
            textbox3.text = "\(miles_hr)"
            
        }
        else if(tag == 2)
        {
            textbox1.text = "\(m_s)"
            textbox2.text = "\(km_hr)"
        }
    }
    
    
}

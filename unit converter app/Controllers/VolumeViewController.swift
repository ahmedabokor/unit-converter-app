//
//  VolumeViewController.swift
//  unit converter app
//
//  Created by Ahmed Abokor on 26/02/18.
//

import UIKit

class VolumeViewController: UIViewController, UITextFieldDelegate , KeyboardDelegate{

    
    
    /*
     // MARK: - VARIABLES
     
     */
    
    var mtr : Double = 0.0, cm : Double = 0.0, ltrsld : Double = 0.0// for storing coverted values of solid volumes
    var gal : Double = 0.0, ltr : Double = 0.0, pint : Double = 0.0, floz : Double = 0.0 // for storing coverted values of liquid volumes
    var currentSegment : Int = 0
    var keyboardHeight = 0
    var check : Int = 0
    var originalY : CGFloat = 0
    var flag = 0
    
    
    
    var solidSaveDictionary : [String:Double] = ["metre" : 0.0, "cm" : 0.0, "litre" : 0.0]
   
    
    var solidSaveArray : [[String : Double]] = [[:]]
    
    
    var liquidSaveDictionary : [String:Double] = ["gallon" : 0.0, "litre" : 0.0, "pint" : 0.0, "fluid-oz" : 0.0]
    
    
    var liquidSaveArray : [[String : Double]] = [[:]]
    
    
    let userDefaults = UserDefaults.standard
    var solidSaveCount  : Int = 0
    
    
    var liquidSaveCount  : Int = 0
    
    
    
    
    // IBOutlets of all textbox and labels, so that we can update the labels for the differnt segments
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var unitLabel1: UILabel!
    @IBOutlet weak var textbox1: UITextField!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var unitLabel2: UILabel!
    @IBOutlet weak var textbox2: UITextField!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var unitLabel3: UILabel!
    @IBOutlet weak var textbox3: UITextField!
    
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var unitLabel4: UILabel!
    @IBOutlet weak var textbox4: UITextField!
    
    
    //IBOutlets for the differnt buttons
    @IBOutlet weak var constantsBtn: UIButton!
    @IBOutlet weak var atomicConstantsBtm: UIButton!
    @IBOutlet weak var historyBtm: UIButton!
    @IBOutlet weak var saveButtonBottom: NSLayoutConstraint!
    
    @IBOutlet weak var historyButtomBottom: NSLayoutConstraint!
    
    //IBOutlet for the Background for enabling tap gesture to dismiss keyboard
    @IBOutlet weak var BG: UIView!
    
    
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textbox1.text, forKey: "metre")
        defaults.set(textbox2.text, forKey: "cm")
        defaults.set(textbox3.text, forKey: "litre")
        
      
        
        
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let metre = defaults.string(forKey: "metre")
        let cmValue = defaults.string(forKey: "cm")
        let litValue = defaults.string(forKey: "litre")
    
       
        textbox1.text = metre
        textbox2.text = cmValue
        textbox3.text=litValue

        
    }
    // Segment Switcher for switchong between liquid and solid volumes
    @IBAction func switcherButton(_ sender: UISegmentedControl)
    {
        currentSegment = sender.selectedSegmentIndex
        
        if(sender.selectedSegmentIndex == 0)
        {
           //updates layou and text
            hideExtras()
            changeNameSolids()
            cleartxt()
            
        }
        
        else
        {
            //updates layou and text
            showExtra()
            changeNameLiquids()
            cleartxt()
        }
        
    }
    
    
    
    @IBAction func saveClicked(_ sender: Any)
    {
        if(currentSegment == 0)
        {
            solidSaveCount = solidSaveArray.count
            let n = solidSaveCount
            solidSaveCount = 0
            if(solidSaveCount < n)
            {
                
                solidSaveDictionary = ["metre" : mtr, "cm" : cm, "litre" : ltrsld]
                
              
                    if (solidSaveArray[solidSaveCount] == [:] )
                    {
                        solidSaveArray[solidSaveCount] = solidSaveDictionary
                    }
                  
                else
                {
                    solidSaveArray.append(solidSaveDictionary)
                }
                
                solidSaveCount  += 1
            }
                
                
            else
            {
                
                for j in 0...3
                {
                    solidSaveArray[j] = solidSaveArray[j+1]
                }
                
                solidSaveDictionary = ["metre" : mtr, "cm" : cm, "litre" : ltrsld]
                solidSaveArray[4] = solidSaveDictionary
            }
            userDefaults.set(self.solidSaveArray, forKey: "SolidVolumeSaveHistory")
        }
        
        
            
        else
        {
            liquidSaveCount = liquidSaveArray.count
            let n = liquidSaveCount
            liquidSaveCount = 0
            if(liquidSaveCount < n)
            {
                liquidSaveDictionary = ["gallon" : gal, "litre" : ltr, "pint" : pint, "fluid-oz" : floz]
                
                if(liquidSaveArray[liquidSaveCount]  == [:])//to ensure null arrays are overwritten
                {
                    liquidSaveArray[liquidSaveCount] = liquidSaveDictionary
                }
                    
                else
                {
                    liquidSaveArray.append(liquidSaveDictionary)
                }
                
                liquidSaveCount  += 1
            }
             
                
            else
            {
                for j in 0...3
                {
                    liquidSaveArray[j] = liquidSaveArray[j+1]
                }
                
                liquidSaveDictionary = ["gallon" : gal, "litre" : ltr, "pint" : pint, "fluid-oz" : floz]
                liquidSaveArray[4] = liquidSaveDictionary
            }
            userDefaults.set(self.liquidSaveArray, forKey: "LiquidVolumeSaveHistory")
        }
   }
    
    
    
    
    func initialize ()
    {
        if (userDefaults.array(forKey: "SolidVolumeSaveHistory") != nil)
        {
            solidSaveArray = userDefaults.array(forKey: "SolidVolumeSaveHistory") as! [[String : Double]]
            solidSaveCount  = solidSaveArray.count
        }
        
        
        
      
        
        if (userDefaults.array(forKey: "LiquidVolumeSaveHistory") != nil)
        {
            liquidSaveArray = userDefaults.array(forKey: "LiquidVolumeSaveHistory") as! [[String : Double]]
            liquidSaveCount  = liquidSaveArray.count
        }
        
        
       
        
        
    }
    
    
    
    
    
    
    
    
    /*
     // MARK: - On-Switch Functions
     //All functions to ensure correct labels and txtfeilds are showing on switch action
     //remaining label and hiding/unhiding extra components
     */
    
    func cleartxt()
    {
        textbox1.text = ""
        textbox2.text = ""
        textbox3.text = ""
        textbox4.text = ""
    }
    
     func hideExtras()
     {
        label4.isHidden = true
        unitLabel4.isHidden = true
        textbox4.isHidden = true
        
    }
    
    func showExtra()
    {
        label4.isHidden = false
        unitLabel4.isHidden = false
        textbox4.isHidden = false
       
    }
    
    func changeNameLiquids()
    {
        label1.text = "Gallon"
        unitLabel1.text = "gal"
        
        label2.text = "Litre"
        unitLabel2.text = "ltr"
        
        label3.text = "Pint"
        unitLabel3.text = "pt"
        
        label4.text = "fluidoz"
        unitLabel4.text = "fl. oz."
        
    }
    
    func changeNameSolids()
    {
        label1.text = "Metre"
        unitLabel1.text = "m3"
        
        label2.text = "Cm"
        unitLabel2.text = "cm3"
        
        label3.text = "Litre"
        unitLabel3.text = "ltr"
        
    }
    
   
    /*
     // MARK: - View did Load
    
     */

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(VolumeViewController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        originalY = constantsBtn.center.y
        
        textbox1.delegate = self
        textbox2.delegate = self
        textbox3.delegate = self
        textbox4.delegate = self
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        BG.addGestureRecognizer(tap)
       
        let KeyboardView = keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 241))
        KeyboardView.delegate = self
        
        initialize()
        
        textbox1.inputView = KeyboardView
        textbox2.inputView = KeyboardView
        textbox3.inputView = KeyboardView
        textbox4.inputView = KeyboardView
        
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
    
    
    
    
  // key press function from custom keyboard
    func keyWasTapped(character: String)
    {
        
        var string : String = ""
        
        if(character == "a")
        {
            if check == 0 && textbox1.text?.count != 0
            {
                
                string = String(describing: textbox1.text!.prefix((textbox1.text?.count)! - 1))
                textbox1.text = string
                
                if(textbox1.text != nil)
                {
                    convert(tag: 0, txt: textbox1.text!)
                }
            }
                
                
            else if check == 1 && textbox2.text?.count != 0
            {
                string = String(describing: textbox2.text!.prefix((textbox2.text?.count)!-1))
                textbox2.text = string
                
                if(textbox2.text != nil)
                {
                    convert(tag: 1, txt: textbox2.text!)
                }
            }
                
                
            else if check == 2 && textbox3.text?.count != 0
            {
                string = String(describing: textbox3.text!.prefix((textbox3.text?.count)!-1))
                textbox3.text = string
                
                if(textbox3.text != nil)
                {
                    convert(tag: 2, txt: textbox3.text!)
                }
            }
                
            else if check == 3 && textbox4.text?.count != 0
            {
                string = String(describing: textbox4.text!.prefix((textbox4.text?.count)!-1))
                textbox4.text = string
                
                if(textbox4.text != nil)
                {
                    convert(tag: 3, txt: textbox4.text!)
                }
            }
            
        }
         
        else if(character == "-")
        {
            
        }
            
            
            
        else
        {
            if check == 0
            {
                
                
               textbox1.text?.append(character)
                
                if(textbox1.text != nil)
                {
                    convert(tag: 0, txt: textbox1.text!)
                }
            }
                
                
            else if check == 1
            {
                
                textbox2.text?.append(character)
                
                if(textbox2.text != nil)
                {
                    convert(tag: 1, txt: textbox2.text!)
                }
            }
                
                
            else if check == 2
            {
                
                textbox3.text?.append(character)
                
                if(textbox3.text != nil)
                {
                    convert(tag: 2, txt: textbox3.text!)
                }
            }
                
            else if check == 3
            {
                
               textbox4.text?.append(character)
                
                if(textbox4.text != nil)
                {
                    convert(tag: 3, txt: textbox4.text!)
                }
            }
        }
    }

   
    
    /*
     // MARK: - CONVERT covert all values depending upon segment
     //required for live updating of other textboxes
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
        
        
        if(currentSegment == 0)
        {
            if tag == 0
            {
                mtr = txtVal
                cm = mtr * 1000000
                ltrsld = mtr * 1000
            }
                
                
            else if tag == 1
            {
                
                cm = txtVal
                mtr = cm/1000000
                ltrsld = mtr * 1000
                
            }
                
                
            else if tag == 2
            {
                 ltrsld = txtVal
                 mtr = ltr/1000
                 cm = mtr*1000000
            }
        }
        
        else
        {
            if tag == 0
            {
                gal = txtVal
                ltr = gal * 3.785
                pint = ltr * 2.11338
                floz = ltr * 33.814
            }
                
                
            else if tag == 1
            {
                ltr = txtVal
                gal = ltr/3.785
                pint = ltr * 2.11338
                floz = ltr * 33.814
            }
                
                
            else if tag == 2
            {
                pint = txtVal
                ltr = pint/2.11338
                gal = ltr/3.758
                floz = ltr * 33.814
            }
                
                
            else if tag == 3
            {
                floz = txtVal
                ltr = floz/33.814
                gal = ltr/3.785
                pint = ltr * 2.11338
            }
        }
        
        updateFeilds(tag: tag)
    }
    
    
    
    
    /*
     // MARK: - UPDATE FIELDS
     //updates all the textFeilds with the coverted values
     */
    
    func updateFeilds(tag: Int)
    {
        
        if(currentSegment == 0)
        {
            if tag == 0
            {
               textbox2.text = "\(cm)"
               textbox3.text = "\(ltrsld)"
            }
                
                
            else if tag == 1
            {
                
                textbox1.text = "\(mtr)"
                textbox3.text = "\(ltrsld)"
                
            }
                
                
            else if tag == 2
            {
                textbox2.text = "\(cm)"
                textbox1.text = "\(mtr)"
            }
        }
            
        else
        {
            if tag == 0
            {
                
                textbox2.text = "\(ltr)"
                textbox3.text = "\(pint)"
                textbox4.text = "\(floz)"
            }
                
                
            else if tag == 1
            {
                textbox1.text = "\(gal)"
                
                textbox3.text = "\(pint)"
                textbox4.text = "\(floz)"
            }
                
                
            else if tag == 2
            {
                textbox1.text = "\(gal)"
                textbox2.text = "\(ltr)"
                
                textbox4.text = "\(floz)"
            }
                
                
            else if tag == 3
            {
                textbox1.text = "\(gal)"
                textbox2.text = "\(ltr)"
                textbox3.text = "\(pint)"
                
            }
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

    }
    
    
    

}

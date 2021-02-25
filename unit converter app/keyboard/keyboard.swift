import UIKit

protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
}


class keyboard: UIView
{
    
    weak var delegate: KeyboardDelegate?
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "keyboard" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    // MARK:- Button actions from .xib file
    
    @IBAction func keyTapped(sender: UIButton) {
        // When a button is tapped, send that information to the
        // delegate (ie, the view controller)
        if (sender.tag == 9)
        {
            self.delegate?.keyWasTapped(character: "a")
        }
        else
        {
            self.delegate?.keyWasTapped(character: sender.titleLabel!.text!)
        }
    }
    
}


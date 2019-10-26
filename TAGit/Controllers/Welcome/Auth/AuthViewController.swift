//
//  AuthViewController.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

enum AuthMode {
    case none
    case signIn
    case signUp
}

class AuthViewController: ContainerViewController {
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblTerms: UILabel!
    var mode: AuthMode = .none {
        didSet {
            if oldValue != mode {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mode = .signIn
        UIView.setAnimationsEnabled(false)
        self.performSegue(withIdentifier: "sid_signin", sender: self)
        UIView.setAnimationsEnabled(true)
        
        let text = "tos_pp".localized()
        lblTerms.text = text
        lblTerms.font = UIFont.regular(size: 12)
        let underlineAttriString = NSMutableAttributedString(string: text)
        let terms = (text as NSString).range(of: "terms_conditions".localized())
        let pp = (text as NSString).range(of: "privacy_policy".localized())
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.medium(size: 12), range: terms)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: terms)
        
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.medium(size: 12), range: pp)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: pp)
        
        lblTerms.attributedText = underlineAttriString
        lblTerms.isUserInteractionEnabled = true
        lblTerms.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLblTerms(gesture:))))
    }
    
    @IBAction func tapLblTerms(gesture: UITapGestureRecognizer) {
        let text = "tos_pp".localized()
        let terms = (text as NSString).range(of: "terms_conditions".localized())
        let pp = (text as NSString).range(of: "privacy_policy".localized())
        // comment for now
        //let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: terms) {
            let url = NSURL(string: "https://www.google.com/")
            let title = "terms_conditions".localized()
            let viewController = BrowserViewController(url: url! as URL, title: title)
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: pp) {
            let url = NSURL(string: "https://www.yahoo.com/")
            let title = "privacy_policy".localized()
            let viewController = BrowserViewController(url: url! as URL, title: title)
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
        }
    }
    @IBAction func onAuthModeSelected(_ sender: UIButton) {
        self.mode = (sender == btnSignIn ? .signIn: .signUp)
    }
    
    func updateUI() {
        var btnActive, btnInactive: UIButton?
        
        if mode == .signUp {
            btnActive = btnSignUp
            btnInactive = btnSignIn
        }
        else if mode == .signIn {
            btnActive = btnSignIn
            btnInactive = btnSignUp
        }
        
        btnActive?.titleLabel?.font = .regular(size: 26)
        btnInactive?.titleLabel?.font = .light(size: 26)
        btnActive?.titleLabel?.textColor = .appBlue
        btnInactive?.titleLabel?.textColor = .appGray
    }
}

//Social
extension AuthViewController {
    @IBAction func onSignInFacebook(_ sender: Any) {
        
    }
    
    @IBAction func onSignInGoogle(_ sender: Any) {
        
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

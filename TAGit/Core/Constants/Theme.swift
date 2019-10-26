//
//  Theme.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

// Color palette
extension UIColor {
    @nonobjc class var appBlue: UIColor {
        return UIColor(hexString: "61ACCD")
    }
    
    @nonobjc class var appBlueFacebook: UIColor {
        return UIColor(hexString: "3D61BB")
    }
    
    @nonobjc class var appRedGoogle: UIColor {
        return UIColor(hexString: "D93A48")
    }
    
    @nonobjc class var appCoral: UIColor {
        return UIColor(hexString: "DE6B6B")
    }
    
    @nonobjc class var appCoal: UIColor {
        return UIColor(hexString: "70849E")
    }
    
    @nonobjc class var appDarkGray: UIColor {
        return UIColor(hexString: "808080")
    }
    
    @nonobjc class var appGray: UIColor {
        return UIColor(hexString: "9FA8B4")
    }
    
    @nonobjc class var appLightGray: UIColor {
        return UIColor(hexString: "BBBBBB")
    }
    
    @nonobjc class var appBlack: UIColor {
        return UIColor(hexString: "000000")
    }
    
    @nonobjc class var appLineGray: UIColor {
        return UIColor(hexString: "6B6B6B")
    }
}

//Font of the App
extension UIFont {
    struct AppFont {
        static let Regular = "FuturaPT-Book"
        static let Bold = "FuturaPT-Bold"
        static let Light = "FuturaPT-Light"
        static let Medium = "FuturaPT-Medium"
    }

    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: AppFont.Bold, size: size) ??  UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: AppFont.Regular, size: size) ??  UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func light(size: CGFloat) -> UIFont {
        return UIFont(name: AppFont.Light, size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: AppFont.Medium, size: size) ??  UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func printFonts() {
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
}

//Button spacing
extension UIButton {
    @IBInspectable
    var letterSpacing: CGFloat {
        set {
            guard let text = self.titleLabel?.text, text.count > 0 else {
                return
            }
            
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: text.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
        get {
            return self.titleLabel?.attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat ?? 0
        }
    }
}

extension UILabel {
    @IBInspectable
    var letterSpacing: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
    static func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}

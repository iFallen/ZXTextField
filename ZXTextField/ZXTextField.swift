//
//  ZXTextField.swift
//  ZXTextField
//
//  Created by screson on 2017/9/14.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXTextFieldDelegate:class {
    func textFieldDidReachTheMaxLength(_ textField: UITextField)
}

extension ZXTextFieldDelegate {
    func textFieldDidReachTheMaxLength(_ textField: UITextField){}
}


enum ZXTextFieldType:UInt {
    case none = 0
    case number = 1
    case alphabet
}

class ZXTextField: UITextField {
    
    weak var zxDelegate:ZXTextFieldDelegate?
    
    @IBInspectable var maxLength:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
    }
    
    fileprivate func initialUI() {
        self.contentVerticalAlignment = .center
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        
        self.loadNotification()
    }
    
    fileprivate func loadNotification() {
        //NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing(_:)), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing(_:)), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil)
    }
    
    fileprivate func removeNotification() {
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil)
    }
    fileprivate var lastText:String?
    @objc fileprivate func textDidChange(_ notification:Notification) {
        if maxLength > 0,let textf = notification.object as? UITextField,textf == self {
            if let text = textf.text {
                if let selectedRange = textf.markedTextRange,textf.position(from: selectedRange.start, offset: 0) != nil {//存在高亮不处理
                    return
                }
                if let lastText = lastText {
                    
                }
                if text.characters.count == maxLength {
                    zxDelegate?.textFieldDidReachTheMaxLength(self)
                } else if text.characters.count > maxLength {
                    textf.text = text.substring(to: text.index(text.startIndex, offsetBy: maxLength))
                }
                lastText = text
            }
        }
    }
    
    deinit {
        self.removeNotification()
    }

}

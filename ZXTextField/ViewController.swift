//
//  ViewController.swift
//  ZXTextField
//
//  Created by screson on 2017/9/13.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField1: ZXTextField!
    
    @IBOutlet weak var textField2: ZXTextField!
    
    @IBOutlet weak var textField3: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField1.zxDelegate = self
        self.textField2.zxDelegate = self
        self.textField3.delegate = self
    }
    
}

extension ViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("range location:\(range.location) length:\(range.length)")
        print(string)
        return true
    }
}

extension ViewController:ZXTextFieldDelegate {
    func textFieldDidReachTheMaxLength(_ textField: UITextField) {
        print("Input done:\(textField.text!)")
    }
}


//
//  ViewController.swift
//  HSBKeyboardNotification
//
//  Created by Red on 09/21/2018.
//  Copyright (c) 2018 Red. All rights reserved.
//

import UIKit
import HSBKeyboardNotification

class ViewController: UIViewController {

	@IBOutlet var textField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		HSBKeyboardNotification.shared.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func tapGeustureAction(_ sender: Any) {
		view.endEditing(true)
	}
}

extension ViewController: HSBKeyboardNotificationDelegate {
	
	func hsbKeyboardNotification(show keyboardSize: CGSize) {
		textField.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
	}
	
	func hsbKeyboardNotification(hide keyboardSize: CGSize) {
		textField.transform = CGAffineTransform.identity
	}
	
	func hsbKeyboardNotification(change keyboardSize: CGSize) {
		textField.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
	}
	
	
}

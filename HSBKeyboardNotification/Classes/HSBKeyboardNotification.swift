//
//  HSBKeyboardNotification.swift
//  HSBKeyboardNotification
//
//  Created by 홍상보 on 2018. 9. 21..
//

import UIKit

public protocol HSBKeyboardNotificationDelegate {
	func hsbKeyboardNotification(show keyboardSize: CGSize)
	func hsbKeyboardNotification(hide keyboardSize: CGSize)
	func hsbKeyboardNotification(change keyboardSize: CGSize)
}

public class HSBKeyboardNotification: NSObject {
	static public let shared = HSBKeyboardNotification()
	open var delegate: HSBKeyboardNotificationDelegate?
	open var isKeyboardHidden = true
	
	override init() {
		super.init()
		registKeyboardNotification()
	}
	
	deinit {
		removeKeyboardNotification()
	}
	
	//MARK: Private
	
	fileprivate func registKeyboardNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(willChangeKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
	}
	
	fileprivate func removeKeyboardNotification() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
	}
	
	@objc private func willShowKeyboard(notification: Notification) {
		guard isKeyboardHidden else {
			return
		}
		isKeyboardHidden = false
		keyboardSize(notification: notification, animations: { (keyboardSize) in
			self.delegate?.hsbKeyboardNotification(show: keyboardSize)
		})
	}
	
	@objc private func willHideKeyboard(notification: Notification) {
		guard !isKeyboardHidden else {
			return
		}
		isKeyboardHidden = true
		keyboardSize(notification: notification, animations: { (keyboardSize) in
			self.delegate?.hsbKeyboardNotification(hide: keyboardSize)
		})
	}
	
	@objc private func willChangeKeyboard(notification: Notification)  {
		guard !isKeyboardHidden, let (keyboardSize, _, _) = self.keyboardSize(notification: notification) else {
			return
		}
		self.delegate?.hsbKeyboardNotification(change: keyboardSize)
	}
	
	private func keyboardSize(notification: Notification) -> (CGSize, TimeInterval, UIView.AnimationOptions)? {
		guard let userInfo = notification.userInfo else {
			return nil
		}
		
		/*
		* Get Keyboard Size
		*/
		let keyboardEndValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
		let keyboardSize = keyboardEndValue.cgRectValue.size
		
		/*
		* Get Keyboard Animation Duration
		*/
		let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
		let animationDuration: TimeInterval = durationValue.doubleValue
		
		/*
		* Get Keyboard Animation
		*/
		let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
		let animationCurve: UIView.AnimationCurve = UIView.AnimationCurve(rawValue: curveValue.intValue<<16)!
		let options = UIView.AnimationOptions(rawValue: UIView.AnimationOptions.RawValue(animationCurve.rawValue))
		
		return (keyboardSize, animationDuration, options)
	}
	
	private func keyboardSize(notification: Notification, animations: @escaping (CGSize) -> ()) {
		guard let (keyboardSize, animationDuration, options) = self.keyboardSize(notification: notification) else {
			return
		}
		
		UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: {
			animations(keyboardSize)
		})
	}
}

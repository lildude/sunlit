//
//  LoginViewController.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/3/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import UIKit
import Snippets

class LoginViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet var emailField : UITextField!
	@IBOutlet var spinner : UIActivityIndicatorView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.emailField.becomeFirstResponder()
    }
    

	func attemptLogin(_ emailAddress : String?) {
		
		if let input = emailAddress {

			let email = input.uuTrimWhitespace()
			
			if !email.uuIsValidEmail() {
				Dialog(self).information("Please enter a valid email address.")
				return
			}
			
			self.lockUserInterface()

			Snippets.shared.requestUserLoginEmail(email: email, appName: "Sunlit", redirect: "https://sunlit.io/microblog/redirect/")
			{ (error) in
				
				self.unlockUserInterface()

				if let err = error {
					Dialog(self).information(err.localizedDescription)
				}
				else {
					Dialog(self).information("Check your email on this device and tap the \"Open with Sunlit\" button.", completion: {
						self.dismiss(animated: true, completion: nil)
					})
				}
			}
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.attemptLogin(textField.text)
		return false
	}
	
	func lockUserInterface() {
		DispatchQueue.main.async {
			self.emailField.resignFirstResponder()
			self.emailField.isEnabled = false
			self.spinner.isHidden = false
		}
	}

	func unlockUserInterface() {
		DispatchQueue.main.async {
			self.emailField.isEnabled = true
			self.spinner.isHidden = true
		}
	}

}

//
//  Settings.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/3/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import Foundation
import Snippets
import UUSwift

class Settings {
	
	static func getInsecureString(forKey : String) -> String {
		let value = UserDefaults.standard.string(forKey: forKey) ?? ""
		return value
	}
	
	static func setInsecureString(_ value : String, forKey : String) {
		UserDefaults.standard.set(value, forKey: forKey)
	}
	
	static func deleteInsecureString(forKey : String) {
		UserDefaults.standard.removeObject(forKey: forKey)
	}
	
	static func getInsecureDictionary(forKey : String) -> [String : Any]? {
		let dictionary = UserDefaults.standard.object(forKey: forKey) as? [String : Any]
		return dictionary
	}
	
	static func setInsecureDictionary(_ dictionary : [String : Any], forKey : String) {
		UserDefaults.standard.set(dictionary, forKey: forKey)
	}
	
	static func setSecureString(_ value : String, forKey : String) {
		UUKeychain.saveString(key: forKey, acceessLevel: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, string: value)
	}
	
	static func getSecureString(forKey : String) -> String? {
		return UUKeychain.getString(key: forKey)
	}
	
	static func deleteSecureString(forKey : String) {
		UUKeychain.remove(key: forKey)
	}
	
	/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	MARK: -
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

	
	static func logout() {
		Settings.deleteSnippetsToken()
		SnippetsUser.deleteCurrentUser()
        Snippets.Configuration.timeline = Snippets.Configuration.microblogConfiguration(token: "")
        Snippets.Configuration.publishing = Snippets.Configuration.timeline

        BlogSettings.deleteTimelineInfo()
        BlogSettings.deletePublishingInfo()
	}
	
	static func saveSnippetsToken(_ token : String) {
		//UUKeychain.saveString(key: "SunlitToken", acceessLevel: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, string: token)
		UserDefaults.standard.setValue(token, forKey: "SunlitToken")
	}

	static func snippetsToken() -> String? {
		//return UUKeychain.getString(key: "SunlitToken")
		return UserDefaults.standard.string(forKey: "SunlitToken")
	}

	static func deleteSnippetsToken() {
		UserDefaults.standard.removeObject(forKey: "SunlitToken")
	}

}


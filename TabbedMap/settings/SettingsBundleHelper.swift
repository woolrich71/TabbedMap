//
//  SettingsBundleHelper.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-14.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import Foundation
class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let Reset = "RESET_APP_KEY"
        static let lat = "lat"
        static let lng = "lng"
        static let url = "url"
    }
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.Reset) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.Reset)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            // reset userDefaults..
            // CoreDataDataModel().deleteAllData()
            // delete all other user data here..
        }
    }
    
    class func setVersionAndBuildNumber() {
        let lat: Float = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! Float
        UserDefaults.standard.set(lat, forKey: "lat")
        let lng: Float = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! Float
        UserDefaults.standard.set(lng, forKey: "lng")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}

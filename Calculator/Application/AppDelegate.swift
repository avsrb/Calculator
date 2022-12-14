//
//  AppDelegate.swift
//  Calculator
//
//  Created by Artem Serebriakov on 01.08.2022.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CalculatorAssembly.createModule()
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark
        
        return true
    }

}

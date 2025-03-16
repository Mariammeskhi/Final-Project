//
//  SceneDelegate.swift
//  Final Project
//
//  Created by mariam meskhi on 12.02.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

       // Navigate based on registration status
       private func navigateBasedOnRegistrationStatus() {
           let isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
           let storyboardName = isRegistered ? "LogIn" : "Registration"
           let viewControllerIdentifier = isRegistered ? "LogInViewController" : "RegistrationViewController"
           
           let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
           let initialVC = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
           
           // Cast to the correct type (UIViewController) and check for nil if necessary
           if let initialVC = initialVC as? UIViewController {
               window?.rootViewController = UINavigationController(rootViewController: initialVC)
           } else {
               print("Error: ViewController \(viewControllerIdentifier) not found")
           }
       }

       func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
           guard let windowScene = (scene as? UIWindowScene) else { return }
           
           window = UIWindow(windowScene: windowScene)
           navigateBasedOnRegistrationStatus()
           window?.makeKeyAndVisible()
       }

       func sceneDidDisconnect(_ scene: UIScene) {
           // Called when the scene is released by the system
       }

       func sceneDidBecomeActive(_ scene: UIScene) {
           // Called when the scene moves from inactive to active state
       }

       func sceneWillResignActive(_ scene: UIScene) {
           // Called when the scene moves from active to inactive state
       }

       func sceneWillEnterForeground(_ scene: UIScene) {
           // Called as the scene transitions from background to foreground
       }

       func sceneDidEnterBackground(_ scene: UIScene) {
           // Called as the scene transitions from foreground to background
       }
}


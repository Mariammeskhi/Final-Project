//
//  AppDelegate.swift
//  Final Project
//
//  Created by mariam meskhi on 12.02.25.
//
import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "User")
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    // Handle error gracefully
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()

        func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    print("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

        // This method is used in the SceneDelegate for iOS 13+ for window setup
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            return true
        }

        func applicationWillTerminate(_ application: UIApplication) {
            saveContext()
        }
    
}

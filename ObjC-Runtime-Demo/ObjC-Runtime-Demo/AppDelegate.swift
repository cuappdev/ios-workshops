//
//  AppDelegate.swift
//  ObjC-Runtime-Demo
//
//  Created by Drew Dunne on 11/4/18.
//  Copyright © 2018 Drew Dunne. All rights reserved.
//

import UIKit
import ObjectiveC

extension UITableView {
    @objc dynamic func myReload() {
        print("Haha! No reloading for you!")
    }
}

class MyClass: NSObject {
    @objc dynamic var item1: String!
    var item2: String!
    @objc dynamic var item3: NSNumber!
    var item4: Bool!

    @objc dynamic func doThis(a: Int) -> Int {
        return a - 1
    }
}

extension MyClass {
    @objc dynamic func doThisToo(a: Int) -> Int {
        print("Haha I know the value of a is \(a)")
        return doThisToo(a: a / 2)
    }
}

private var observerContext = 0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let myClass = MyClass()
        myClass.item1 = "Runtime"
        myClass.item3 = 40

        let theClass: AnyClass = object_getClass(myClass)!
        print(String(cString: class_getName(theClass)))

        print("Do this thing gives \(myClass.doThis(a: 100))")

        // Method Swizzling
        let origSel = #selector(myClass.doThis(a:))
        let newSel = #selector(myClass.doThisToo(a:))

        let original = class_getInstanceMethod(theClass, origSel)!
        let swapped = class_getInstanceMethod(theClass, newSel)!
        method_exchangeImplementations(original, swapped)

        print("The value I get back is \(myClass.doThis(a: 100))")

        swapTableView()

        // Properties and KVO
        var count: UInt32 = 0

        let properties = class_copyPropertyList(theClass, &count)
        var propNames: [String] = []
        print("Number of properties is \(count)")
        guard let props = properties else { return false }
        for i in 0..<count {
            let prop = props[Int(i)];
            let cname = property_getName(prop)
            let name = String(cString: cname)
            print("property \(i) is \(name)")
            propNames.append(name)
            // Add observer

            myClass.addObserver(self, forKeyPath: name, options: [.old, .new], context: &observerContext)
        }

        myClass.setValue("is awesome", forKey: propNames[0])

        myClass.setValue(200, forKey: propNames[1])

        free(properties)

        return true
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        let obj: AnyClass = object_getClass(object)!
        let className = String(cString: class_getName(obj))
        let old = change![NSKeyValueChangeKey.oldKey]!
        let new = change![NSKeyValueChangeKey.newKey]!
        print("\(className) had the property \(keyPath!) change from \(old) to \(new)")
    }

    func swapTableView() {
        let tb = UITableView()
        let theClass: AnyClass = object_getClass(tb)!
        let origSel = #selector(tb.reloadData)
        let newSel = #selector(tb.myReload)

        let original = class_getInstanceMethod(theClass, origSel)!
        let swapped = class_getInstanceMethod(theClass, newSel)!
        method_exchangeImplementations(original, swapped)

        tb.reloadData()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


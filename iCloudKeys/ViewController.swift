//
//  ViewController.swift
//  iCloudKeys
//
//  Created by Douglas Alexander on 4/18/18.
//  Copyright © 2018 Douglas Alexander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // create an ubiquitous key store
    var keyStore: NSUbiquitousKeyValueStore?
    
    @IBOutlet weak var textField: UITextField!
    
    // user wishes to save
    @IBAction func saveKey(_ sender: Any) {
        
        keyStore?.set(textField.text, forKey: "MyString")
        keyStore?.synchronize()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCloud()
    }

    func initCloud() {

        // create an ubiquitous key store
        keyStore = NSUbiquitousKeyValueStore()
        
        // determine if the keyStore has "My String"
        let storedString = keyStore?.string(forKey: "MyString")
        if let stringValue = storedString {
            textField.text = stringValue
        }
        
        // set up an observer
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.ubiquitousKeyValueStoreDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: keyStore)
    }
    
    // when the keyStore detects a change alert the user and update the text field
    @objc func ubiquitousKeyValueStoreDidChange(notification: NSNotification) {
        let alert = UIAlertController(title: "Change detected", message: "iCloud key-value-store change detected", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        textField.text = keyStore?.string(forKey: "MyString")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  LocalStorageManager.swift
//  AppExtensionSample
//
//  Created by Paweł Kuźniak on 29.03.2016.
//  Copyright © 2016 Paweł Kuźniak. All rights reserved.
//

import UIKit

public class LocalStorageManager{
    
    static let sharedInstance = LocalStorageManager()
    
    private let sharedContainer: NSUserDefaults = NSUserDefaults(suiteName: "group.co.zaven.AppExtensionSample")!
    
    private var storedData: [String]! = []
    
    private init(){
        self.readData()
    }
    
    func readData() -> [String]{
        if let data = self.sharedContainer.objectForKey("FileList") as? [String] {
            self.storedData = data
        }
        return self.storedData
    }
    
    func insertData(fileName: String){
        self.storedData.append(fileName)
        self.sharedContainer.setObject(self.storedData, forKey: "FileList")
    }
    
    func removeData(index: Int){
        self.storedData.removeAtIndex(index)
        self.sharedContainer.setObject(self.storedData, forKey: "FileList")
    }
    
    func clearData(){
        self.storedData.removeAll()
        self.sharedContainer.removeObjectForKey("FileList")
    }
}

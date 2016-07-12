//
//  ActionViewController.swift
//  AppExtenstionSampleAction
//
//  Created by Paweł Kuźniak on 29.03.2016.
//  Copyright © 2016 Paweł Kuźniak. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    @IBOutlet weak var fileNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.processPickedFile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func processPickedFile(){
        if(self.extensionContext!.inputItems.count > 0){
            let inputItem = self.extensionContext?.inputItems.first as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments!{
                let itemProvider = provider as! NSItemProvider
                if(itemProvider.hasItemConformingToTypeIdentifier(kUTTypePDF as String) || itemProvider.hasItemConformingToTypeIdentifier(kUTTypePlainText as String) || itemProvider.hasItemConformingToTypeIdentifier("com.microsoft.word.doc")){
                    itemProvider.loadItemForTypeIdentifier(kUTTypePDF as String, options: nil, completionHandler: { (file, error) in
                        if(error == nil){
                            self.setPickedFile(file!)
                        }
                    })
                    break
                }
            }
        }
    }
    
    func setPickedFile(file: NSSecureCoding){
        if let fileURL = file as? NSURL{
            let fileName = fileURL.lastPathComponent
            self.fileNameLabel.text = fileName
        }
    }
    
    @IBAction func saveButtonTouchUpInside(sender: AnyObject) {
        LocalStorageManager.sharedInstance.insertData(self.fileNameLabel.text!)
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }
    
    @IBAction func done() {
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }

}
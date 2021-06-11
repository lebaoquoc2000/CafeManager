//
//  Util.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/4/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    class func getPath(fileName: String) -> String {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        print(fileURL)
        return fileURL.path
    }
    
    class func copyFile(fileName: NSString) {
        let dbPath: String = getPath(fileName: fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            //print(fromPath)
            var error : NSError?
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            let alert: UIAlertView = UIAlertView()
            if (error != nil) {
                alert.title = "Error Occured"
                alert.message = error?.localizedDescription
            } else {
                alert.title = "Successfully Copy"
                alert.message = "Your database copy successfully"
            }
            alert.delegate = nil
            alert.addButton(withTitle: "Ok")
            //alert.show()
        }
        else
        {
            
        }
    }
    
    class func alert1Action(title: String, message: String, view: UIViewController?, isDismiss: Bool, isPopViewController: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if isDismiss {
                DispatchQueue.main.async {
                    view?.dismiss(animated: true, completion: nil)
                }
            }
            if isPopViewController {
                DispatchQueue.main.async {
                    view?.navigationController?.popViewController(animated: true)
                }
            }
        }))
        view?.present(alert, animated: true, completion: nil)
    }
    
}


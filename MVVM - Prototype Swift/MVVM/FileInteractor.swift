//
//  Implementation.swift
//  MVVM
//
//  Created by Thongpak on 7/25/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
class FileInteractor:Interactor{
    func getWordsWithComplete(completion: OnDataComplete, andError error: OnDataError) {
     //   var errorReturn:NSError?
        let jsonPath:String = NSBundle.mainBundle().pathForResource("words", ofType: "json")!
        if jsonPath == "" {
            error(errorMessage: "Cannot find word collections file.")
            return
        }
        let jsonData:NSData = NSData(contentsOfFile: jsonPath)!
        if jsonData == "" {
            error(errorMessage: "Cannot load word collections file.")
            return
        }
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(rawValue: 0))
            guard let jsonDict:NSDictionary = json as? NSDictionary else {
                error(errorMessage: "Word collections file might be corrupted.")
                return
            }
            completion(response: jsonDict)
        }catch{
            print(error)
        }
    }
    func getMeaningFromWord(word: String, withComplete completion: OnDataComplete, andError error: OnDataError) {
        
    }
}
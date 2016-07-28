//
//  Interactor.swift
//  MVVM
//
//  Created by Thongpak on 7/25/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
typealias OnDataComplete = (response:NSDictionary) -> Void
typealias OnDataError = (errorMessage:String) -> Void

protocol Interactor {
    
    func getWordsWithComplete(completion: OnDataComplete, andError error: OnDataError)
    
    func getMeaningFromWord(word: String, withComplete completion: OnDataComplete, andError error: OnDataError)
}

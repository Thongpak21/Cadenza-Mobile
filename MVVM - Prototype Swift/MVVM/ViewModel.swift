//
//  ViewModel.swift
//  MVVM
//
//  Created by Thongpak on 7/26/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
class ViewModel:NSObject {
    var interactor:Interactor?
    var delegate:ViewModelDelegate?
    var words = [WordModel]()
    convenience init(delegate: ViewModelDelegate) {
        self.init()
        
//          self.context = Context.sharedInstance()
        self.delegate = delegate
        self.interactor = FileInteractor()
     //   self.words = [WordModel]()
    }
    func usingInteractor(interactor: Interactor) {
        self.interactor = interactor
    }
    
    func refreshData() {
        self.interactor!.getWordsWithComplete({(response:NSDictionary) -> Void in
            var words = [WordModel]()
            for word in response["words"] as! [[String:AnyObject]] {
                words.append(WordModel(word))
            }
            
            self.words = words
            self.delegate!.onDataDidLoad()
            }, andError: {(errorMessage: String) -> Void in
                self.delegate!.onDataDidLoadErrorWithMessage(errorMessage)
        })
    }
    func numberOfWords() -> Int {
        return self.words.count
    }
    func wordForIndex(index: Int) -> WordModel {
        return self.words[index]
    }
}
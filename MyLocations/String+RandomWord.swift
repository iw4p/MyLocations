//
//  String+RandomWord.swift
//  MyLocations
//
//  Created by Nima Akbarzade on 11/20/1397 AP.
//  Copyright © 1397 AP Nima Akbarzade. All rights reserved.
//

import Foundation

extension String {
    func addRandomWord() -> String {
        let words = ["rabbit","banana","boat"]
        let value = Int.random(in: 0 ..< words.count)
        let word = words[value]
        return self + word
    }
}

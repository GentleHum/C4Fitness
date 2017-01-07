//
//  String+Extensions.swift
//  
//
//  Created by Mike Vork on 12/14/16.
//
//

import Foundation

extension String {
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: String.CompareOptions.caseInsensitive) != nil
    }
}


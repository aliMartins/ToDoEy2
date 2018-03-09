//
//  Data.swift
//  ToDoEy2
//
//  Created by Alieksiei martins on 08/03/2018.
//  Copyright © 2018 Alieksiei martins. All rights reserved.
//

import Foundation

class Item: Codable {
    // mark our class as conforming toprotcols encodables
    
    var title : String = ""
    var done : Bool = false
    
    // cant have a custom class
}

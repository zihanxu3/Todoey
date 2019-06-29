//
//  Item.swift
//  Todoey
//
//  Created by Hunter Xu on 6/26/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import Foundation

/* CONFROMING TO PROTOCOL SO THAT THE STRUCT ITSELF CAN BE PUT INTO and RETRIEVE FROM A PLIST PROPERLY */
struct Item: Encodable, Decodable {
    var itemValue: String = "";
    var itemStatus: Bool  = false;
}

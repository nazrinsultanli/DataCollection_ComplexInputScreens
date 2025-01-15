//
//  Registration.swift
//  HotelCodable
//
//  Created by Nazrin Sultanlı on 14.01.25.
//

import Foundation
struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var wifi: Bool
    var roomType: RoomType
    
}


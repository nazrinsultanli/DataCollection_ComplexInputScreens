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
struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    //Equatable Protocol Implementation for RoomType
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}

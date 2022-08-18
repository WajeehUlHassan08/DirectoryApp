//
//  Room.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import Foundation

struct Room: Codable {
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String
}


//
//  AssignmentModel.swift
//  SwiftDataTest
//
//  Created by Kaique Diniz on 11/06/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class AssignmentModel {    
    var name: String
    var subject: String
    var dateExpiration: Date
    var score: Int
    
    init(name: String, subject: String, dateExpiration: Date, score: Int) {
        self.name = name
        self.subject = subject
        self.dateExpiration = dateExpiration
        self.score = score
    }
}

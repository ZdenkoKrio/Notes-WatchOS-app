//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Zdenko Čepan on 31/07/2021.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    let text: String
}

//
//  LearningCard.swift
//  BusyCards
//
//  Created by Athoub Alabdulrahim on 11/06/1447 AH.
//
import SwiftUI

struct LearningCard: Identifiable {
    let id = UUID()
    let imageName: String
    let destination: AnyView
}

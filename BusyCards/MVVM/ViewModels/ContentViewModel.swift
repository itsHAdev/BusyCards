//
//  Untitled.swift
//  BusyCards
//
//  Created by Athoub Alabdulrahim on 11/06/1447 AH.
//
import SwiftUI
import Combine


class ContentViewModel: ObservableObject {

    @Published var selectedCard: Int = 0

    let cards: [LearningCard] = [
        LearningCard(imageName: "HearingCard", destination: AnyView(AuditoryView())),
        LearningCard(imageName: "SeeingCard", destination: AnyView(SeeingPage())),
        LearningCard(imageName: "MovingCard", destination: AnyView(MovingPage()))
    ]
    
    let children = [
        Child(name: "اسم الطفل", type: "سمعي", imageName: "Auditory2"),
        Child(name: "اسم الطفل", type: "بصري", imageName: "VisualC"),
        Child(name: "اسم الطفل", type: "حركي", imageName: "KinestheticC"),
        Child(name: "اسم الطفل", type: "نوع التعلم", imageName: nil),
        Child(name: "اسم الطفل", type: "نوع التعلم", imageName: nil)
    ]
}


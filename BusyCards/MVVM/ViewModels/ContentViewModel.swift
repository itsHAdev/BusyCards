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
        LearningCard(imageName: "HearingCard", destination: AnyView(HearingPage())),
        LearningCard(imageName: "SeeingCard", destination: AnyView(SeeingPage())),
        LearningCard(imageName: "MovingCard", destination: AnyView(MovingPage()))
    ]
}


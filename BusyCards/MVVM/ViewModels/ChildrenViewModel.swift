//
//  ChildrenViewModel.swift
//  BusyCards
//
//  Created by Fai Altayeb on 08/12/2025.
//
import SwiftUI
import Combine

class ChildrenViewModel: ObservableObject {
    @Published var children: [Child] = []
    
    func addChild(name: String, type: String) {
        let imageName = imageForType(type)
        let newChild = Child(name: name, type: type, imageName: imageName)
        children.append(newChild)
    }
    
    private func imageForType(_ type: String) -> String {
        switch type {
        case "سمعي": return "AuditoryC"
        case "بصري": return "VisualC"
        case "حركي": return "KeinestheticC"
        case "قرائي/كتابي": return "VisualC"
        default: return "defaultKid"
        }
    }
}


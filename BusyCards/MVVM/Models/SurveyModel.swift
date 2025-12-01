//
//  SurveyModel.swift
//  BusyCards
//
//  Created by Fai Altayeb on 01/12/2025.
//

import SwiftUI

struct SurveyQuestion: Identifiable {
   let id = UUID()
   let questions: String
   let options: [String]
}

struct UserAnswer {
   let questionID: UUID
   var selectedOption: String?
}

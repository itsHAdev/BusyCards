//
//  LineModel.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 11/12/2025.
//

import SwiftUI

// يمثل كل خط نرسمه بنقاطه ولونه وسمكه.
struct LineModel {
    var points: [CGPoint] = []
    var color: Color = .black
    var thickness: CGFloat = 10.0 // تم تثبيت السمك
    var isEraser: Bool = false
}

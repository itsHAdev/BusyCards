//
//  StudentListView.swift
//  BusyCards
//
//  Created by Fai Altayeb on 08/12/2025.
//

import SwiftUI

struct StudentsListView: View {
    @EnvironmentObject var childrenVM: ChildrenViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("قائمة الاسماء")
                    .font(.title)
                    .padding(.top, 20)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(childrenVM.children) { child in
                            ChildActionRow(child: child) // Use the action row with "ابدأ"
                        }
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("White"))
            .ignoresSafeArea()
        }
    }
}

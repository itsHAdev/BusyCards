//
//  StudentListView.swift
//  BusyCards
//
//  Created by Fai Altayeb on 08/12/2025.
//

import SwiftUI

struct StudentsListView: View {
    @EnvironmentObject var childrenVM: ChildrenViewModel
    let onSelect: (String) -> Void
    
    var body: some View {
        NavigationView {
                VStack {
                    Text("قائمة الاسماء")
                        .font(.title)
                        .padding(.top, 20)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(childrenVM.children) { child in
                                ChildActionRow(
                                    child: child,
                                    onStart: { type in
                                        onSelect(type)   // 👈 نمررها لـ HomePage
                                    }
                                )
                            }
                            
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("White"))
                .ignoresSafeArea()
        }//nav
    }
}

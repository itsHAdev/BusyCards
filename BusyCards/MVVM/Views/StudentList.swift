//
//  Student list.swift
//  BusyCards
//
//  Created by Noura bin dukheen on 11/06/1447 AH.
//
import SwiftUI

struct Child: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let imageName: String?
}

struct StudentList: View {
    @State private var showSheet = true // sheet يظهر تلقائيًا عند التشغيل
    
    let children = [
        Child(name: "اسم الطفل", type: "سمعي", imageName: "Auditory2"),
        Child(name: "اسم الطفل", type: "بصري", imageName: "VisualC"),
        Child(name: "اسم الطفل", type: "حركي", imageName: "KinestheticC"),
        Child(name: "اسم الطفل", type: "نوع التعلم", imageName: nil),
        Child(name: "اسم الطفل", type: "نوع التعلم", imageName: nil)
    ]
    
    var body: some View {
        ZStack {
            // الخلفية بيج
            Color(red: 243/255, green: 228/255, blue: 224/255)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showSheet) {
            NamesSheetView(children: children)
                .presentationDetents([.large])
                .presentationCornerRadius(40)
                .interactiveDismissDisabled(false)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

struct NamesSheetView: View {
    let children: [Child]
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 44, height: 6)
                .padding(.top, 12)
                .padding(.bottom, 16)
            
            Text("قائمة الأسماء")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.bottom, 24)
            
            VStack(spacing: 24) {
                ForEach(children) { child in
                    ChildRow(child: child)
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 40)
            Spacer()
        }
        .background(
            Color(red: 37/255, green: 65/255, blue: 154/255)
                .ignoresSafeArea()
        )
    }
}

struct ChildRow: View {
    let child: Child
    
    var body: some View {
        HStack {
            if let imageName = child.imageName, !imageName.isEmpty {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 2))
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 54, height: 54)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(child.name)
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                Text(child.type)
                    .font(.callout)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 18)
        .background(
            RoundedRectangle(cornerRadius: 23)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.15), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    StudentList()
}

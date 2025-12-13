//
//  ChildRowView.swift
//  BusyCards
//
//  Created by Fai Altayeb on 08/12/2025.
//

import SwiftUI

struct ChildActionRow: View {
    let child: Child
    let onStart: (String) -> Void   // 👈 Callback

    var body: some View {
        HStack {
            // زر ابدأ
            Button("ابدأ") {
                onStart(child.type)
            }
            .font(.custom("SF Arabic Rounded", size: 18))
            .foregroundColor(.white)
            .frame(width: 60, height: 40)
            .background(Color.darkBlue)
            .cornerRadius(12)

            Spacer()

            // الاسم + النوع
            VStack(alignment: .trailing) {
                Text(child.name)
                    .font(.headline)

                Text(child.type)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            // 👈 الصورة حسب النوع
            if let img = child.imageName {
                Image(img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

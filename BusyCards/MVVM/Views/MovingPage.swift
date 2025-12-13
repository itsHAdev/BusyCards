//
//  MovingPage.swift
//  BusyCards
//
//  Created by Athoub Alabdulrahim on 11/06/1447 AH.
//
import SwiftUI

struct MovingPage: View {
    @State private var counter: Int = 3

    // ألوان قريبة من التصميم
    private let bgColor = Color(red: 0.96, green: 0.90, blue: 0.88)   // خلفية وردي فاتح
    private let primaryBlue = Color(red: 0.16, green: 0.30, blue: 0.66)
    private let circleShadow = Color.black.opacity(0.2)

    // محوّل أرقام عربية
    private var arabicNumberFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "ar")
        f.numberStyle = .decimal
        return f
    }

    private func arabicDigits(from value: Int) -> String {
        let western = Array("0123456789")
        let arabic  = Array("٠١٢٣٤٥٦٧٨٩")
        let s = String(value)
        return String(s.map { ch in
            if let idx = western.firstIndex(of: ch) {
                return arabic[western.distance(from: western.startIndex, to: idx)]
            }
            return ch
        })
    }

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()

            VStack(spacing: 24) {

                // الصورة من الأصول باسم s1 — مكبرة
                Image("s1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .padding(.top, 24) // إنزال الصورة أكثر للأسفل

                // العنوان
                Text("الاجابه ٧ اقفز ٧ مرات")
                    .font(.system(.title3, design: .rounded)).bold()
                    .foregroundStyle(.primary)

                // دائرة العدّاد مع ظلال خفيفة
                ZStack {
                    // ظل سفلي
                    Circle()
                        .fill(circleShadow)
                        .frame(width: 170, height: 150)
                        .offset(x: 6, y: 6)

                    // حلقة بيضاء محيطة
                    Circle()
                        .fill(.white)
                        .frame(width: 170, height: 170)

                    // الدائرة الأساسية
                    Circle()
                        .fill(primaryBlue)
                        .frame(width: 150, height: 150)

                    // قيمة العدّاد بأرقام عربية
                    Text(arabicDigits(from: counter))
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .padding(.top, 8)

                // أزرار + و −
                HStack(spacing: 24) {
                    Button {
                        counter -= 1
                    } label: {
                        Text("−")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .frame(width: 56, height: 36)
                            .foregroundStyle(.white)
                            .background(primaryBlue, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }

                    Button {
                        counter += 1
                    } label: {
                        Text("+")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .frame(width: 56, height: 36)
                            .foregroundStyle(.white)
                            .background(primaryBlue, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    }
                }
                .padding(.top, 4)

                Spacer()

                // زر انتهيت — حجم ثابت 260x56
                Button {
                    // ضع الإجراء المطلوب عند الانتهاء
                } label: {
                    Text("انتهيت")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(width: 260, height: 56) // 260 × 56
                        .background(primaryBlue, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 3)
                }
                .padding(.bottom, 32)
            }
            // Padding عام للصفحة (يمين/يسار وأعلى/أسفل خفيف)
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 12)
        }
    }
}

#Preview {
    MovingPage()
}

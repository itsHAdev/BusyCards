//
//  MovingPage.swift
//  BusyCards
//
//  Created by Athoub Alabdulrahim on 11/06/1447 AH.
//
import SwiftUI

// MARK: - 1. نموذج الخط (Line Model)

// يمثل كل خط نرسمه بنقاطه ولونه وسمكه.
struct Line {
    var points: [CGPoint] = []
    var color: Color = .black
    var thickness: CGFloat = 5.0
}

// MARK: - 2. الواجهة الرئيسية (ContentView)

struct MovingPage: View {
    
    // حالة التطبيق
    @State private var lines: [Line] = [] // قائمة الخطوط المرسومة
    @State private var selectedColor: Color = .blue // اللون الحالي للقلم
    @State private var isEraserSelected: Bool = false // هل الممحاة مختارة؟
    
    // الأداة الحالية (قلم أو ممحاة)
    var currentColor: Color {
        isEraserSelected ? .white : selectedColor // إذا كانت ممحاة، يكون اللون أبيض (لون الخلفية)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // ⭐️ قماش الرسم (الخلفية البيضاء) ⭐️
            Color.white
                .overlay(
                    // عرض الرسم باستخدام Canvas
                    Canvas { context, size in
                        for line in lines {
                            var path = Path()
                            path.addLines(line.points)
                            
                            context.stroke(path, with: .color(line.color),
                                           style: StrokeStyle(lineWidth: line.thickness, lineCap: .round, lineJoin: .round))
                        }
                    }
                    // إضافة إيماءة السحب (Drag Gesture) للرسم
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let newPoint = value.location
                                
                                // إذا كانت بداية السحب، نبدأ خطًا جديدًا
                                if value.translation.width + value.translation.height == 0 {
                                    let newLine = Line(points: [newPoint],
                                                       color: currentColor, // استخدام اللون الحالي (أو الأبيض للممحاة)
                                                       thickness: 10) // سمك ثابت 10
                                    lines.append(newLine)
                                } else {
                                    // إذا كان سحبًا مستمرًا، نضيف النقطة إلى الخط الأخير
                                    if var lastLine = lines.popLast() {
                                        lastLine.points.append(newPoint)
                                        lines.append(lastLine)
                                    }
                                }
                            }
                    )
                )
                .ignoresSafeArea(.all, edges: .top) // لملء الشاشة بالكامل تقريباً

            // 🛠️ شريط الأدوات المبسط 🛠️
            HStack(spacing: 30) {
                
                // 1. زر اختيار القلم
                Button {
                    isEraserSelected = false
                } label: {
                    Label("قلم", systemImage: "pencil.circle.fill")
                        .foregroundColor(isEraserSelected ? .gray : selectedColor)
                }
                
                // 2. زر اختيار الممحاة
                Button {
                    isEraserSelected = true
                } label: {
                    Label("ممحاة", systemImage: "eraser.fill")
                        .foregroundColor(isEraserSelected ? .red : .gray)
                }
                
                // 3. محدد اللون (يظهر فقط إذا كان القلم مختارًا)
                if !isEraserSelected {
                    ColorPicker("اللون", selection: $selectedColor)
                        .labelsHidden()
                        .scaleEffect(1.2) // تكبير بسيط ليصبح بارزًا
                }
                
                Spacer()
                
                // 4. زر مسح الكل
                Button("مسح الكل") {
                    lines.removeAll()
                }
                ZStack{
                    
                    //.foregroundColor(.red)
            }//z
            }
            .padding()
            .background(Color(.systemGray6)) // خلفية خفيفة لشريط الأدوات
        }
    }
}// MARK: - Preview Provider (للمعاينة في Xcode)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovingPage()
    }
}

//
//  SeeingReward.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 11/12/2025.
//

import SwiftUI

struct SeeingReward: View {
    
    @State private var lines: [Line] = [] // قائمة الخطوط المرسومة
    @State private var selectedColor: Color = .blue // اللون الحالي للقلم
    @State private var isEraserSelected: Bool = false // هل الممحاة سليكتد
    
    // فلم ولا مساحه
    var currentColor: Color {
        // نستخدم اللون الأبيض للممحاة لـ "مسح" الخطوط (مع الأخذ في الاعتبار أن خلفية Canvas شفافة وتظهر ما خلفها)
        isEraserSelected ? .white : selectedColor
    }
    var body: some View {
        NavigationStack {
            ZStack{
                Color.background
                    .ignoresSafeArea()
                
                VStack{
                    
                    Spacer().frame(height: 45)
                    
                    Text("أبحث عن الكعك ولون")
                        .font(.system(size: 28))
                        
                    Spacer().frame(height: 31)
                    
                        //MARK: - Canves
                    
                        ZStack{
                        
                        Image("Coloring")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 402, height: 584)
                            .border(Color.darkBlue,width: 12)
                        
                        Canvas { context, size in
                            for line in lines {
                                var path = Path()
                                path.addLines(line.points)
                                
                                context.stroke(path, with: .color(line.color),
                                               style: StrokeStyle(lineWidth: line.thickness, lineCap: .round, lineJoin: .round))
                            }
                        }
                        // تطبيق حجم Image على Canvas ليتطابقا
                        .frame(width: 402, height: 584)
                        
                        // 3. إيماءة السحب (Drag Gesture) للرسم
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let newPoint = value.location
                                    
                                    // بداية خط جديد
                                    if value.translation.width + value.translation.height == 0 {
                                        let newLine = Line(points: [newPoint], color: currentColor)
                                        lines.append(newLine)
                                    } else {
                                        // إضافة نقطة إلى الخط الأخير
                                        if var lastLine = lines.popLast() {
                                            lastLine.points.append(newPoint)
                                            lines.append(lastLine)
                                        }
                                    }
                                }
                        )
                    }//z
                    Spacer().frame(height: 0)
                    
                    //MARK: - ColorTools
                    
                    ZStack{
                        Color.white
                            .frame(width: 402,height: 95)
                            .opacity(0.8)
                        
                        HStack(spacing: 60){
                            
                            //ColorPicker
                            ColorPicker("اللون", selection: $selectedColor)
                                .labelsHidden()
                                .scaleEffect(1.3)
                                .opacity(isEraserSelected ? 0.3 : 1.0)
                                .disabled(isEraserSelected)
                            
                            // pen
                            Button {
                                isEraserSelected = false
                            } label: {
                                Image(systemName: "pencil.and.outline")
                                    .font(.system(size: 30))
                                    .foregroundStyle(isEraserSelected ? Color.gray : selectedColor)
                            }//b2
                            
                            // eraser
                            Button {
                                isEraserSelected = true
                            } label: {
                                Image(systemName: "eraser")
                                    .font(.system(size: 30))
                                    .foregroundStyle(isEraserSelected ? Color.red : Color.gray)
                            }//b3
                            
                            // removeAll
                            Button {
                                lines.removeAll()
                            } label: {
                                Image(systemName: "trash")
                                    .font(.system(size: 30))
                                    .foregroundStyle(Color.red)
                            }//b4
                        }//h
                    }
                }
            }//z
            
            // MARK: - Toolbar العلوي
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                      
                    } label: {
                        Text("أنتهيت")
                            .foregroundColor(.black)
                    }
                }
            }//toolbar
        }//navS
    }
}

#Preview {
    SeeingReward()
}

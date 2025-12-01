//
//  SurveyViewModel.swift
//  BusyCards
//
//  Created by Fai Altayeb on 01/12/2025.
//
import SwiftUI
import Combine

class SurveyViewModel: ObservableObject {
    @Published var questions: [SurveyQuestion] = [
        SurveyQuestion(
            questions: "عندما يتعلم شيئًا جديدًا، كيف يستوعبه بشكل أفضل؟",
            options: ["من خلال رؤية صور توضيحية أو مقاطع فيديو", "من خلال الاستماع إلى الشرح" , "من خلال قراءة التعليمات" , "من خلال التجربة العملية والممارسة"]
        ),
        SurveyQuestion(
            questions: "عندما يشرح معلومة أو قصة لكم، ماذا يفعل عادة؟",
            options: ["يستخدم عبارات مثل أنظر أو أرى ويصف تفاصيل بصرية", "يستخدم عبارات مثل إسمع أو قال ويهتم بنقل ما سمعه", "يروي القصة بتسلسل منطقي ويهتم بالتفاصيل النصية", "يستخدم حركات اليدين ويتحرك أثناء الشرح"]
        ),
        SurveyQuestion(
            questions: "في وقت الفراغ، ما الذي يقوم به؟",
            options: ["قراءة الكتب المصورة أو مشاهدة الرسوم المتحركة", "الاستماع إلى القصص", "القراءة أو كتابة القصص", "اللعب الحركي أو صنع الأشياء بيده"]
        ),
        SurveyQuestion(
            questions: "عندما يكون في غرفته، ما الذي تلاحظه عادة؟",
            options: ["يهتم بترتيب الغرفة بطريقة جمالية أو حسب الألوان", "يتحدث إلى نفسه أو يُنشد أثناء اللعب", "لديه مجموعة من الكتب ويهتم بترتيبها", "لا يستطيع البقاء ساكنًا ويستخدم كل مساحة الغرفة للعب"]
        ),
        SurveyQuestion(
            questions: "عندما يريد التعبير عن فكرة جديدة، ماذا يفعل غالبًا؟",
            options: ["يرسم أو يخطط لها", "يتحدث عنها كثيرًا", "يكتب عنها أو يقرأ عن مواضيع مشابهة", "يصنع نموذجًا أو يجرب تنفيذها عمليًا"]
        )
        
    ]

    @Published var currentIndex = 0
    @Published var selectedOptions: [UUID : String] = [:]

    var isLastQuestion: Bool {
        currentIndex == questions.count - 1
    }

    func choose(_ option: String) {
        let id = questions[currentIndex].id
        selectedOptions[id] = option
    }

    func nextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        }
    }
    func mapOptionToType(_ option: String) -> String {
            switch option {
            case "من خلال رؤية صور توضيحية أو مقاطع فيديو",
                 "يستخدم عبارات مثل أنظر أو أرى ويصف تفاصيل بصرية",
                 "قراءة الكتب المصورة أو مشاهدة الرسوم المتحركة",
                 "يهتم بترتيب الغرفة بطريقة جمالية أو حسب الألوان",
                 "يرسم أو يخطط لها":
                return "بصري"
                
            case "من خلال الاستماع إلى الشرح",
                 "يستخدم عبارات مثل إسمع أو قال ويهتم بنقل ما سمعه",
                 "الاستماع إلى القصص",
                 "يتحدث إلى نفسه أو يُنشد أثناء اللعب",
                 "يتحدث عنها كثيرًا":
                return "سمعي"
                
            case "من خلال قراءة التعليمات",
                 "يروي القصة بتسلسل منطقي ويهتم بالتفاصيل النصية",
                 "القراءة أو كتابة القصص",
                 "لديه مجموعة من الكتب ويهتم بترتيبها",
                 "يكتب عنها أو يقرأ عن مواضيع مشابهة":
                return "قرائي/كتابي"
                
            case "من خلال التجربة العملية والممارسة",
                 "يستخدم حركات اليدين ويتحرك أثناء الشرح",
                 "اللعب الحركي أو صنع الأشياء بيده",
                 "لا يستطيع البقاء ساكنًا ويستخدم كل مساحة الغرفة للعب",
                 "يصنع نموذجًا أو يجرب تنفيذها عمليًا":
                return "حركي"

            default:
                return "بصري"
            }
        }

        func calculateResult() -> String {
            var score = [
                "بصري": 0,
                "سمعي": 0,
                "قرائي/كتابي": 0,
                "حركي": 0
            ]
            
            for (_, answer) in selectedOptions {
                let type = mapOptionToType(answer)
                score[type, default: 0] += 1
            }
            
            return score.max(by: { $0.value < $1.value })?.key ?? "غير محدد"
        }
    }


import Foundation
import GameKit

//
struct QuestionProvider{
//    var answeredQuestions = [Int]()
    
    let questions: [Question] = [
        Question(
            with: "hint: B",
            and: 2 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: A",
            and: 1 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: E",
            and: 5 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: D",
            and: 4 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: D",
            and: 4 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: E",
            and: 5 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: E",
            and: 5 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: B",
            and: 2 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: A",
            and: 1 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: E",
            and: 5 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: C",
            and: 3 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: E",
            and: 5 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: A",
            and: 1 ,
            among: ["A", "B", "C", "D", "E"]),
        Question(
            with: "hint: D",
            and: 4 ,
            among: ["A", "B", "C", "D", "E"]),
        
    ]
 
    // Function that just return returns a random integer between 0 and
    // the questions array count
    func getRandomQuestionIndex() -> Int{
        return GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    }
    
}

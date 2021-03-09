
import Foundation

class Question{
    let question: String
    let answer: Int
    let possibleAnswers: [String]
    
    // Initializing answer to question
    init(with question: String, and answer: Int, among possibleAnswers: [String]){
        self.question = question
        self.answer = answer
        self.possibleAnswers = possibleAnswers
    }
}

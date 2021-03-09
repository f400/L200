
import Foundation
import GameKit

// Class QuizzManager
//
class QuizzManager{
    let questionsPerRound = 8
    var numberOfQuestionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var questionsAsked = [Int]()
    var questionProvider: QuestionProvider
    
    init(with questionProvider: QuestionProvider){
        self.questionProvider = questionProvider
    }
    
    // Function that checks whether game is over or not
    // is numberOfQuestionsAsked = questionsPerRound
    func isGameOver() -> Bool{
        return numberOfQuestionsAsked == questionsPerRound ? true : false
    }
    
    // Function that chooses randomly a question among the available
    // questions from the QuestionProvider object
    func askQuestion() -> Question{
        indexOfSelectedQuestion = getRandomUniqueIntPerRound()
        questionsAsked.append(indexOfSelectedQuestion)
        return questionProvider.questions[indexOfSelectedQuestion]
    }
    
    // Function that returns a random number representing an index from
    // the array of questions
    // Checks in a loop while randomNumber
    func getRandomUniqueIntPerRound() -> Int{
        var indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionProvider.questions.count)
        while(questionsAsked.contains(indexOfSelectedQuestion)){
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionProvider.questions.count)
        }
        return indexOfSelectedQuestion
    }
    
    // Function which initializes some of the variables to start a new game
    func startNewGame() -> Void{
        numberOfQuestionsAsked = 0
        correctQuestions = 0
        questionsAsked = []
        indexOfSelectedQuestion = 0
    }
}

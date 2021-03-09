
import UIKit
import GameKit
import AudioToolbox

extension UIImageView {
    func shakeImage(_ duration: Double? = 0.4) {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: duration ?? 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    let quizz = QuizzManager(with: QuestionProvider())
        
    var gameSound: SystemSoundID = 0
    var introSound: SystemSoundID = 1
    var errorSound: SystemSoundID = 2
    
    var chordA: SystemSoundID = 10
    var chordB: SystemSoundID = 11
    var chordC: SystemSoundID = 12
    var chordD: SystemSoundID = 13
    var chordE: SystemSoundID = 14
    var chordF: SystemSoundID = 15
    

    // MARK: - Outlets
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    //OPTIONS
    @IBOutlet weak var firstOptionButton: UIButton!
    @IBOutlet weak var secondOptionButton: UIButton!
    @IBOutlet weak var thirdOptionButton: UIButton!
    @IBOutlet weak var fourthOptionButton: UIButton!
    @IBOutlet weak var fifthOptionButton: UIButton!
    //PICKS
    @IBOutlet weak var firstPick: UIImageView!
    @IBOutlet weak var secondPick: UIImageView!
    @IBOutlet weak var thirdPick: UIImageView!
    @IBOutlet weak var fourthPick: UIImageView!
    @IBOutlet weak var fifthPick: UIImageView!
    //STRINGS
    @IBOutlet weak var firstString: UIImageView!
    @IBOutlet weak var secondString: UIImageView!
    @IBOutlet weak var thirdString: UIImageView!
    @IBOutlet weak var fourthString: UIImageView!
    @IBOutlet weak var fifthString: UIImageView!
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var correctOrNotField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        loadGameStartSound()
        loadErrorSound()
        loadGameChordSound()
        loadGameIntroSound()
        
        playGameIntroSound()
        
        displayQuestion()
        
        thirdPick.transform.rotated(by: 3.141)
//        thirdPick.transform.translatedBy(x: 100, y: 650)
    }
    
    
    
    // MARK: - Helpers
    // Function that loads the sound file to play
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "chordA", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func loadGameIntroSound() {
        let path = Bundle.main.path(forResource: "electricIntro", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &introSound)
    }
    
    func loadErrorSound() {
        let path = Bundle.main.path(forResource: "chordError", ofType: "mp3")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &errorSound)
    }
    
    func loadGameChordSound() {
        let pathA = Bundle.main.path(forResource: "chordA", ofType: "wav")
        let pathB = Bundle.main.path(forResource: "chordB", ofType: "wav")
        let pathC = Bundle.main.path(forResource: "chordC", ofType: "wav")
        let pathD = Bundle.main.path(forResource: "chordD", ofType: "wav")
        let pathE = Bundle.main.path(forResource: "chordE", ofType: "wav")
        let pathF = Bundle.main.path(forResource: "chordF", ofType: "wav")
        
        let soundUrlA = URL(fileURLWithPath: pathA!)
        let soundUrlB = URL(fileURLWithPath: pathB!)
        let soundUrlC = URL(fileURLWithPath: pathC!)
        let soundUrlD = URL(fileURLWithPath: pathD!)
        let soundUrlE = URL(fileURLWithPath: pathE!)
        let soundUrlF = URL(fileURLWithPath: pathF!)
        
        AudioServicesCreateSystemSoundID(soundUrlA as CFURL, &chordA)
        AudioServicesCreateSystemSoundID(soundUrlB as CFURL, &chordB)
        AudioServicesCreateSystemSoundID(soundUrlC as CFURL, &chordC)
        AudioServicesCreateSystemSoundID(soundUrlD as CFURL, &chordD)
        AudioServicesCreateSystemSoundID(soundUrlE as CFURL, &chordE)
        AudioServicesCreateSystemSoundID(soundUrlF as CFURL, &chordF)
    }
    
    
    // Function that plays the loaded sound
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playGameIntroSound() {
        AudioServicesPlaySystemSound(introSound)
    }
    
    func playErrorSound() {
        AudioServicesPlaySystemSound(errorSound)
    }
    func playChordA() {
        AudioServicesPlaySystemSound(chordA)
    }
    func playChordB() {
        AudioServicesPlaySystemSound(chordB)
    }
    func playChordC() {
        AudioServicesPlaySystemSound(chordC)
    }
    func playChordD() {
        AudioServicesPlaySystemSound(chordD)
    }
    func playChordE() {
        AudioServicesPlaySystemSound(chordE)
    }
    func playChordF() {
        AudioServicesPlaySystemSound(chordF)
    }
    
    // Function that displays the question
    // Correctly fills in the question text field as well as the button
    // providing the different options for answers
    func displayQuestion() {
        // Get new question
        let questionToAsk = quizz.askQuestion();
        
        // Fill in fields with according question's info
        questionField.text = questionToAsk.question;
        firstOptionButton.setTitle(questionToAsk.possibleAnswers[0], for: UIControl.State.normal)
        secondOptionButton.setTitle(questionToAsk.possibleAnswers[1], for: UIControl.State.normal)
        thirdOptionButton.setTitle(questionToAsk.possibleAnswers[2], for: UIControl.State.normal)
        fourthOptionButton.setTitle(questionToAsk.possibleAnswers[3], for: UIControl.State.normal)
        fifthOptionButton.setTitle(questionToAsk.possibleAnswers[4], for: UIControl.State.normal)
        
        //correctOrNotField.text = ""
        playAgainButton.isHidden = true
        finalScore.isHidden = true
    }
    
    // Function that displays the score
    // Called if number of questions asked = number of questions per round
    func displayScore() {
        // Hide the answer uttons
        firstOptionButton.isHidden = true
        secondOptionButton.isHidden = true
        thirdOptionButton.isHidden = true
        fourthOptionButton.isHidden = true
        fifthOptionButton.isHidden = true
        
        firstPick.isHidden = true
        secondPick.isHidden = true
        thirdPick.isHidden = true
        fourthPick.isHidden = true
        fifthPick.isHidden = true
        
        
        correctOrNotField.text = ""

        // Display play again button
        playAgainButton.isHidden = false
        finalScore.isHidden = false
        
        //questionField.text = "You have \(quizz.correctQuestions) out of \(quizz.questionsPerRound) correct!"
        currentScore.isHidden = true
        
        var emotion = "⚡️";
        if(quizz.correctQuestions < 0){ emotion = "😬"};
        
        var cheers = "Good Job";
        if(quizz.correctQuestions < 0){ cheers = "keep practicing"};
        
        
        if (quizz.correctQuestions < 0){
            correctOrNotField.text = "Buuuuuuuu!!"
        }
//        else {
//            correctOrNotField.text = "You Rock!!!"
//        }
        
        
        finalScore.text = "\(emotion) \(quizz.correctQuestions)"
        questionField.text = cheers
        
        
        
    }
    
    func displayCurrentScore(){
        currentScore.text = "⚡️\(quizz.correctQuestions)"
    }
    
    // Function that checks whether the game is over and to display the
    // score or game is still on going, hence to continue playing and show
    // the next question
    func nextRound() {
        if quizz.isGameOver() {
            // Game is over
            displayScore()
            quizz.startNewGame()
        } else {
            // Continue game
            displayQuestion()
            displayCurrentScore()
           
        }
    }
    
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    // TODO: Adapt
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        quizz.numberOfQuestionsAsked += 1
        let indexOfSelectedQuestion = quizz.indexOfSelectedQuestion
        let selectedQuestion = quizz.questionProvider.questions[indexOfSelectedQuestion]

        // the correct answer is given in terms of 1st 2nd 3rd 4th option of array --> thus -1
        let correctAnswer = selectedQuestion.answer - 1
        
        
        
        if (sender === firstOptionButton &&  correctAnswer == 0) || (sender === secondOptionButton && correctAnswer == 1) || (sender === thirdOptionButton && correctAnswer == 2) || (sender === fourthOptionButton && correctAnswer == 3) || (sender === fifthOptionButton && correctAnswer == 4) {
            quizz.correctQuestions += 751
            correctOrNotField.text = "Coool!!"
            correctOrNotField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            //At this point is a correct answer
            if( sender === firstOptionButton ){
                firstPick.shakeImage()
                firstString.shakeImage()
                playChordA()
            } else if ( sender === secondOptionButton ){
                secondPick.shakeImage()
                secondString.shakeImage()
                playChordB()
            } else if ( sender === thirdOptionButton ){
                thirdPick.shakeImage()
                thirdString.shakeImage()
                playChordC()
            } else if ( sender === fourthOptionButton ){
                fourthPick.shakeImage()
                fourthString.shakeImage()
                playChordD()
            } else if ( sender === fifthOptionButton ){
                fifthPick.shakeImage()
                fifthString.shakeImage()
                playChordE()
            }
            
            
        } else {
            quizz.correctQuestions -= 342
            correctOrNotField.text = "You suck!!!"
            correctOrNotField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            firstString.shakeImage()
            secondString.shakeImage()
            thirdString.shakeImage()
            fourthString.shakeImage()
            fifthString.shakeImage()
            
            playErrorSound()
        }
        
        loadNextRound(delay: 0)
    }
    
    
    // TODO: Adapt
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        firstOptionButton.isHidden = false
        secondOptionButton.isHidden = false
        thirdOptionButton.isHidden = false
        fourthOptionButton.isHidden = false
        fifthOptionButton.isHidden = false
        
        firstPick.isHidden = false
        secondPick.isHidden = false
        thirdPick.isHidden = false
        fourthPick.isHidden = false
        fifthPick.isHidden = false
        
        currentScore.isHidden = false
        
//        quizz.numberOfQuestionsAsked = 0
//        quizz.correctQuestions = 0
        quizz.startNewGame()
        nextRound()
    }
    
    
    @IBAction func option1Animation(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func option2Animation(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func option3Animation(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func option4Animation(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func option5Animation(_ sender: UIButton) {
        sender.shake()
    }
    
    
    @IBOutlet var sonido1: [UIImageView]!
    

}


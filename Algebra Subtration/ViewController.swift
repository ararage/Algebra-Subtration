//
//  ViewController.swift
//  Algebra Subtration
//
//  Created by Ricardo Perez on 1/22/17.
//  Copyright © 2017 Ricardo Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var btnCheckAnswer: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var lblRightOrWrong: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    
    var randomNumber1 : Int?
    var randomNumber2 : Int?
    var lastRandomNumber : Int?
    var userAnswer : Int?
    var correctAnswer : Int?
    var progress : Int = 0
    var difficulty : String = "easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chooseQuestionNumbers(difficultyLevel: "easy")
        btnNo.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkAnswerACTION(_ sender: UIButton) {
        if(progress == 5){
            btnCheckAnswer.setTitle("CHECK ANSWER", for: UIControlState.normal)
            btnNo.isHidden = true
            switch difficulty {
            case "easy":
                difficulty = "medium"
                progress = 0
            case "medium":
                difficulty = "hard"
                progress = 0
            default:
                break
            }
        }else{
            if let _ = Int(txtInput.text!){
                userAnswer = Int(txtInput.text!)!
                checkIfCorrect()
            }
        }
        
        chooseQuestionNumbers(difficultyLevel: difficulty)
        lblProgress.text = String(progress) + "/5 - "+String(difficulty)
        txtInput.text?.removeAll()
    }

    @IBAction func chooseNoACTION(_ sender: UIButton) {
        chooseQuestionNumbers(difficultyLevel: difficulty)
        progress = 0
        lblProgress.text  = String(progress) + "/5 - "+String(difficulty)
        btnNo.isHidden = true
        btnCheckAnswer.setTitle("CHECK ANSWER", for: UIControlState.normal)
    }
    
    //x - rn1 = rn2
    //rn1 - x = rn2
    func setUpQuestion(){
        let x_position : UInt32 = arc4random_uniform(2)
        switch x_position {
        case 0:
            correctAnswer = randomNumber2! + randomNumber1!
            lblQuestion.text = "x - "+String(describing:randomNumber1!)+" = "+String(describing:randomNumber2!)
        case 1:
            correctAnswer = randomNumber1! - randomNumber2!
            lblQuestion.text = String(describing:randomNumber1!)+" - x = "+String(describing:randomNumber2!)
        default:
            break
        }
        
    }
    
    //x - rn1 = rn2
    //rn1 - x = rn2
    func chooseQuestionNumbers(difficultyLevel:String){
        switch difficultyLevel {
        case "easy":
            randomNumber1 = Int(arc4random_uniform(7))
            randomNumber2 = Int(arc4random_uniform(7))
            
            if(randomNumber1! == lastRandomNumber || randomNumber2 == lastRandomNumber || randomNumber1! < randomNumber2!){
                chooseQuestionNumbers(difficultyLevel: "easy")
            }
        case "medium":
            randomNumber1 = 7 + Int(arc4random_uniform(6))
            randomNumber2 = 7 + Int(arc4random_uniform(6))
            
            if(randomNumber1! == lastRandomNumber || randomNumber2 == lastRandomNumber || randomNumber1! < randomNumber2!){
                chooseQuestionNumbers(difficultyLevel: "medium")
            }
        case "hard":
            randomNumber1 = 6 - Int(arc4random_uniform(13))
            randomNumber2 = 6 - Int(arc4random_uniform(13))
            
            if(randomNumber1! == lastRandomNumber || randomNumber2 == lastRandomNumber){
                chooseQuestionNumbers(difficultyLevel: "hard")
            }
        default:
            break
        }
        
        lastRandomNumber = randomNumber1
        setUpQuestion()
    }
    
    func checkIfCorrect(){
        if(userAnswer == correctAnswer){
            progress += 1
            lblRightOrWrong.text = "Correct!"
            lblRightOrWrong.backgroundColor = UIColor.green
            if(progress == 5){
                lblRightOrWrong.text = "Correct! Advance difficulty?"
                btnCheckAnswer.setTitle("YES", for: UIControlState.normal)
                btnNo.isHidden = false
            }
        }else{
            lblRightOrWrong.text = "Incorrect!"
            lblRightOrWrong.backgroundColor = UIColor.red
        }
    }
    
}


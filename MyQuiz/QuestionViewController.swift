//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by Miyuki_nekoneko on 2021/05/20.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {

    var questionData : QuestionData!
    
//    storyboardと関連づけ
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!

    @IBOutlet weak var incorrectView: UIImageView!
    @IBOutlet weak var correctView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        QuestionDataから値を取り出す。
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
//                                                      前画面から受け取ったデータの部品への反映. UIControl.State.normalとはボタンがタップされていない状態のこと。
        answer1Button.setTitle(questionData.answer1, for: UIControl.State.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControl.State.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControl.State.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControl.State.normal)
    }
//    選択肢１をタップ
    @IBAction func tapAnswer1Button(_ sender: Any) {
    questionData.userChoiceAnswerNumber = 1
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer2Button(_ sender: Any) {
    questionData.userChoiceAnswerNumber = 2
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer3Button(_ sender: Any) {
    questionData.userChoiceAnswerNumber = 3
        goNextQuestionWithAnimation()
    }
        
    @IBAction func tapAnswer4Button(_ sender: Any) {
    questionData.userChoiceAnswerNumber = 4
            goNextQuestionWithAnimation()
    }
    
//        次の問題にアニメーションつきで進む
        func goNextQuestionWithAnimation(){
//正解かの判定
            if questionData.isCorrect(){
//                正解のアニメーションを再生しながら次の問題へ遷移する
                goNextQuestionWithCorrectAnimation()
            }
            else{
                goNextQuestionWithIncorrectAnimation()
            }
        }
        
        func goNextQuestionWithCorrectAnimation(){
                AudioServicesPlayAlertSound(1025)
            
                UIView.animate(withDuration: 2.0, animations: {
                    self.correctView.alpha = 1.0
                })
                    {(Bool) in
                    self.goNextQuestion()
                    }
        }
    
        func goNextQuestionWithIncorrectAnimation(){
                AudioServicesPlayAlertSound(1006)
        
                UIView.animate(withDuration: 2.0, animations: {
                    self.incorrectView.alpha = 1.0
                })
                    {(Bool) in
                    self.goNextQuestion()
                    }
        }
    
    func goNextQuestion(){
//        次の問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
//            問題文がなければ結果画面へ遷移する。storyboardID"result"を指定してViewControllerを生成する。
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController{
//                storyboardのSegueを利用しない画面遷移処理
            present(resultViewController, animated:true, completion:nil)
            }
            return
        }
//        問題文がある場合は次の問題へ遷移する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController{
            nextQuestionViewController.questionData = nextQuestion
            //                storyboardのSegueを利用しない画面遷移処理。animated:trueでアニメーションあり。completion:nilはコールバック関数
            present(nextQuestionViewController, animated:true, completion:nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  StartViewController.swift
//  MyQuiz
//
//  Created by Miyuki_nekoneko on 2021/05/20.
//

import UIKit

class StartViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        問題文の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        
//        遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
//           取得できずに終了
            return
        }
        
//        問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            return
        }
        
//        問題文のセット
        nextViewController.questionData = questionData
        
    }
    
//    タイトルに戻ってくるときに呼び出される処理
    @IBAction func gotitle(_segue: UIStoryboardSegue){
                           
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by Miyuki_nekoneko on 2021/05/21.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet weak var correctPercentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        問題数を取得する
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
//        正解数を取得する
        var correctCount: Int = 0
        
//        正解数を計算する
        for questionData in QuestionDataManager.sharedInstance.questionDataArray{
            if questionData.isCorrect(){
//                正解数を増やす
                correctCount += 1
            }
        }
        // Do any additional setup after loading the view.
    
    
    let correctPercent: Float = (Float(correctCount)/Float(questionCount))*100
    
//        format:小数点1位まで。小数点は切り捨て。
    correctPercentLabel.text = String(format:"%.1f",correctPercent)+"%"
    
    
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

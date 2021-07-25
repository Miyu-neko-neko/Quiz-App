//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by Miyuki_nekoneko on 2021/05/18.
//

import Foundation

class QuestionData{
//    csvから読み取った情報（１問）の格納。プロパティー定義
    var question: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    var correctAnswerNumber: Int
    
//    ユーザーが選択した番号
    var userChoiceAnswerNumber: Int?
    
//    問題文の番号
    var questionNo: Int = 0
    
//    クラスが生成された時の処理
    init(questionSourceDataArray:[String]) {
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
//    答えが正解かどうか判定する。　isCorrectメソッド,Bool型の戻り値つきの関数の宣言。
    func isCorrect()->Bool{
//        答えが一致しているか判定うする
        if correctAnswerNumber == userChoiceAnswerNumber{
//            正解
            return true
        }
//        不正解
        return false
    }
}


class QuestionDataManager{
    
//    シングルトンオブジェクトの宣言
    static let sharedInstance = QuestionDataManager()
    
//    複数の問題文を格納するための配列の宣言. プロパティ宣言と同時にインスタンスを生成
    var questionDataArray = [QuestionData]()
    
    var nowQuestionIndex: Int = 0
    
//    外部のクラスからインスタンス化されないためのprivate宣言
    private init(){
//        シングルトンであることを保証する
    }
    
//    CSVファイルから問題文を読み込む処理の作成
    func loadQuestion(){
//        結果画面から再度クイズを開始できるように削除
        questionDataArray.removeAll()
//        現在の問題のインデックスを初期化
        nowQuestionIndex = 0
    
//    csvファイルパスを取得。アプリ内のファイルを探索するにはBundle.main.pathメソッドを利用
    guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv")else {
        print("csvファイルが存在しません")
        return
    }
//    csvファイルの読み込み
        do{
//            throws発生時の処理
        let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
//        記載されているデータの呼び出し（一行ずつ）
            csvStringData.enumerateLines(invoking: {(line,stop)in
//                カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy:",")
//                問題データを格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
//                問題を追加
                self.questionDataArray.append(questionData)
//                問題番号を設定
                questionData.questionNo = self.questionDataArray.count
            })
        }
        catch let error {
            print("csvファイル読み込みエラーが発生しました:\(error)")
            return
        }
    }
    //次の問題を取り出す。　戻り値つき関数の呼び出し
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }

}

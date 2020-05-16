//
//  gameViewController.swift
//  guessNumberOfBullnCow
//
//  Created by 林祐辰 on 2020/5/14.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
   
    var times = 0
 
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var tryNumber: UITextView!
    @IBOutlet weak var resultTip: UITextView!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var finalText: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        createNum()
        finalText.isHidden = true
    }
  
    var numberMap = ["0","1","2","3","4","5","6","7","8","9"]
    var answerArray = [String]()

    
    // 生成隨機 4A 的數值
    func createNum(){
        var loadingNum = 0
        for i in 0...3{
            loadingNum = Int.random(in:0...numberMap.count-1)
            let pickNum = numberMap.remove(at: loadingNum)
            answerArray.append(pickNum)
        }
       
        print(answerArray)   // 檢查數值
    }
    
    
   // 彈跳視窗
    func alertScreen(passInTitle:String,passInMessage:String){
        let mainAlert = UIAlertController(title: passInTitle, message: passInMessage, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        mainAlert.addAction(alertButton)
        present(mainAlert, animated: true, completion: nil)
    }
    
    // 顯示正確答案
    func correctNumber(){
        finalText.isHidden = false
        finalText.text = "\(answerArray[0])"+"\(answerArray[1])"+"\(answerArray[2])"+"\(answerArray[3])"
    }
    
    // 顯示下方提示數值
    func refernceTip(typeNum:String,aNum : Int, bNum: Int){
        let historyNum = "\(typeNum) \n"
        let howMuchAB = "\(aNum) a \(bNum) b \n"
        tryNumber.text += historyNum
        resultTip.text += howMuchAB
        typeText.text = ""
    }
    
    
    // 點選提交鍵的動作
    @IBAction func checkButton(_ sender: UIButton) {
        if let textfieldHasTypeInt = typeText.text{
            if textfieldHasTypeInt.count == 4{
                var a = 0
                var b = 0
                var i = 0
                
                times+=1
                timesLabel.text = "\(times) 次"
                for guessNum in textfieldHasTypeInt{
                   let numToString = String(guessNum)
                
                    if (answerArray[i] == numToString){
                       a+=1
                    }else if (answerArray.contains(numToString)){
                      b+=1
                    }
                   i+=1
              }
                
                if(a == 4){
                    alertScreen(passInTitle: "恭喜成功",passInMessage: "Nice")
                    correctNumber()
                    refernceTip(typeNum: textfieldHasTypeInt, aNum: a, bNum: b)
                }else{
                    refernceTip(typeNum:textfieldHasTypeInt,aNum: a, bNum: b)
                }
                
            }else if(textfieldHasTypeInt.count>4){
                alertScreen(passInTitle: "太多數字了拉",passInMessage: "再打一次吧")
                typeText.text = ""
            }else{
                alertScreen(passInTitle: "不足4個字喔",passInMessage: "請重打謝謝")
                typeText.text = ""
            }
        }
        
    }
    
    
    
    // 點選重玩鍵
    @IBAction func restartButton(_ sender: UIButton) {
        times = 0
        timesLabel.text = "\(times) 次"
        finalText.isHidden = true
        tryNumber.text = ""
        resultTip.text = ""
        typeText.text = ""
        cleanOldAnswer()
    }
    
     // 清除數值紀錄
    func cleanOldAnswer(){
        numberMap = ["0","1","2","3","4","5","6","7","8","9"]
        answerArray = [String]()
        createNum()
    }

}

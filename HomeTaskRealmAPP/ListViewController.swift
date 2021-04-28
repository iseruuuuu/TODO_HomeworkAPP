//
//  ListViewController.swift
//  HomeTaskRealmAPP
//
//  Created by 井関竜太郎 on 2021/04/24.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var start: UIButton!
    
    
    var string1 = String()
    var date3 = Date()
    var not = Bool()
    
    var string2 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start.layer.cornerRadius = 15
        start.layer.borderWidth = 2
        start.layer.borderColor = UIColor.systemTeal.cgColor
        
        if not == true {
            string2 = "オン"
        }else{
            string2 = "オフ"
        }
        
        text1.text = "課題名：　　" + string1
        text2.text = "通知の設定：　　" + string2
        text3.text = "実行時間：　　" + Helper().deteToString(date: date3)
    }
    
    @IBAction func start(_ sender: Any) {
        //アラート生成
        //UIAlertControllerのスタイルがalert
        let alert: UIAlertController = UIAlertController(title: "課題を開始します。", message:  "頑張ってください！", preferredStyle:  UIAlertController.Style.alert)
        // キャンセルボタンの処理
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{
            // キャンセルボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            //通知を止める
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        })

        //UIAlertControllerにキャンセルボタンと確定ボタンをActionを追加
        alert.addAction(cancelAction)

        //実際にAlertを表示する
        present(alert, animated: true, completion: nil)
      
        
    }
    
}

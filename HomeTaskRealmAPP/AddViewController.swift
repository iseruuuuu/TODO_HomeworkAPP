//
//  AddViewController.swift
//  HomeTaskRealmAPP
//
//  Created by 井関竜太郎 on 2021/04/24.
//

import Foundation
import RealmSwift


class AddViewController: UIViewController {
    
    
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var swichNotification: UISwitch!
    @IBOutlet weak var add: UIButton!
    
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        add.layer.cornerRadius = 15
        add.layer.borderWidth = 2
        add.layer.borderColor = UIColor.systemTeal.cgColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    
    
    @IBAction func add(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "", message: "登録確認", preferredStyle:  UIAlertController.Style.actionSheet)
        let defaultAction: UIAlertAction = UIAlertAction(title: "登録する", style: UIAlertAction.Style.default, handler:{ [self]
            (action: UIAlertAction!) -> Void in
            Helper().save(title:itemField.text!,date:datePicker.date,notification: swichNotification.isOn)
            //画面を閉じた時の演出は,completionを設定する。
            dismiss(animated: true, completion: nil)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}

//
//  Helper.swift
//  RealmTodoAPP
//
//  Created by 井関竜太郎 on 2021/02/08.
//

//TODO 時間設定
//TODO 通知設定

import Foundation
import RealmSwift
import UserNotifications
import NotificationCenter

class Helper{
    
    let realm = try! Realm()
    
    func save(title:String,date:Date,notification:Bool) {
        let item = TodoItem()
        item.title = title
        item.date = date
        item.notification = notification
        item.id = String(Int.random(in: 0...9999))
        try! realm.write{
            realm.add(item)
        }
        if item.notification == true {
            setNotification(item: item)
        }else{
        }
    }
    
    func update(title:String,date:Date,notification:Bool,id:String) {
        let item = TodoItem()
        item.title = title
        item.date = date
        item.notification = notification
        item.id = String(Int.random(in: 0...9999))
        try! realm.write{
            realm.add(item, update: .modified)
        }
    }
    
    func deteToString(date:Date) ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH時mm分"
        return formatter.string(from:date)
    }
    
    
    func setNotification(item:TodoItem){
        for i in 0...63 {
            let content = UNMutableNotificationContent()
            content.title = "課題の時間になりました！！！"
            content.body = "課題に取り組まないと単位が取れないよ？？"
            content.sound = UNNotificationSound.default
            let n = item.date.addingTimeInterval(TimeInterval(0 + (3 * i)))
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: n)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest.init(identifier: "CalendarNotification\(i)",content: content,trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                print(request)
                if error != nil {
                    print("something went wrong")
                }
            }
        }
    }
    
    
    func deleteItem(item:TodoItem,token:NotificationToken) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id])
        try! realm.write(withoutNotifying: [token]) {
            realm.delete(item)
        }
    }
}










/*
 
 let content = UNMutableNotificationContent()
 content.title = item.title + "がもうすく始まります"
 content.body = "アプリを開いて確認してみよう！"
 content.sound = UNNotificationSound.default
 
 let targetDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],from: item.date)
 let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate,repeats: true)
 let request = UNNotificationRequest.init(identifier: item.id, content: content, trigger: trigger)
 UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
 */

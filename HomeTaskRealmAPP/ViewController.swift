//
//  ViewController.swift
//  HomeTaskRealmAPP
//
//  Created by 井関竜太郎 on 2021/04/24.
//

import UIKit
import RealmSwift
import UserNotifications

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var itemList:Results<TodoItem>!
    var token:NotificationToken!
    var edit:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemList = realm.objects(TodoItem.self).sorted(byKeyPath: "date")
        self.navigationController?.navigationBar.barTintColor = .systemTeal
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        //データの変更を監視する。
        token = realm.observe { notification,realm in
            //変更があったときはtableViewに更新
            self.tableView.reloadData()
        }
        tableView.deleteRows(at: [], with: .automatic)
        navigationItem.leftBarButtonItem = editButtonItem
        edit = false
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing == false {
            edit = false
            self.title = "授業リスト"
        }else {
            edit = true
            self.title = "授業編集"
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Helper().deleteItem(item: itemList[indexPath.row], token: token)
            
            //削除をしたものを非表示にする。
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if edit == false {
            let next = storyboard?.instantiateViewController(identifier: "next") as! ListViewController
            next.string1 = itemList[indexPath.row].title
            next.not = itemList[indexPath.row].notification
            
            
            
            print(itemList[indexPath.row].id)
            
            
            
            navigationController?.pushViewController(next, animated: true)
        } else{
            let nextEdit = storyboard?.instantiateViewController(identifier: "edit") as! EditViewController
            nextEdit.editlabel1 =  itemList[indexPath.row].title
            nextEdit.editDate = itemList[indexPath.row].date
            
            nextEdit.id = itemList[indexPath.row].id
            
            print(itemList[indexPath.row].id)
            
            navigationController?.pushViewController(nextEdit, animated: true)
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //セルの高さを決めるメソッド→　view.frame.size.heightは、機種によって合わせてくれる。
        return view.frame.size.height/11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = itemList[indexPath.row]
        cell?.selectionStyle = .none
        cell?.textLabel?.text = item.title + "   " 
        cell?.detailTextLabel?.text = Helper().deteToString(date: item.date)
        return cell!
    }
    
    
}


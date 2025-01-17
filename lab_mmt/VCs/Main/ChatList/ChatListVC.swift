//
//  ChatListVC.swift
//  unichat
//
//  Created by Imbaggaarm on 10/13/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

var chatRooms = [ChatRoom]()

class ChatListVC: ChatListVCLayout, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
     
        addOnNewMessageObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    var chatThreadVMs = [ChatThreadCellVM]()
    
    func reloadData() {
        chatThreadVMs = []
        
        //sort room by last message time
        let sortedRooms = chatRooms.sorted { (a, b) -> Bool in
            return a.lastMessage.createdTime > b.lastMessage.createdTime
        }
        
        for room in sortedRooms {
            let thread = ChatThreadCellVM.init(with: room)
            chatThreadVMs.append(thread)
        }
        
        tableView.reloadData()
    }
    override func onLeftBarButtonTapped() {
        super.onLeftBarButtonTapped()
        let profileVC = ProfileVC.init(user: UserProfile.this)
        let naVC = UINavigationController.init(rootViewController: profileVC)
        naVC.view.backgroundColor = AppColor.backgroundColor
        present(naVC, animated: true, completion: nil)
    }
    
    func addOnNewMessageObserver() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleNewMessage(notification:)), name: MessageHandler.onNewMessage, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleOnlineStateChanging), name: MessageHandler.onPeerConnectionChanging, object: nil)
    }
    
    func removeOnNewMessageObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        removeOnNewMessageObserver()
    }
    
    @objc func handleOnlineStateChanging() {
        reloadData()
    }
    
    @objc func handleNewMessage(notification: Notification) {
        guard let message = notification.userInfo?[MessageHandler.messageUserInfoKey] as? Message else {
            return
        }
        
        for (i, t) in chatThreadVMs.enumerated() {
            if t.room.id == message.from || t.room.id == message.to {
                let oldIndex = IndexPath.init(row: i, section: 0)
                
                chatThreadVMs.remove(at: i)
                // create new chat thread VM
                let newVM = ChatThreadCellVM.init(with: t.room)
                chatThreadVMs.insert(newVM, at: 0)
                
                let newIndex = IndexPath.init(row: 0, section: 0)
                tableView.moveRow(at: oldIndex, to: newIndex)
                tableView.reloadRows(at: [newIndex], with: .none)
                return
            }
        }
        //chatThreadVMs.insert(ChatThreadCellVM.init(with: message.), at: <#T##Int#>)
    }
    
}


//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension ChatListVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatThreadVMs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableView.CELL_ID, for: indexPath) as! ChatThreadTableViewCell
        cell.cellVM = chatThreadVMs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let mainTabbarController = tabBarController as? MainTabbarVC {
            
            let chatVC = ChatVC(webRTCClient: mainTabbarController.webRTCClient, room: chatThreadVMs[indexPath.row].room)
            chatVC.hidesBottomBarWhenPushed = true
            show(chatVC, sender: nil)
        }
    }
}

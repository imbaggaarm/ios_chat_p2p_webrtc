//
//  ChatThreadTableViewCell.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/27/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit
//import Kingfisher

class ChatThreadTableViewCell: IMBBaseTableViewCell {
    var cellVM: ChatThreadCellVM? {
        didSet {
            self.showData()
        }
    }
    
    let imgVAvatar: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.white
        temp.clipsToBounds = true
        temp.image = UIImage.init(named: "tim")
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    let lblTitle: UILabel = {
        let temp = UILabel()
//        temp.text = "Tai Duong"
        temp.font = UIFont.boldSystemFont(ofSize: 17)
        temp.numberOfLines = 1
        return temp
    }()
    
    let lblLastMessage: UILabel = {
        let temp = UILabel()
//        temp.text = "Bạn: Uhm, t biết rồi."
        temp.font = UIFont.systemFont(ofSize: 15)
        temp.numberOfLines = 2
        return temp
    }()
    
    let lblTime: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .right
        temp.textColor = .gray
        temp.font = UIFont.systemFont(ofSize: 12)
//        temp.text = "13:02"
        return temp
    }()
    
    let imgVMessageStatus: UIImageView = {
        let temp = UIImageView()
        temp.image = AppIcon.newMessage
        temp.backgroundColor = UIColor.black
        return temp
    }()
    
    let vOnlineState: UIView = {
        let temp = UIView()
        return temp
    }()
    
    override func setUpLayout() {
        super.setUpLayout()
        
        selectionStyle = .none
        
        backgroundColor = .black
        
        contentView.addSubviews(subviews: imgVAvatar, lblTitle, lblLastMessage, lblTime, imgVMessageStatus, vOnlineState)
        
        contentView.addConstraintsWith(format: "H:|-16-[v0]-10-[v1]-10-[v2]-16-|", views: imgVAvatar, lblTitle, lblTime)
        contentView.addConstraintsWith(format: "H:[v0]-10-[v1]-10-[v2]-16-|", views: imgVAvatar, lblLastMessage, imgVMessageStatus)
        
        contentView.addConstraintsWith(format: "V:|-8-[v0]-8-|", views: imgVAvatar)
        contentView.addConstraintsWith(format: "V:|-8-[v0]-2-[v1]", views: lblTitle, lblLastMessage)
        
        imgVAvatar.makeCircle(corner: 30)
        
        // lblTime
        do {
            lblTime.centerYAnchor(with: lblTitle)
        }
        
        // imgVLastMessageState
        do {
            imgVMessageStatus.centerYAnchor(with: lblLastMessage)
            imgVMessageStatus.makeCircle(corner: 7.5)
            imgVMessageStatus.layer.shouldRasterize = true
            imgVMessageStatus.contentScaleFactor = UIScreen.main.scale
        }
        
        vOnlineState.makeCircle(corner: 6)
        let spacing = (CGFloat(2.0.squareRoot()/2.0) + 1)*30 - 6
        vOnlineState.topAnchor(equalTo: imgVAvatar.topAnchor, constant: spacing)
        vOnlineState.leftAnchor(equalTo: imgVAvatar.leftAnchor, constant: spacing)
    }
    
    override func showData() {
        super.showData()

        guard let vm = cellVM else {
            return
        }
        
        imgVAvatar.kf.setImage(with: vm.avtImageURL)
        lblTitle.text = vm.title
        lblTime.text = vm.time
        lblLastMessage.text = vm.lastMessage
        lblLastMessage.font = vm.lastMessageFont
        lblLastMessage.textColor = vm.lastMessageTextColor
        imgVMessageStatus.image = vm.messageStatusIcon
        
        var color: UIColor
        switch vm.onlineState {
        case .online:
            color = .green
        case .offline:
            color = .clear
        case .doNotDisturb:
            color = .red
        default:
            color = .yellow
        }
        vOnlineState.backgroundColor = color

    }


}

//
//  AnotherChatViewController.swift
//  CW
//
//  Created by Егор on 07.06.2020.
//  Copyright © 2020 Stroev Egor. All rights reserved.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    
}

class AnotherChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
  
    let currentUser = Sender(senderId: "self", displayName: "Egor Stroev")
    
    let otherUser = Sender(senderId: "other", displayName: "Igor Kuznetcov")
    
    var messages = [MessageType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        
        
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Здравствуйте! Вам нужно разобрать старый дом?")))
         messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-70000), kind: .text("Добрый день! Да, нужен человек сегодня в 15:00 до 18:00, оплата 1000 рублей")))
         messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-60000), kind: .text("Отлично! Какой адрес? Куда нужно подъехать")))
         messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-50000), kind: .text("Шамиля Усманова 15А, в 14:50 жду вас")))
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-40000), kind: .text("Понял, буду. Инструменты нужны какие-нибудь с собой?")))
        messages.append(Message(sender: otherUser, messageId: "6", sentDate: Date().addingTimeInterval(-30000), kind: .text("Нет, всё предоставим.")))
 }
    
    func currentSender() -> SenderType {
          return currentUser
      }
      
      func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
      }
      
      func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
      }
      
    


}




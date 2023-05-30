//
//  ChatViewController.swift
//  Messenger
//
//  Created by apple on 29.05.2023.
//

import UIKit
import MessageKit
import InputBarAccessoryView


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


class ChatViewController: MessagesViewController {
    
    var chatID: String?
    var otherID: String?
    let service = Service.shared
    
    let selfSender = Sender(senderId: "1", displayName: "Antony")
    let otherSender = Sender(senderId: "2", displayName: "Jim")
    
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date().addingTimeInterval(-11200), kind: .text("Hello")))
        messages.append(Message(sender: otherSender, messageId: "2", sentDate: Date().addingTimeInterval(-10200), kind: .text("Hello! I'm fine)")))
        messages.append(Message(sender: otherSender, messageId: "3", sentDate: Date().addingTimeInterval(-90200), kind: .text("And you?")))

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        showMessageTimestampOnSwipeLeft = true
    }
    

}

extension ChatViewController: MessagesLayoutDelegate, MessagesDisplayDelegate, MessagesDataSource {
    var currentSender: SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let msg = Message(sender: selfSender, messageId: "4", sentDate: Date(), kind: .text(text))
        messages.append(msg)
        service.sendMessage(otherId: self.otherID, conversationId: self.chatID, message: msg, text: text) { [weak self] isSend in
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
            }
        }
        
    }
}

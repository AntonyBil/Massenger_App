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
        let msg = Message(sender: selfSender, messageId: "", sentDate: Date(), kind: .text(text))
        messages.append(msg)
        service.sendMessage(otherId: self.otherID, conversationId: self.chatID, text: text) { [weak self] isSend in
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
            }
        }
        
    }
}

//
//  MessagesViewController.swift
//  EtchAMessage MessagesExtension
//
//  Created by Piera Marchesini on 05/02/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, SendMessage {
    
    var conversation: MSConversation?
    let compactStoryboardIdentifier = "compact"
    let expandedStoryboardIdentifier = "expanded"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Action
    @IBAction func startButtonPressed(_ sender: Any) {
        requestPresentationStyle(.expanded)
    }
    
    // MARK: - Delegates
    func didSendDraw(on image: UIImage) {
        self.composeMessage(image: image)
        requestPresentationStyle(.compact)
    }
    
    // MARK: - Create Message
    func composeMessage(image: UIImage) {
        let conversation = self.conversation
        
        let layout = MSMessageTemplateLayout()
        layout.image = image
        layout.caption = "Etch a Message"
        
        let message = MSMessage()
        message.layout = layout
        
        conversation?.insert(message, completionHandler: nil)
    }
    
    // MARK: - Conversation Handling
    override func willBecomeActive(with conversation: MSConversation) {
        self.conversation = conversation
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        if let aConversation = self.conversation {
            presentViewController(conversation: aConversation, presentationStyle: presentationStyle)
        }
    }

    
    //MARK: - Draw ViewController
    func presentViewController(conversation: MSConversation, presentationStyle: MSMessagesAppPresentationStyle){
        var controller: UIViewController
        if presentationStyle == .compact {
            controller = instantiateCompactViewController()
        } else {
            controller = instantiateExpandedViewController()
            
            if let gameVC = controller as? DrawViewController {
                gameVC.delegate = self
            }
        }
        
        addChildViewController(controller)
        view.addSubview(controller.view)
        
        controller.view.frame = view.bounds
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    func instantiateExpandedViewController() -> UIViewController {
        if let expandedViewController = storyboard?.instantiateViewController(withIdentifier: expandedStoryboardIdentifier) {
            return expandedViewController
        } else { return UIViewController() }
    }
    
    func instantiateCompactViewController() -> UIViewController {
        if let compactViewController = storyboard?.instantiateViewController(withIdentifier: compactStoryboardIdentifier) {
            return compactViewController
        } else { return UIViewController() }
    }
}

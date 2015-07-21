//
//  ViewController.swift
//  SmsSender
//
//  Created by Akash Rastogi on 21/07/15.
//  Copyright (c) 2015 Akash. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    // outlets
    @IBOutlet weak var txtMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBActions
    @IBAction func btnSendSmsClicked(sender: UIButton) {
        if MFMessageComposeViewController.canSendText(){
            let message : String! = self.txtMessage.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            if !message.isEmpty{
                var messageVC = MFMessageComposeViewController()
                messageVC.body = txtMessage.text
                messageVC.recipients = ["0123456789"]
                messageVC.messageComposeDelegate = self;
                self.presentViewController(messageVC, animated: false, completion: nil)
            }
            else {
                let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Please enter you message to send sms.", delegate: nil, cancelButtonTitle: "OK")
                errorAlert.show()
            }
        }
        else {
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: nil, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    @IBAction func btnSendEmailClicked(sender: UIButton) {
        if MFMailComposeViewController.canSendMail(){
            let message : String! = self.txtMessage.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            if !message.isEmpty{
                var emailVC = MFMailComposeViewController()
                emailVC.setSubject("Test email")
                emailVC.setMessageBody(message, isHTML: true)
                let arrRecipients = ["akash@example.com"]
                emailVC.setToRecipients(arrRecipients)
                emailVC.mailComposeDelegate = self;
                self.presentViewController(emailVC, animated: false, completion: nil)
            }
            else {
                let errorAlert = UIAlertView(title: "Cannot Send Email", message: "Please enter you message to send Email.", delegate: nil, cancelButtonTitle: "OK")
                errorAlert.show()
            }
        }
        else {
            let errorAlert = UIAlertView(title: "Cannot Send Email", message: "Your device is not able to send Email.", delegate: nil, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    // SMS delegate methods
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch(result.value){
        case MessageComposeResultCancelled.value:
            println("Message was cancelled")
        case MessageComposeResultFailed.value:
            println("Message failed")
        case MessageComposeResultSent.value:
            println("Message was sent")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Email delegate methods
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch(result.value){
        case MFMailComposeResultCancelled.value:
            println("Email was cancelled")
        case MFMailComposeResultSaved.value:
            println("Email was saved")
        case MFMailComposeResultSent.value:
            println("Email was sent")
        case MFMailComposeResultFailed.value:
            println("Email failed" + error.localizedDescription)
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


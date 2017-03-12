//
//  ViewController.swift
//  TestChatUI
//
//  Created by Md. Kamrul Hasan on 3/12/17.
//  Copyright © 2017 MKHG Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldBottomMargin: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let indextPath = IndexPath(item: 19, section: 0)
        tableView.scrollToRow(at: indextPath, at: .bottom, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Keyboard delegates
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var keyboardHeight:CGFloat = 0
    func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboardHeight = keyboardFrame.height
        textFieldBottomMargin.constant = keyboardFrame.height
        
        let scrollPoint = CGPoint(x: 0, y: self.tableView.contentSize.height - keyboardFrame.height)
        self.tableView.setContentOffset(scrollPoint, animated: true)
    }
    
    func keyboardWasHidden(notification: NSNotification) {
        //let info = notification.userInfo!
        //let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        textFieldBottomMargin.constant = 0
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) 
        
        cell.textLabel?.text = "Md. Kamrul Hasan. Engr. of Computer Science And Engineering. Khulna University of Engineering & Technology." + "\(indexPath.row)"
        
        return cell
    }
    
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


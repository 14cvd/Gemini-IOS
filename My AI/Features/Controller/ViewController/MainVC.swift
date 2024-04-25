//
//  ViewController.swift
//  My AI
//
//  Created by cavID on 24.04.24.
//

import UIKit
import SnapKit

final class MainVC: UIViewController {
   private let customNavigationController = UINavigationController()
    private var textData : String =  "Hello"
//    private let label : UILabel = {
//       let label = UILabel()
//        label.text = "Hasan Sabah"
//        return label
//    }()
    
    private lazy var tableView : UITableView = {
      let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    private var chatService = ChatService()
    private var data : String = ""
    
    private lazy var inputTextField : UITextField = {
       let tf = UITextField()
        data = tf.text ?? ""
//        let iv = UIImageView(image: UIImage(systemName: "paperplane"))
//        let gesture = UIGestureRecognizer(target: self, action: #selector(sender))
//        iv.isUserInteractionEnabled = true
//        iv.addGestureRecognizer(gesture)
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .default)
        let iv = UIImageView(image: UIImage( systemName: "arrow.right", withConfiguration: config))
        button.tintColor = .white
        iv.tintColor = .white
        let action = UIAction { _ in
            if let items = tf.text {
                self.chatService.sendMessage(items)
                self.data = items
            }
        }
        button.setTitle("D", for: .normal)
        

        button.addAction(action, for: .touchUpInside)
        button.backgroundColor = UIColor(named: "main")
        button.layer.cornerRadius = 30
        
        tf.backgroundColor = .red
        tf.rightViewMode = .always
        tf.rightView = button
        return tf
    }()
    
    @objc func sender(){
        chatService.sendMessage(data)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        config()
        configNavigationBar()
        constraintConfig()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    


}

extension MainVC : UIConfig{
    
 
    func config() {
        view.addSubview(tableView)
        view.addSubview(inputTextField)
    }
    
    private func configNavigationBar(){
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backAction))
            backButton.tintColor = .black
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 169, height: 51))
        
         let iconAvatar = UIImageView(image: UIImage(named: "avatar"))
            
         iconAvatar.frame = CGRect(x: 0, y: 0, width: 24, height: 36)
         customView.addSubview(iconAvatar)
        
         let label1 = UILabel()
         label1.text = "ChatGPT"
         label1.textColor = UIColor(named: "main")
         label1.font = UIFont(name: "Nunito-Bold", size: 20)
            
         label1.frame = CGRect(x: 50, y: 0, width: 84, height: 27)
         customView.addSubview(label1)

         let label2 = UILabel()
         label2.text = "• Online"
         label2.font = UIFont(name: "Nunito", size: 17)
         label2.textColor = .green
         label2.frame = CGRect(x: 50, y: 22, width: 83, height: 23)
         customView.addSubview(label2)

         let textItem = UIBarButtonItem(customView: customView)

         let forwardButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(forwardAction))
             forwardButton.tintColor = .gray

         navigationItem.leftBarButtonItems = [backButton, textItem]
         navigationItem.rightBarButtonItem = forwardButton
        
     }
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func forwardAction() {
    }
    
    func constraintConfig() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        
        inputTextField.snp.makeConstraints { make in
            make.bottom.equalTo(additionalSafeAreaInsets).offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.width.equalTo(333)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardSize.height
        let safeAreaBottomInset = view.safeAreaInsets.bottom
        
        // Klavyanın yüksekliği kadar view'i yukarı kaydır
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -keyboardHeight + safeAreaBottomInset
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        // Klavya gizlendiğinde view'i tekrar eski konumuna getir
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}





extension MainVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatService.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.id, for: indexPath) as? ChatTableViewCell{
            cell.chatMessage = chatService.messages[indexPath.row]
        
            
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
  
}



extension MainVC : UITextFieldDelegate {
    
    
}



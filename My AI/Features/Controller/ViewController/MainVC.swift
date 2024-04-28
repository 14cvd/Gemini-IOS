//
//  ViewController.swift
//  My AI
//
//  Created by cavID on 24.04.24.
//

import UIKit
import SnapKit
import Combine

final class MainVC: UIViewController {
    
    private var cancelable = Set<AnyCancellable>()
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
        tv.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.id)
        tv.reloadData()
        return tv
    }()
    
    var chatService = ChatService()
    private var data : String = ""
    
    private lazy var loadingView = UIActivityIndicatorView(style: .medium)
    
    private lazy var textFieldRightView: TextFieldRightView = {
        let rightView = TextFieldRightView()
        rightView.onClick = { [weak self] in
            if let text = self?.inputTextField.text {
                self?.chatService.sendMessage(text)
                self?.data = text
                self?.loadingView.startAnimating()
                self?.inputTextField.text = ""
            }
        }
        return rightView
    }()
    
    private lazy var inputTextField : UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 30
        textField.layer.borderWidth = 1
        textField.rightViewMode = .always
        textFieldRightView.frame = CGRect(origin: .zero, size: .init(width: 40, height: textField.bounds.size.height))
        textField.rightView = textFieldRightView
        textField.setLeftPadding(16)
        return textField
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
        
        chatService.$messages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] messages in
                self?.tableView.reloadData()
                self?.loadingView.stopAnimating()
            }
            .store(in: &cancelable)
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension MainVC: UIConfig {
    
 
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
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        
        inputTextField.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.height.equalTo(56)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardSize.height
        let safeAreaBottomInset = view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: 0.3) {
//            self.view.frame.origin.y = -keyboardHeight + safeAreaBottomInset
            let offset = -keyboardHeight + safeAreaBottomInset - 16
            self.inputTextField.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(offset)
            }
            self.tableView.contentInset.bottom = offset
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        // Klavya gizlendiğinde view'i tekrar eski konumuna getir
        UIView.animate(withDuration: 0.3) {
            self.inputTextField.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-40)
            }
            self.tableView.contentInset.bottom = 0
        }
    }
}





extension MainVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatService.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.id, for: indexPath) as? ChatTableViewCell{
//            cell.chatMessage = chatService.messages[indexPath.row]
            cell.label.text = chatService.messages[indexPath.row].message
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
  
}



extension MainVC : UITextFieldDelegate {
    
    
}


final class TextFieldRightView: UIView {
    
    var onClick: (() -> ())?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .default)
        let iv = UIImageView(image: UIImage( systemName: "arrow.right", withConfiguration: config))
        iv.tintColor = .white
        let action = UIAction { [weak self]  _ in
            self?.onClick?()
        }
        button.setImage(iv.image, for: .normal)
        button.addAction(action, for: .touchUpInside)
        button.tintColor = UIColor(named: "main")
        return button
    }()
    
    private lazy var stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        stack.addArrangedSubview(button)
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }
}



extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

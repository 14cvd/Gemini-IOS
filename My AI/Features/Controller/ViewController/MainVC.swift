//
//  ViewController.swift
//  My AI
//
//  Created by cavID on 24.04.24.
//

import UIKit

final class MainVC: UIViewController {
   private let customNavigationController = UINavigationController()
   var isNavigationBarHidden = false

   private  let label : UILabel = {
       let label = UILabel()
        label.text = "Hello World!!!"
        return label
    }()
    
    private lazy var scrollView : UIScrollView = {
       let sv = UIScrollView()
//        sv.backgroundColor = .red
        
        
               // UIScrollView içindeki container view oluşturun
               let containerView = UIView()
               sv.addSubview(containerView)
               
               // Container view'a SnapKit ile constraints ekleme
               containerView.snp.makeConstraints { make in
                   make.edges.width.equalToSuperview() // Container view'ı scrollview'a bağla ve genişliğini ayarla
               }
               
               // UILabel'ları container view içine ekleyin
               var previousLabel: UILabel?
               for i in 1...100 {
                   let label = UILabel()
                   label.text = "Soru \(i): Bu bir örnek soru"
                   label.numberOfLines = 0 // Birden fazla satırı desteklemek için
                   label.textColor = .black
                   label.textAlignment = .left
                   label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                   containerView.addSubview(label)
                   
                   // UILabel'ların SnapKit ile constraints ekleme
                   label.snp.makeConstraints { make in
                       make.top.equalTo(previousLabel?.snp.bottom ?? containerView.snp.top).offset(20) // Önceki label'dan veya container view'dan 20 birim aşağıda başla
                       make.left.equalTo(containerView.snp.left).offset(20) // Sol kenara 20 birim uzaklıkta
                       make.right.equalTo(containerView.snp.right).offset(-20) // Sağ kenara 20 birim uzaklıkta
                   }
                   
                   previousLabel = label
               }
               
               // Son UILabel'in alt kenarını containerView'a bağlayın ve scrollview'ın içeriğini belirleyin
               previousLabel?.snp.makeConstraints { make in
                   make.bottom.equalTo(containerView.snp.bottom).offset(-20) // En son label'ın alt kenarı container view'ın alt kenarına 20 birim uzaklıkta olmalı
               }
               
               sv.contentSize = CGSize(width: view.frame.width, height: containerView.frame.height)
        sv.delegate = self
        
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        config()
        configNavigationBar()
        constraintConfig()
        
    }


}


extension MainVC : UIConfig{
    
 
    func config() {
        view.addSubview(scrollView)
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
//        label.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension MainVC : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
                
                // Scroll yönüne göre navigation bar'ın görünüp görünmediğini ayarlayın
                if offsetY > 50 && !isNavigationBarHidden {
                    isNavigationBarHidden = true
                    navigationController?.setNavigationBarHidden(true, animated: true)
                } else if offsetY < 50 && isNavigationBarHidden {
                    isNavigationBarHidden = false
                    navigationController?.setNavigationBarHidden(false, animated: true)
                }
    }
}


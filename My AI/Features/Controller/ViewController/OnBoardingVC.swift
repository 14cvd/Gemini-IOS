//
//  OnBoardingVC.swift
//  My AI
//
//  Created by cavID on 24.04.24.
//

import UIKit
import SnapKit

final class OnBoardingVC: UIViewController {
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "You AI Assistant"
        label.font = UIFont(name: "Nunito-Bold", size: 23)
        label.textColor = UIColor(named: "main")

        return label
        
    }()
    
    
    
    private let subTitle : UILabel = {
       let label = UILabel()
        label.text = "Using this software,you can ask you\nquestions and receive articles using\nartificial intelligence assistant"
        label.font = UIFont(name: "Nunito", size: 15)
        label.textColor = UIColor(named: "textColor")
        return label
    }()
    
    private let image : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "bigRobot")
        
        return iv
        
        
    }()
//    
    private let icon : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "arrow.right")
        iv.tintColor = .white
        return iv
    }()
//
    private lazy var button: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .default)
        let iv = UIImageView(image: UIImage( systemName: "arrow.right", withConfiguration: config))
//        let titleLabels = UILabel()
//        titleLabels.text = "Continue"
//        titleLabels.font = UIFont(name: "Nunito-Bold", size: 19)
//        button.titleLabel = titleLabel
//        
        
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 19)
        button.setTitleColor(.white, for: .normal)
        

//        button.setImage(image, for: .normal)
        button.tintColor = .white
        iv.tintColor = .white
        
        let action = UIAction { _ in
            self.navigationController?.pushViewController(MainVC(), animated: true)
        }
        
        button.addSubview(iv)
        iv.snp.makeConstraints { make in
               make.centerY.equalToSuperview()
               make.right.equalToSuperview().inset(20)
               make.height.width.equalTo(24)
           }
        button.addAction(action, for: .touchUpInside)
        button.backgroundColor = UIColor(named: "main")
        button.layer.cornerRadius = 30
        
        
        
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        config()
        constraintConfig()

        // Do any additional setup after loading the view.
    }
}

extension OnBoardingVC : UIConfig{
    func config(){
        view.addSubview(titleLabel)
        view.addSubview(subTitle)
        view.addSubview(image)
        view.addSubview(button)
    }
    
    func constraintConfig(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(additionalSafeAreaInsets).offset(100)
            make.centerX.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.centerX.equalToSuperview()        }
        
        
        image.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(85)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(333)
            make.top.equalTo(image.snp.bottom).offset(130)
            make.centerX.equalToSuperview()
            
        }
       
    }
    
    
}

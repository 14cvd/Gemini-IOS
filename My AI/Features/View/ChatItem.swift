//
//  ChatItem.swift
//  My AI
//
//  Created by cavID on 25.04.24.
//

import UIKit

class ChatBubbleView: UIView {
    let direction: ChatBubbleShapeView.Direction
    let content: UIView
    
    init(direction: ChatBubbleShapeView.Direction, content: UIView) {
        self.direction = direction
        self.content = content
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        if direction == .right {
            let spacer = UIView()
            spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
            stackView.addArrangedSubview(spacer)
        }
        
        stackView.addArrangedSubview(content)
        
        if direction == .left {
            let spacer = UIView()
            spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
            stackView.addArrangedSubview(spacer)
        }
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: direction == .left ? 20 : 50),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: direction == .right ? -20 : -50)
        ])
        
        // Set corner radius and background color based on direction
        let bubbleShape = ChatBubbleShapeView(direction: direction)
        layer.mask = bubbleShape.layer
        
        let bgColor: UIColor = direction == .left ? .green : .blue
        content.backgroundColor = bgColor
    }
}

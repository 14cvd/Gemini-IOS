//
//  ChatItemBorder.swift
//  My AI
//
//  Created by cavID on 25.04.24.
//


import UIKit

class ChatBubbleShapeView: UIView {
    enum Direction {
        case left
        case right
    }
    
    let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path: UIBezierPath
        
        switch direction {
        case .left:
            path = leftBubblePath(in: rect)
        case .right:
            path = rightBubblePath(in: rect)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    private func leftBubblePath(in rect: CGRect) -> UIBezierPath {
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 25, y: height))
        // Diğer noktaları ekle...
        return path
    }
    
    private func rightBubblePath(in rect: CGRect) -> UIBezierPath {
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 25, y: height))
        // Diğer noktaları ekle...
        return path
    }
}

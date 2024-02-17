//
//  ViewController.swift
//  InertialSquare
//
//  Created by Станислав Соколов on 16.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var square: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(square)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
         moveSquare(at: point)
    }
    
    private func moveSquare(at point: CGPoint) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi/4
        
        
        let springAnimation = CASpringAnimation()
        springAnimation.keyPath = "position"
        springAnimation.damping = 50
        springAnimation.initialVelocity = 0.5
        springAnimation.mass = 10
        springAnimation.stiffness = 1500
        springAnimation.duration = springAnimation.settlingDuration
        springAnimation.fromValue = square.center
        springAnimation.toValue = point

        
        let rotateAndSpring = CAAnimationGroup()
        rotateAndSpring.animations = [springAnimation, animation]
        rotateAndSpring.duration = 0.8
        rotateAndSpring.timingFunction = .init(name: .easeIn)
        rotateAndSpring.fillMode = .both
        
        square.layer.add(rotateAndSpring, forKey: "Basic")
        square.layer.position = point
    }
    
    
}



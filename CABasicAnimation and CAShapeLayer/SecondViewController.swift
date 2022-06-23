//
//  SecondViewController.swift
//  CABasicAnimation and CAShapeLayer
//
//  Created by Nodirbek on 22/06/22.
//

import UIKit
import Lottie

class SecondViewController: UIViewController {
    
    let animationView = AnimationView()
    let animationView1 = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        setupAnimation1()
        view.backgroundColor = .white
    }

    func setupAnimation(){
        animationView.animation = Animation.named("109887-bike")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.frame = CGRect(x: view.frame.width/2, y: view.frame.height/2 + 250, width: 100, height: 100)
        view.addSubview(animationView)
    }
    
    func setupAnimation1(){
        animationView1.animation = Animation.named("110304-popeye")
        animationView1.contentMode = .scaleAspectFit
        animationView1.loopMode = .loop
        animationView1.play()
        animationView1.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView1.center = view.center
        view.addSubview(animationView1)
    }
}

// Lotie website

//
//  ViewController.swift
//  CABasicAnimation and CAShapeLayer
//
//  Created by Nodirbek on 21/06/22.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth   = 20
            shapeLayer.lineCap     = .round
            shapeLayer.fillColor   = nil
            shapeLayer.strokeEnd   = 1
            shapeLayer.strokeColor = UIColor.blue.cgColor
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.lineWidth   = 20
            overShapeLayer.lineCap     = .round
            overShapeLayer.fillColor   = nil
            overShapeLayer.strokeEnd   = 0
            overShapeLayer.strokeColor = UIColor.green.cgColor
        }
    }
    
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            // w if -number left , h if -number top, otherwise bottom and right if 0 from everyside
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 10
            button.layer.cornerRadius = 10
        }
    }
    
    
    var figureOne: CAShapeLayer!
    var figureTwo: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createShapes()
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
        
        config(shapeLayer)
        config(overShapeLayer)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapGest(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    func config(_ shapeLayer: CAShapeLayer){
        let path = UIBezierPath()
        shapeLayer.frame = view.bounds
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 150, y: view.frame.height/2))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 150, y: view.frame.height/2))
        shapeLayer.path = path.cgPath
    }
    
    @IBAction func pressed(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 4
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        overShapeLayer.add(animation, forKey: nil)
//        overShapeLayer.strokeEnd += 0.1
//        if overShapeLayer.strokeEnd > 1 {
//            let vc = ThirdViewController()
//            navigationController?.pushViewController(vc, animated: true)
//            overShapeLayer.strokeEnd = 0
//        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let vc = ThirdViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapGest(_ sender: UITapGestureRecognizer){
        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        pathAnimation.fromValue = figureOne.path
        figureOne.path = figureTwo.path
        pathAnimation.toValue = figureTwo.path
        //pathAnimation.duration = 1
        figureOne.add(pathAnimation, forKey: nil)
        
        let fillColorAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        fillColorAnimation.fromValue = figureOne.fillColor
        figureOne.fillColor = figureTwo.fillColor
        fillColorAnimation.toValue = figureOne.fillColor
        figureOne.add(fillColorAnimation, forKey: nil)
        
        let rotateAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        rotateAnimation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 4 * Float.pi
        rotateAnimation.duration = 3
        
        let group = CAAnimationGroup()
        group.duration = 1
        group.animations = [pathAnimation, fillColorAnimation, rotateAnimation]
        figureOne.add(group, forKey: nil)
    }
    
    func createShapes(){
        figureOne = CAShapeLayer()
        let rect = CGRect(
            x: view.frame.width/2 - 50,
            y: view.frame.height/2 - 50,
            width: 100,
            height: 100)
        
        figureOne.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
        figureOne.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(figureOne)
        
        figureOne.frame = view.bounds
        
        let rectTwo = CGRect(
            x: view.frame.width/2 - 75,
            y: view.frame.height/2 - 75,
            width: 150,
            height: 150)
        figureTwo = CAShapeLayer()
        figureTwo.path = UIBezierPath(ovalIn: rectTwo).cgPath
        figureTwo.fillColor = UIColor.green.cgColor
//        view.layer.addSublayer(figureTwo)
    }

    
}


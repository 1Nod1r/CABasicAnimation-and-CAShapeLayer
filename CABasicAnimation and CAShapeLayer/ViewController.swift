//
//  ViewController.swift
//  CABasicAnimation and CAShapeLayer
//
//  Created by Nodirbek on 21/06/22.
//

import UIKit

class ViewController: UIViewController {

    var figureOne: CAShapeLayer!
    var figureTwo: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createShapes()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapGest(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @IBAction func pressed(){
        let vc = SecondViewController()
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


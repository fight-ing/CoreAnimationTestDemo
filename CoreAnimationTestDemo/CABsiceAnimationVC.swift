//
//  CABsiceAnimationVC.swift
//  CoreAnimationTestDemo
//
//  Created by fei on 15/12/11.
//  Copyright © 2015年 self. All rights reserved.
//

import UIKit

class CABsiceAnimationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //缩放动画
        createScaleLayer()
        
        //移动动画
        createMoveAnimateion()
        
        //翻转动画
        createRotationAnimation()
        
        //组合动画
        createGroupAnimation()
    }
    
    /*
    CAAnimation可分为四种：
    1.CABasicAnimation
    通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
    2.CAKeyframeAnimation
    Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动
    3.CAAnimationGroup
    Group也就是组合的意思，就是把对这个Layer的所有动画都组合起来。PS：一个layer设定了很多动画，他们都会同时执行，如何按顺序执行我到时候再讲。
    4.CATransition
    这个就是苹果帮开发者封装好的一些动画
    */
    

    
    func createScaleLayer() {
        
        //
        let scaleLayer:CALayer = CALayer()
        scaleLayer.backgroundColor = UIColor.blueColor().CGColor
        scaleLayer.frame = CGRectMake(50, 50, 40, 40)
        scaleLayer.cornerRadius = 20
        self.view.layer.addSublayer(scaleLayer)
        
        //
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.5
        scaleAnimation.autoreverses = true
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.repeatCount = MAXFLOAT
        scaleAnimation.duration = 0.8
        
        //开始
        scaleLayer.addAnimation(scaleAnimation, forKey: "scaleAnimation")
    }
    
    func createMoveAnimateion() {
        let moveLayer:CALayer = CALayer()
        moveLayer.backgroundColor = UIColor.greenColor().CGColor
        moveLayer.frame = CGRectMake(20, 120, 50, 50)
        moveLayer.cornerRadius = 5
        self.view.layer.addSublayer(moveLayer)
        
        let moveAnimation:CABasicAnimation = CABasicAnimation(keyPath: "position")
        moveAnimation.fromValue = NSValue(CGPoint: moveLayer.position)
        moveAnimation.toValue = NSValue(CGPoint: CGPointMake(280, moveLayer.position.y))
        moveAnimation.duration = 2
        moveAnimation.autoreverses = true
        moveAnimation.repeatCount = MAXFLOAT
        
        moveLayer.addAnimation(moveAnimation, forKey: "moveAnimation")
        
    }
    
    func createRotationAnimation() {
        let rotateLayer:CALayer = CALayer()
        rotateLayer.backgroundColor = UIColor.purpleColor().CGColor
        rotateLayer.frame = CGRectMake(20, 200, 50, 50)
        rotateLayer.cornerRadius = 5
        self.view.layer.addSublayer(rotateLayer)
        
        let rotateAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 6 * M_PI
        rotateAnimation.repeatCount = MAXFLOAT
        rotateAnimation.duration = 2
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.autoreverses = true
        
        rotateLayer.addAnimation(rotateAnimation, forKey: "rotationAnimation")
    }
    
    func createGroupAnimation() {
        let gLayer:CALayer = CALayer()
        gLayer.frame = CGRectMake(10, 280, 50, 50)
        gLayer.cornerRadius = 5
        gLayer.backgroundColor = UIColor.brownColor().CGColor
        self.view.layer.addSublayer(gLayer)
        
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 2
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = MAXFLOAT
        scaleAnimation.duration = 0.8
        
        
        let moveAnimation:CABasicAnimation = CABasicAnimation(keyPath: "position")
        moveAnimation.fromValue = NSValue(CGPoint:gLayer.position)
        moveAnimation.toValue = NSValue(CGPoint: CGPoint(x: UIScreen.mainScreen().bounds.size.width-60, y: gLayer.position.y))
        
        moveAnimation.autoreverses = true
        moveAnimation.repeatCount = MAXFLOAT
        moveAnimation.duration = 2
        
        let rotateAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 6.0 * M_PI
        rotateAnimation.autoreverses = true
        rotateAnimation.repeatCount = MAXFLOAT
        rotateAnimation.duration = 2
        
        let groupAnimation:CAAnimationGroup = CAAnimationGroup()
        groupAnimation.duration = 2
        groupAnimation.autoreverses = true
        groupAnimation.animations = [moveAnimation,scaleAnimation,rotateAnimation]
        groupAnimation.repeatCount = MAXFLOAT
        
        gLayer.addAnimation(groupAnimation, forKey: "groupAnnimation")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

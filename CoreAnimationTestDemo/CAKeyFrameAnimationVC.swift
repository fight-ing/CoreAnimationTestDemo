//
//  CAKeyFrameAnimationVC.swift
//  CoreAnimationTestDemo
//
//  Created by fei on 15/12/11.
//  Copyright © 2015年 self. All rights reserved.
//

import UIKit

class CAKeyFrameAnimationVC: UIViewController {
    
    let rectLayer:CALayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        createRectLayer()
    }
    
    /*
    CABasicAnimation算是CAKeyFrameAnimation的特殊情况，即不考虑中间变换过程，只考虑起始点与目标点就可以了。而CAKeyFrameAnimation则更复杂一些，允许我们在起点与终点间自定义更多内容来达到我们的实际应用需求！
    */
    
    func createRectLayer() {
        
        rectLayer.frame = CGRectMake(20, 50, 40, 40)
        rectLayer.cornerRadius = 20 //圆
        rectLayer.backgroundColor = UIColor.purpleColor().CGColor
        self.view.layer.addSublayer(rectLayer)
        
        let rectRunAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        
        //设定关键帧的位置 一个循环 必须包含其实与终止位置 所以矩形则是a->b->c->d->a
        rectRunAnimation.values = [NSValue(CGPoint: rectLayer.frame.origin),NSValue(CGPoint: CGPointMake(300, rectLayer.frame.origin.y)),NSValue(CGPoint: CGPointMake(300, rectLayer.frame.origin.y+100)),NSValue(CGPoint: CGPointMake(20, rectLayer.frame.origin.y+100)),NSValue(CGPoint: rectLayer.frame.origin)]
        let label:UILabel = UILabel(frame: CGRect(x: 20, y: 50, width: 280, height: 100))
        label.text = ""
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.redColor().CGColor
        self.view.addSubview(label)
        /*
        1）values属性
        values属性指明整个动画过程中的关键帧点，例如上例中的A-E就是通过values指定的。需要注意的是，起点必须作为values的第一个值。
        （2）path属性
        作用与values属性一样，同样是用于指定整个动画所经过的路径的。需要注意的是，values与path是互斥的，当values与path同时指定时，path会覆盖values，即values属性将被忽略。
        */
        let path:CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, rectLayer.position.x-20, rectLayer.position.y-20)
        CGPathAddLineToPoint(path, nil, 300, rectLayer.frame.origin.y)
        CGPathAddLineToPoint(path, nil, 300, rectLayer.frame.origin.y+300)
        CGPathAddLineToPoint(path, nil, 20, rectLayer.frame.origin.y+300)
        CGPathAddLineToPoint(path, nil, 20, rectLayer.frame.origin.y)
        rectRunAnimation.path = path
        let label1:UILabel = UILabel(frame: CGRect(x: 20, y: 50, width: 280, height: 300))
        label1.text = ""
        label1.layer.borderWidth = 1.5
        label1.layer.borderColor = UIColor.greenColor().CGColor
        self.view.addSubview(label1)
        
        //设置每个关键帧的时长，不设置则默认时间 duration/(values.count - 1)
        /*
        keyTimes 属性 该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(5-1)，即每条子路径的duration相等，都为duration的1\4。当然，我们也可以传个数组让物体快慢结合。
        */
        rectRunAnimation.keyTimes = [0,0.6,0.7,0.8,1]
        
        /*
        timeFunctions 属性
        这个属性用以指定时间函数，类似于运动的加速度，有以下几种类型。上例子的AB段就是用了淡入淡出效果。记住，这是一个数组，你有几个子路径就应该传入几个元素
        1 kCAMediaTimingFunctionLinear//线性
        2 kCAMediaTimingFunctionEaseIn//淡入
        3 kCAMediaTimingFunctionEaseOut//淡出
        4 kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
        5 kCAMediaTimingFunctionDefault//默认
        */
        rectRunAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
        rectRunAnimation.repeatCount = 2000
        rectRunAnimation.autoreverses = false
        
        /*
        calculationMode 属性
        该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似
        kCAAnimationLinear//线性，默认
        kCAAnimationDiscrete//离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
        kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
        kCAAnimationCubic//平均，同上
        kCAAnimationCubicPaced//平均，同上
        */
        rectRunAnimation.calculationMode = kCAAnimationLinear
        rectRunAnimation.duration = 5
        
        rectLayer.addAnimation(rectRunAnimation, forKey: "rectRunAnimation")
        
    }

    @IBAction func pauseButtonClicked(sender: UIButton) {
        if sender.selected { //选中状态 重新开始
            let pausedTime = rectLayer.timeOffset
            rectLayer.speed = 1
            rectLayer.timeOffset = 0
            rectLayer.beginTime = 0
            let timeSincePause = rectLayer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
            rectLayer.beginTime = timeSincePause
            
        } else { //暂停
            let pausedTime = rectLayer.convertTime(CACurrentMediaTime(), fromLayer: nil)
            rectLayer.speed = 0
            rectLayer.timeOffset = pausedTime
        }
        
        sender.selected = !sender.selected
        
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

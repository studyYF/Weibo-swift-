//
//  PopoverViewAnimation.swift
//  Weibo
//
//  Created by YF on 16/10/2.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class PopoverViewAnimation: NSObject {
    var isPresent : Bool = false
    var presentFrame = CGRectZero
    //MARK: - 定义闭包,返回当前titleButton的状态
    var callback : ((isPresented : Bool) -> ())?//不能判断闭包是否为空,所以定义成可选类型
    //重写类的init的方法,如果不调用默认的init()方法,那么init()方法就会被覆盖
    init(callback : (isPresented : Bool) -> ()) {
        self.callback = callback
    }
    //重写该方法,才不会被覆盖
    override init () {
        
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension PopoverViewAnimation : UIViewControllerTransitioningDelegate {
    //自定义转场
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let presentViewController = WBPresentationController(presentedViewController: presented, presentingViewController: presenting)
        presentViewController.presentFrame = presentFrame
        return presentViewController
    }
    //自定义弹出动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        callback!(isPresented : isPresent)
        return self
    }
    //自定义消失动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        callback!(isPresented : isPresent)
        return self
    }
    
}

//MARK: - UIViewControllerAnimatedTransitioning
extension PopoverViewAnimation : UIViewControllerAnimatedTransitioning {
    ///动画执行的时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    ///自定义动画,可以获取转场的上下文,获取弹出的view和消失的view
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        isPresent ? animationForPresentedView(transitionContext) : animationForDismissView(transitionContext)
    }
    //自定义弹出动画
    private func animationForPresentedView (transitionContext: UIViewControllerContextTransitioning) {
        //获取弹出的view
        let presentView = transitionContext .viewForKey(UITransitionContextToViewKey)!
        //将弹出的view添加到containView
        let containedView = transitionContext.containerView()
        containedView?.addSubview(presentView)
        //执行动画
        presentView.transform = CGAffineTransformMakeScale(1.0, 0.0)
        presentView.layer.anchorPoint = CGPointMake(0.5, 0)
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            presentView.transform = CGAffineTransformIdentity
            }) { (isFinished : Bool) -> Void in
                ///告诉转场上下文,动画已经完成
                transitionContext.completeTransition(true)
        }
    }
    ///自定义消失动画
    private func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) {
        //获取弹出的view
        let dismissView = transitionContext .viewForKey(UITransitionContextFromViewKey)
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            dismissView?.transform = CGAffineTransformMakeScale(1.0, 2.0)
            }) { (isFinished : Bool) -> Void in
                dismissView?.removeFromSuperview()
                ///告诉转场上下文,动画已经完成
                transitionContext.completeTransition(true)
        }
    }
}
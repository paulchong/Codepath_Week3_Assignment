//
//  ViewController.swift
//  Week2Assignment_Mailbox_v2
//
//  Created by Paul Chong on 2/19/15.
//  Copyright (c) 2015 Paul Chong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Level2View: UIView!
    var level2StartingX: CGFloat!
    var level2StartingXPanBegan: CGFloat!
    var finalLevel2PositionX: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        level2StartingX = Level2View.frame.origin.x
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func didPanLevel2(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)

        println("Velocity: \(velocity)")
        println("Location: \(location)")
        println("Translation: \(translation)")
        if (sender.state == UIGestureRecognizerState.Began){
            level2StartingXPanBegan = Level2View.frame.origin.x
        } else if (sender.state == UIGestureRecognizerState.Changed){
            finalLevel2PositionX = level2StartingXPanBegan + translation.x
//            if (finalLevel2PositionX < level2StartingX){
//                finalLevel2PositionX = level2StartingXPanBegan + translation.x
//            }
            Level2View.frame.origin.x = finalLevel2PositionX
        } else if sender.state == UIGestureRecognizerState.Ended {
            if (location.x > 160){
                finalLevel2PositionX = 320
//                trayRotation = CGFloat(-180.0 * M_PI/180)
            } else {
                finalLevel2PositionX = level2StartingX
//                trayRotation = CGFloat(0 * M_PI/180)
            }
            UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 30, options: nil, animations: { () -> Void in
                self.Level2View.frame.origin.x = self.finalLevel2PositionX
//                self.trayArrow.transform = CGAffineTransformMakeRotation(self.trayRotation)
                }, completion: nil)
            
        }
        
    }

}


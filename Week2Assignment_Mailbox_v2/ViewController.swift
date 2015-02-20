//
//  ViewController.swift
//  Week2Assignment_Mailbox_v2
//
//  Created by Paul Chong on 2/19/15.
//  Copyright (c) 2015 Paul Chong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Level0View: UIView!
    @IBOutlet weak var Level1View: UIView!
    @IBOutlet weak var Level2View: UIView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var archiveIconImage: UIImageView!
    @IBOutlet weak var deleteIconImage: UIImageView!
    
    var level2StartingX: CGFloat!
    var level2StartingXPanBegan: CGFloat!
    var finalLevel2PositionX: CGFloat!
    var messageOriginalX: CGFloat!
    
    var navViewStartingX: CGFloat!
    var navViewStartingPanBegan: CGFloat!
    var finalNavViewPositionX: CGFloat!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        level2StartingX = Level2View.frame.origin.x
        navViewStartingX = Level0View.frame.origin.x
        rescheduleImage.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func didPanLevel2(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var archiveX = archiveIconImage.center.x
        var laterX = laterIconImage.center.x
        deleteIconImage.hidden = true

        println("Velocity: \(velocity)")
        println("Location: \(location)")
        println("Translation: \(translation)")
        if (sender.state == UIGestureRecognizerState.Began){
            level2StartingXPanBegan = Level2View.frame.origin.x
        } else if (sender.state == UIGestureRecognizerState.Changed){
            finalLevel2PositionX = level2StartingXPanBegan + translation.x

            switch translation.x {
            case -320...(-60):
                Level1View.backgroundColor = UIColor.yellowColor()
                archiveIconImage.hidden = true
                if (translation.x > -100) {
                    laterIconImage.center.x = laterX
                } else {
                    laterIconImage.center.x = translation.x + 360
                }


            case 61...260:
                Level1View.backgroundColor = UIColor.greenColor()
                laterIconImage.hidden = true
                if (translation.x < 70) {
                    archiveIconImage.center.x = archiveX
                } else {
                    archiveIconImage.center.x = translation.x - 20
                }

            case 260...320:
                Level1View.backgroundColor = UIColor.redColor()
                laterIconImage.hidden = true
                archiveIconImage.hidden = true
                deleteIconImage.hidden = false
                
            default:
                Level1View.backgroundColor = UIColor.grayColor()
            }
            
            Level2View.frame.origin.x = finalLevel2PositionX
        } else if sender.state == UIGestureRecognizerState.Ended {
            if (translation.x > 140){
                finalLevel2PositionX = 320
            
            } else if (translation.x < -140){
                finalLevel2PositionX = -320
                rescheduleImage.hidden = false
            } else {
                finalLevel2PositionX = level2StartingX

            }
            UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 30, options: nil, animations: { () -> Void in
                self.Level2View.frame.origin.x = self.finalLevel2PositionX
                }, completion: nil)
        }
    }

    @IBAction func rescheduleTapGesture(sender: UITapGestureRecognizer) {
        rescheduleImage.hidden = true
        Level2View.center.x = level2StartingX + 160
        println(Level2View.center.x)
    }
    
    @IBAction func navPanGesture(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var location = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        
        println("Velocity: \(velocity)")
        println("Location: \(location)")
        println("Translation: \(translation)")
        
        if (sender.state == UIGestureRecognizerState.Began) {
            navViewStartingPanBegan = Level0View.frame.origin.x
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            finalNavViewPositionX = navViewStartingPanBegan + translation.x
            
            if (finalNavViewPositionX < navViewStartingX) {
                finalNavViewPositionX = navViewStartingPanBegan + translation.x
            }
            
            Level0View.frame.origin.x = finalNavViewPositionX
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            if (translation.x > 140) {
                finalNavViewPositionX = 290
            } else {
                finalNavViewPositionX = navViewStartingX
            }
            UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 30, options: nil, animations: { () -> Void in
                self.Level0View.frame.origin.x = self.finalNavViewPositionX
                }, completion: nil)
        }
    }
}


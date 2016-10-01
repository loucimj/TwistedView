//
//  ViewController.swift
//  TwistedView
//
//  Created by Javier Loucim on 9/29/16.
//  Copyright © 2016 Javier Loucim. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var photos = Array<PolaroidView>()

    var disappear = true

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...10 {
            let photo = PolaroidView.instanceFromNib()
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            photo.addGestureRecognizer(gestureRecognizer)
            photos.append(photo)
            setupView(photo)
        }
        
//        let photo = UIImageView(image: UIImage(named: "image"))
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidLayoutSubviews() {
//        setupView()
    }
    
    @IBAction func showAction(sender: AnyObject) {
        
        for i in 0...photos.count-1 {
            if disappear {
                photos[i].disappearAndDisable()
            } else {
                photos[i].popAndEnable()
            }
        }
        disappear = !disappear
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setupView(photo: PolaroidView) {
        photo.contentMode = .ScaleAspectFit
        
        let widthConstraint = NSLayoutConstraint(item: photo, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 350)
        let heightConstraint = NSLayoutConstraint(item: photo, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 350)
        
        let centerYConstraint = NSLayoutConstraint(item: photo, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: photo, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        photo.addConstraints([widthConstraint,heightConstraint])
        
        let degrees:CGFloat = (randomBool() ? 1: -1) * CGFloat(arc4random_uniform(12))
        photo.transform = CGAffineTransformMakeRotation(degrees * CGFloat(M_PI)/180);
        
        photo.alpha = 0
        self.containerView.addSubview(photo)
        NSLayoutConstraint.activateConstraints([centerXConstraint, centerYConstraint])
        
        photo.extendAndEnable()
        
    }
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    @IBAction func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .Began || gestureRecognizer.state == .Changed {
            
            let translation = gestureRecognizer.translationInView(self.view)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPointMake(gestureRecognizer.view!.center.x + translation.x, gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPointMake(0,0), inView: self.view)
            
            if gestureRecognizer.locationInView(self.view).x >= self.view.frame.width * 0.75 {
                UIView.animateWithDuration(1, animations: {
                    var destinyPoint = gestureRecognizer.locationInView(self.view)
                    if destinyPoint.y > self.view.center.y {
                        destinyPoint.y += 250
                    } else {
                        destinyPoint.y -= 250
                    }
                    destinyPoint.x = 800
                    gestureRecognizer.view?.center = destinyPoint
                })
                
            }
            if gestureRecognizer.locationInView(self.view).x <= self.view.frame.width * 0.25 {
                UIView.animateWithDuration(1, animations: {
                    var destinyPoint = gestureRecognizer.locationInView(self.view)
                    if destinyPoint.y > self.view.center.y {
                        destinyPoint.y += 250
                    } else {
                        destinyPoint.y -= 150
                    }
                    destinyPoint.x = -800
                    gestureRecognizer.view?.center = destinyPoint
                })
                
            }
        }
    }
}


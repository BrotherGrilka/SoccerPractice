//
//  Player.swift
//  EarlesSoccerField
//
//  Created by Duncan Davidson on 12/4/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

import UIKit

protocol CloningProtocol {
    func clone(player: Player)
}

protocol RefereeingProtocol {
    func sendOff(player: Player)
}

class Player: UIViewController, NSCopying {
    let playerSize:CGRect = CGRectMake(0, 0, 40, 60);
    var playerImage:UIImageView = UIImageView();
    let dragg: UIPanGestureRecognizer = UIPanGestureRecognizer();
    let doubleTapp: UITapGestureRecognizer = UITapGestureRecognizer();
    var cloneDelegate:CloningProtocol?
    var refereeDelegate:RefereeingProtocol?

    required override init() {
        super.init();
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerImage.frame = playerSize;
        view.frame = playerSize;
        
        self.view.addSubview(playerImage);
        
        dragg.addTarget(self, action:"drag:");
        doubleTapp.addTarget(self, action: "doubleTap:");
//        doubleTapp.numberOfTapsRequired = 2;
        
        self.view.addGestureRecognizer(dragg);
        self.view.addGestureRecognizer(doubleTapp);
    }

    func positionPlayer(x: CGFloat, y: CGFloat) {
        view.frame = CGRectMake(x, y, view.frame.width, view.frame.height)
    }

    func drag(recognizer: UIPanGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizerState.Began) {
            cloneDelegate?.clone(self);
        }
 
        let translation = recognizer.translationInView(self.view)
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x, y:recognizer.view!.center.y + translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    func doubleTap(recognizer: UITapGestureRecognizer) {
        refereeDelegate?.sendOff(self);
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return self.dynamicType();
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

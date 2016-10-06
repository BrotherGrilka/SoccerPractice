//
//  Player.swift
//  EarlesSoccerField
//
//  Created by Duncan Davidson on 12/4/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

import UIKit

protocol CloningDelegate {
    func clone(_ player: Player)
}

protocol RefereeingDelegate {
    func sendOff(_ player: Player)
}

class Player: UIViewController, NSCopying {
    let playerSize:CGRect = CGRect(x: 0, y: 0, width: 40, height: 60);
    var playerImage:UIImageView = UIImageView();
    let dragg: UIPanGestureRecognizer = UIPanGestureRecognizer();
    let doubleTapp: UITapGestureRecognizer = UITapGestureRecognizer();
    var cloneDelegate:CloningDelegate?
    var refereeDelegate:RefereeingDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerImage.frame = playerSize;
        view.frame = playerSize;
        
        self.view.addSubview(playerImage);
        
        dragg.addTarget(self, action:#selector(Player.drag(_:)));
        doubleTapp.addTarget(self, action: #selector(Player.doubleTap(_:)));
//        doubleTapp.numberOfTapsRequired = 2;
        
        self.view.addGestureRecognizer(dragg);
        self.view.addGestureRecognizer(doubleTapp);
    }

    func positionPlayer(_ x: CGFloat, y: CGFloat) {
        view.frame = CGRect(x: x, y: y, width: view.frame.width, height: view.frame.height)
    }

    func drag(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.began
            {cloneDelegate?.clone(self);}
 
        let translation = recognizer.translation(in: self.view)
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x, y:recognizer.view!.center.y + translation.y)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended
            {Manager.ofFootballers.updateFootballer(self)}
    }
    
    func doubleTap(_ recognizer: UITapGestureRecognizer) {
        refereeDelegate?.sendOff(self);
    }
    
    func copy(with zone: NSZone?) -> Any {
        return type(of: self).init();
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

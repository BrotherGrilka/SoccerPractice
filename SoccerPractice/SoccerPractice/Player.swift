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
    enum Uniform {
        case BlueSolid
        case IndigoChevron
        case OrangeSolid
        case PurpleStripe
        case RedSolid
        case RedStripe
    }
    
    let playerSize:CGRect = CGRect(x: 0, y: 0, width: 40, height: 60)
    var playerImage:UIImageView = UIImageView()
    let dragg: UIPanGestureRecognizer = UIPanGestureRecognizer()
    let tapp: UITapGestureRecognizer = UITapGestureRecognizer()
    var cloneDelegate:CloningDelegate?
    var refereeDelegate:RefereeingDelegate?
    
    let uniform:Uniform

    required init?(coder aDecoder: NSCoder) {
        self.uniform = .BlueSolid
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        self.uniform = .RedSolid
        super.init(nibName: nil, bundle: nil)
    }
    
    init(uniform: Uniform) {
        self.uniform = uniform
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerImage.frame = playerSize;
        view.frame = playerSize;
        
        self.view.addSubview(playerImage);
        
        dragg.addTarget(self, action:#selector(Player.drag(_:)));
        tapp.addTarget(self, action: #selector(Player.tap(_:)));
        
        self.view.addGestureRecognizer(dragg);
        self.view.addGestureRecognizer(tapp);
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
    
    func tap(_ recognizer: UITapGestureRecognizer) {
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

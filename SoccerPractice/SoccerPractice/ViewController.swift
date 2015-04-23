//
//  ViewController.swift
//  EarlesSoccerField
//
//  Created by Duncan Davidson on 12/4/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CloningProtocol, RefereeingProtocol {
    @IBOutlet var field: UIImageView!
    @IBOutlet var eraser: UIButton!
    @IBOutlet var darkSlateGray: UIButton!
    @IBOutlet var fireBrick: UIButton!
    @IBOutlet var navy: UIButton!

    var bench = [Player]();
    var benchTag = 0;
    
    let blueSolid: BlueSolid = BlueSolid();
    let indigoChevron: IndigoChevron = IndigoChevron();
    let orangeSolid: OrangeSolid = OrangeSolid();
    let purpleStripe: PurpleStripe = PurpleStripe();
    let redSolid: RedSolid = RedSolid();
    let redStripe: RedStripe = RedStripe();
    
    let chalkboard: Chalkboard = Chalkboard();
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Manager.ofFootballers.takeTheField()
        
        view.addSubview(chalkboard.view);
        self.addChildViewController(chalkboard);
        chalkboard.didMoveToParentViewController(self);
        
        blueSolid.positionPlayer(970, y: 50);
        blueSolid.cloneDelegate = self;
        self.addChildViewController(blueSolid);
        blueSolid.didMoveToParentViewController(self);
        view.addSubview(blueSolid.view);
        blueSolid.view.tag = benchTag++;
        bench.append(blueSolid);
        
        redStripe.positionPlayer(970, y: 130);
        redStripe.cloneDelegate = self;
        self.addChildViewController(redStripe);
        redStripe.didMoveToParentViewController(self);
        view.addSubview(redStripe.view);
        redStripe.view.tag = benchTag++;
        bench.append(redStripe);
        
        indigoChevron.positionPlayer(970, y: 210);
        indigoChevron.cloneDelegate = self;
        self.addChildViewController(indigoChevron);
        indigoChevron.didMoveToParentViewController(self);
        view.addSubview(indigoChevron.view);
        indigoChevron.view.tag = benchTag++;
        bench.append(indigoChevron);

        orangeSolid.positionPlayer(970, y: 290);
        orangeSolid.cloneDelegate = self;
        self.addChildViewController(orangeSolid);
        orangeSolid.didMoveToParentViewController(self);
        view.addSubview(orangeSolid.view);
        orangeSolid.view.tag = benchTag++;
        bench.append(orangeSolid);

        purpleStripe.positionPlayer(970, y: 370);
        purpleStripe.cloneDelegate = self;
        self.addChildViewController(purpleStripe);
        purpleStripe.didMoveToParentViewController(self);
        view.addSubview(purpleStripe.view);
        purpleStripe.view.tag = benchTag++;
        bench.append(purpleStripe);

        redSolid.positionPlayer(970, y: 450);
        redSolid.cloneDelegate = self;
        self.addChildViewController(redSolid);
        redSolid.didMoveToParentViewController(self);
        view.addSubview(redSolid.view);
        redSolid.view.tag = benchTag++;
        bench.append(redSolid);
        
        self.view.bringSubviewToFront(eraser);
        self.view.bringSubviewToFront(darkSlateGray);
        self.view.bringSubviewToFront(fireBrick);
        self.view.bringSubviewToFront(navy);
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        chalkboard.view.frame = view.bounds;
    }

    @IBAction func changeColour(sender:UIButton!) {
        println("Hi Manny \(sender)");
        
        chalkboard.changeColour(sender.backgroundColor!.CGColor);
    }
    
    @IBAction func erase(sender:UIButton!) {
        chalkboard.erase();
    }
    
    func clone(player: Player) {
        let newPlayer: Player = player.copy() as! Player;
        newPlayer.positionPlayer(player.view.frame.origin.x, y: player.view.frame.origin.y);
        bench.append(newPlayer);
        newPlayer.cloneDelegate = self;
        newPlayer.view.tag = benchTag++;
        bench.append(newPlayer);
        
        self.addChildViewController(newPlayer);
        newPlayer.didMoveToParentViewController(self);
        self.view.addSubview(newPlayer.view);

        player.cloneDelegate = nil;
        player.refereeDelegate = self;
    }

    func sendOff(player: Player) {
        if let i = find(bench, player) {
            bench.removeAtIndex(i);
            
            player.removeFromParentViewController();
            player.view.removeFromSuperview();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  ViewController.swift
//  EarlesSoccerField
//
//  Created by Duncan Davidson on 12/4/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CloningDelegate, RefereeingDelegate {
    @IBOutlet weak var field: UIImageView!
    @IBOutlet weak var eraser: UIButton!
    @IBOutlet weak var darkSlateGray: UIButton!
    @IBOutlet weak var fireBrick: UIButton!
    @IBOutlet weak var navy: UIButton!

    var bench = [Player]();
    var benchTag = 0;
    
    let blueSolid: BlueSolid = BlueSolid();
    let indigoChevron: IndigoChevron = IndigoChevron();
    let orangeSolid: OrangeSolid = OrangeSolid();
    let purpleStripe: PurpleStripe = PurpleStripe();
    let redSolid: RedSolid = RedSolid();
    let redStripe: RedStripe = RedStripe();
    
    let chalkboard: Chalkboard = Chalkboard();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(chalkboard.view);
        self.addChildViewController(chalkboard);
        chalkboard.didMove(toParentViewController: self);

        for starter:Player in Manager.ofFootballers.takeTheField() {
            self.addChildViewController(starter);
            starter.didMove(toParentViewController: self);
            view.addSubview(starter.view);
            
            if starter.view.tag > benchTag
                {benchTag = starter.view.tag + 1}
            
            starter.refereeDelegate = self;
            bench.append(starter);
        }

        blueSolid.positionPlayer(970, y: 50);
        blueSolid.cloneDelegate = self;
        self.addChildViewController(blueSolid);
        blueSolid.didMove(toParentViewController: self);
        view.addSubview(blueSolid.view);
        blueSolid.view.tag = benchTag;
        benchTag += 1;
        bench.append(blueSolid);
        
        redStripe.positionPlayer(970, y: 130);
        redStripe.cloneDelegate = self;
        self.addChildViewController(redStripe);
        redStripe.didMove(toParentViewController: self);
        view.addSubview(redStripe.view);
        redStripe.view.tag = benchTag;
        benchTag += 1;
        bench.append(redStripe);
        
        indigoChevron.positionPlayer(970, y: 210);
        indigoChevron.cloneDelegate = self;
        self.addChildViewController(indigoChevron);
        indigoChevron.didMove(toParentViewController: self);
        view.addSubview(indigoChevron.view);
        indigoChevron.view.tag = benchTag;
        benchTag += 1;
        bench.append(indigoChevron);

        orangeSolid.positionPlayer(970, y: 290);
        orangeSolid.cloneDelegate = self;
        self.addChildViewController(orangeSolid);
        orangeSolid.didMove(toParentViewController: self);
        view.addSubview(orangeSolid.view);
        orangeSolid.view.tag = benchTag;
        benchTag += 1;
        bench.append(orangeSolid);

        purpleStripe.positionPlayer(970, y: 370);
        purpleStripe.cloneDelegate = self;
        self.addChildViewController(purpleStripe);
        purpleStripe.didMove(toParentViewController: self);
        view.addSubview(purpleStripe.view);
        purpleStripe.view.tag = benchTag;
        benchTag += 1;
        bench.append(purpleStripe);

        redSolid.positionPlayer(970, y: 450);
        redSolid.cloneDelegate = self;
        self.addChildViewController(redSolid);
        redSolid.didMove(toParentViewController: self);
        view.addSubview(redSolid.view);
        redSolid.view.tag = benchTag;
        benchTag += 1;
        bench.append(redSolid);
        
        self.view.bringSubview(toFront: eraser);
        self.view.bringSubview(toFront: darkSlateGray);
        self.view.bringSubview(toFront: fireBrick);
        self.view.bringSubview(toFront: navy);
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        chalkboard.view.frame = view.bounds;
    }

    @IBAction func changeColour(_ sender:UIButton!) {
        chalkboard.changeColour(sender.backgroundColor!.cgColor);
    }
    
    @IBAction func erase(_ sender:UIButton!) {
        chalkboard.erase();
    }
    
    func clone(_ player: Player) {
        let newPlayer: Player = player.copy() as! Player;
        newPlayer.positionPlayer(player.view.frame.origin.x, y: player.view.frame.origin.y);
        bench.append(newPlayer);
        newPlayer.cloneDelegate = self;
        newPlayer.view.tag = benchTag;
        benchTag += 1;
        
        self.addChildViewController(newPlayer);
        newPlayer.didMove(toParentViewController: self);
        self.view.addSubview(newPlayer.view);

        player.cloneDelegate = nil;
        player.refereeDelegate = self;
    }

    func sendOff(_ player: Player) {
        if let i = bench.index(of: player) {
            bench.remove(at: i);
            
            player.removeFromParentViewController();
            player.view.removeFromSuperview();
            
            Manager.ofFootballers.sendOff(player);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


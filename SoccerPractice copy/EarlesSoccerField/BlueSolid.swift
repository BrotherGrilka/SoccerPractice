//
//  BlueSolid.swift
//  EarlesSoccerField
//
//  Created by Duncan Davidson on 12/4/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

import UIKit

class BlueSolid: Player {

//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder);
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        playerImage.image = UIImage(named: "BlueSolid.png");
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

//
//  OrangeSolid.swift
//  EarlesSoccerField
//
//  Created by Dunc on 12/4/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

import UIKit

class OrangeSolid: Player {

    override func viewDidLoad() {
        super.viewDidLoad()

        playerImage.image = UIImage(named: "OrangeSolid.png");
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

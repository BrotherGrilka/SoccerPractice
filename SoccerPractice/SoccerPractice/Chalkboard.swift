//
//  Chalkboard.swift
//  EarlesSoccerField
//
//  Created by Dunc on 12/5/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

import UIKit

class Chalkboard: UIViewController {
    var mannysCanvas = UIImageView();
    var lastPoint = CGPoint();
    let draww: UIPanGestureRecognizer = UIPanGestureRecognizer();

    var red = CGFloat();
    var green = CGFloat();
    var blue = CGFloat();
    var brush = CGFloat();
    var opacity = CGFloat();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DarkSlateGray
        red = 47.0/255.0;
        green = 79.0/255.0;
        blue = 79.0/255.0;
        brush = 3.0;
        opacity = 1.0;
        
        self.view.isUserInteractionEnabled = true;
        
        draww.addTarget(self, action:#selector(Chalkboard.draw(_:)));
        self.view.addGestureRecognizer(draww);

        view.addSubview(mannysCanvas);
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        mannysCanvas.frame = view.bounds;
    }
    
    func draw(_ recognizer: UIPanGestureRecognizer) {
        let currentPoint = recognizer.location(in: self.view);
        
        if recognizer.state == UIGestureRecognizerState.began
            {lastPoint = currentPoint}
        
        UIGraphicsBeginImageContext(self.view.frame.size);
  
        mannysCanvas.image?.draw(in: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height));
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y));
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y));
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round);
        UIGraphicsGetCurrentContext()?.setLineWidth(brush );
        UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0);
        UIGraphicsGetCurrentContext()?.setBlendMode(CGBlendMode.normal);

        UIGraphicsGetCurrentContext()?.strokePath();
        self.mannysCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
        mannysCanvas.alpha = opacity;
        UIGraphicsEndImageContext();
        
        lastPoint = currentPoint;
    }
    
    func erase()
    {
//        let context = UIGraphicsGetCurrentContext();
//        CGContextClearRect(context, self.mannysCanvas.bounds);
        
        self.mannysCanvas.image = nil;
    }
    
    func changeColour(_ color: CGColor) {
//        CGColorRef colorRef = [colorButton.backgroundColor CGColor];
        
        let _countComponents = color.numberOfComponents;
        
        if (_countComponents == 4) {
            let _components = color.components;
            red     = (_components?[0])!;
            green = (_components?[1])!;
            blue   = (_components?[2])!;
        }
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

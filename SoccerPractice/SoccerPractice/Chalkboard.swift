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
        
        self.view.userInteractionEnabled = true;
        
        draww.addTarget(self, action:"draw:");
        self.view.addGestureRecognizer(draww);

        view.addSubview(mannysCanvas);
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        mannysCanvas.frame = view.bounds;
    }
    
    func draw(recognizer: UIPanGestureRecognizer) {
        let currentPoint = recognizer.locationInView(self.view);
        
        if recognizer.state == UIGestureRecognizerState.Began
            {lastPoint = currentPoint}
        
        UIGraphicsBeginImageContext(self.view.frame.size);
  
        mannysCanvas.image?.drawInRect(CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height));
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), CGLineCap.Round);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),CGBlendMode.Normal);

        CGContextStrokePath(UIGraphicsGetCurrentContext());
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
    
    func changeColour(color: CGColor) {
//        CGColorRef colorRef = [colorButton.backgroundColor CGColor];
        
        let _countComponents = CGColorGetNumberOfComponents(color);
        
        if (_countComponents == 4) {
            let _components = CGColorGetComponents(color);
            red     = _components[0];
            green = _components[1];
            blue   = _components[2];
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

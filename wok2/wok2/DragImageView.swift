//
//  DragImageView.swift
//  wok2
//
//  Created by jf19abc on 15/01/2020.
//  Copyright © 2020 jf19abc. All rights reserved.
//

import UIKit

class DragImageView: UIImageView {

    var startLocation: CGPoint?
    var resetPosition = (x: 100, y: 110)
    var limit: CGPoint?
    var myDelegate: subviewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startLocation = touches.first?.location(in: self)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentLocation = touches.first?.location(in: self)
        
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        var newCenter = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
        
        
        //Constrain the movement to the phone screen bounds
        
        let halfx = self.bounds.midX
        newCenter.x = max(halfx, newCenter.x)
        newCenter.x = min(self.superview!.bounds.width - halfx, newCenter.x)
        
        let halfy = self.bounds.midY
        newCenter.y = max(halfy, newCenter.y)
        newCenter.y = min(self.superview!.bounds.height - halfy, newCenter.y)
        
        self.center = newCenter
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.myDelegate?.goBall()
        let dx = resetPosition.x
        let dy = resetPosition.y
        let newCenter = CGPoint(x: dx, y: dy)
        self.center = newCenter
    }
}

//
//  PolaroidView.swift
//  TwistedView
//
//  Created by Javier Loucim on 9/29/16.
//  Copyright © 2016 Javier Loucim. All rights reserved.
//

import UIKit

class PolaroidView: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var polaroidWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var polaroidHeightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    class func instanceFromNib() -> PolaroidView {
        return UINib(nibName: "PolaroidView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! PolaroidView
    }

    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_4_OR_LESS {
            polaroidWidthConstraint.constant = 280
            polaroidHeightConstraint.constant = 280
            
            imageWidthConstraint.constant = 195
            imageHeightConstraint.constant = 195
            imageTopConstraint.constant = 18
            imageLeadingConstraint.constant = 42
        }
    }
}

//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Antonia Blair on 5/22/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating = 0 {
        // property observer observes and responds to changes in a property's value
        // it is called everytime a property's value is set -- didSet is called after it is set
        didSet {
            setNeedsLayout()
        }
    }
    
    
    var ratingButtons = [UIButton]()
    let stars = 5
    let spacing = 5
    let starCount = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        // Call the superclass's initializer
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        // lay out 5 buttons in this for-loop. They will be stacked until you override the layoutSubviews method to put them side by side.
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal) //unselected state
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false // don't show additional highlight during state change
            
            /* This event signifies that the user has pressed on a button. You set the target to self,
             which in this case is the RatingControl class, because that’s where the action is defined.
             The #selector expression returns the Selector value for the provided method.
             A selector is an opaque value that identifies the method. */
            
            
            //attach the RatingButtonTapped(_:) action method to button object (triggered when .TouchDown event happens)
            // target is self (in this case, RatingControl class - bc action is defined there)
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    // Make buttons side by side -- layoutSubviews adjusts layout precisely
    override func layoutSubviews() {
         // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset seach button's origin by the length of the button, plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    //Provide intrinsic content size for button
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * stars) + (spacing * (stars - 1))
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
        
        // tell me what number in the array the button is
        // use force unwrap operator (!) to access the underlying index value (instead of optional, since I created the array and I know they are inside it)
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
        

    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // if index of button is less than the rating, that button should be selected
            button.selected = index < rating
        }
    }

}

//
//  RatingControl.swift
//  CrushTracker
//
//  Created by MacBook on 8/13/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating=0{
        //observer for rating change
        didSet{
            updateSelectedRating()
        }
    }
    @IBInspectable var starSize : CGSize=CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount : Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: action
    @objc func ratingBtnTapped(button:UIButton){
        //check index of button in ratingButtons arr
        guard let index=ratingButtons.index(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        let selectingRating=index+1
        if selectingRating==rating{
            rating=0
        }else{
            rating=selectingRating
        }
    }
    
    //MARK: method
    private func setupButtons(){
        //clear any remaing btns
        for btn in ratingButtons{
            removeArrangedSubview(btn)
            btn.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            addButtonToView()
        }
    }
    
    private func addButtonToView(){
        //load star images
        let bundle=Bundle(for: type(of: self))
        let emptyStar=UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let fillStar=UIImage(named: "fillStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightStar=UIImage(named: "highlightStar", in: bundle, compatibleWith: self.traitCollection)
        
        let button=UIButton()
        //Add image for button in many states
        button.setImage(emptyStar, for: UIControlState.normal)
        button.setImage(fillStar, for: .selected)
        button.setImage(highlightStar, for: .highlighted)   //when user touch btn, whether or not it is selected, the system'll show highlight img
        button.setImage(highlightStar, for: [.highlighted,.selected])
        
        //Add constraints
        button.translatesAutoresizingMaskIntoConstraints=false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true
        //add action
        // target-action pattern, attach ratingBtnTapped to button
        button.addTarget(self, action: #selector(RatingControl.ratingBtnTapped(button:)), for: .touchUpInside)
        
        //Add button to stack view
        addArrangedSubview(button)
        
        ratingButtons.append(button)
        //update the button’s selection state whenever buttons are added to the control
        updateSelectedRating()
    }
    //call this updating func when rating change. By add a properties observer to rating {
    private func updateSelectedRating(){
        for (index,btn) in ratingButtons.enumerated(){
            if index<rating{
                btn.isSelected=true
            }else{
                btn.isSelected=false
            }
        }
    }
}

//
//  CColorPickerViewController.swift
//  DrawLines
//
//  Created by Onur Işık on 22.01.2019.
//  Copyright © 2019 Onur Işık. All rights reserved.
//

import UIKit


internal protocol CColorPickerDelegate : NSObjectProtocol {
    func cColorPickerCurrentTouched(cColorPickerController: CColorPickerViewController, color:UIColor, point: CGPoint)
    func cColorPickerDidCancelPickingColor(cColorPickerController: CColorPickerViewController)
}

class CColorPickerViewController: UIViewController, HSBColorPickerDelegate {
    
    @IBOutlet weak var colorsView: HSBColorPicker!
    @IBOutlet weak var colorPreviewView: UIView!
    @IBOutlet weak var colorHexStringLabel: UILabel!
    
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 8.0
    private var fillColor: UIColor = .white //
    
    var selectedColor: UIColor = UIColor.white
    var lastTouchedPoint: CGPoint = CGPoint.zero
    weak internal var delegate: CColorPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adjustViewElements()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: self.view.bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3
            
            self.view.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    fileprivate func adjustViewElements() {
        
        colorsView.delegate = self
        
        colorsView.layer.masksToBounds = true
        colorsView.layer.cornerRadius = 4
        colorPreviewView.layer.masksToBounds = true
        colorPreviewView.layer.cornerRadius = 4
    }
    
    @IBAction fileprivate func buttonsAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            delegate?.cColorPickerCurrentTouched(cColorPickerController: self, color: self.selectedColor, point: self.lastTouchedPoint)
            
        } else {
            delegate?.cColorPickerDidCancelPickingColor(cColorPickerController: self)
        }
    }
    
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
        
        self.selectedColor = color
        self.lastTouchedPoint = point
        self.colorPreviewView.backgroundColor = color
        self.colorHexStringLabel.text = color.toHexString()
    }
    
}

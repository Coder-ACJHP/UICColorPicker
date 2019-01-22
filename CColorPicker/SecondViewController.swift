//
//  SecondViewController.swift
//  DrawLines
//
//  Created by Onur Işık on 17.12.2018.
//  Copyright © 2018 Onur Işık. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, CColorPickerDelegate {
    
    var colorPickerViewFrame: CGRect!
    var colorPickerController: CColorPickerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adjustColorPickerView()
        
    }
    
    fileprivate func adjustColorPickerView() {
        
        colorPickerController = CColorPickerViewController(nibName: "CColorPickerViewController", bundle: nil)
        self.addChild(colorPickerController)
        colorPickerController.delegate = self
        self.view.addSubview(colorPickerController.view)
        
        self.colorPickerViewFrame = CGRect(x: 0, y: 0, width: 279, height: 406)
        self.colorPickerController.view.isHidden = true
        self.colorPickerController.view.alpha = 0
        
    }
    
    @IBAction func showColorPicker(_ sender: UIButton) {
        
        self.colorPickerController.view.isHidden = false
        colorPickerController.view.center = self.view.center
        
        UIView.transition(with: self.colorPickerController.view, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.colorPickerController.view.alpha = 1.0
        }, completion: nil)
    }
    
    func cColorPickerCurrentTouched(cColorPickerController: CColorPickerViewController, color: UIColor, point: CGPoint) {

        UIView.transition(with: self.colorPickerController.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.colorPickerController.view.alpha = 0.0
            self.view.backgroundColor = color
        }, completion: {(_) in
            self.colorPickerController.view.isHidden = true
        })
        
    }
    
    func cColorPickerDidCancelPickingColor(cColorPickerController: CColorPickerViewController) {
        UIView.transition(with: self.colorPickerController.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.colorPickerController.view.alpha = 0.0
        }, completion: {(_) in
            self.colorPickerController.view.isHidden = true
        })
    }
    
}


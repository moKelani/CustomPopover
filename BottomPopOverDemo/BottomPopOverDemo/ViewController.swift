//
//  ViewController.swift
//  BottomPopOverDemo
//
//  Created by Mohamed El-Said on 8/1/19.
//  Copyright © 2019 Mohamed El-Said. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var numberOfRows = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTappedShowButton(_ sender: UIButton) {
        guard let numberOfRowsStr = textField.text else { return }
        numberOfRows = Int(numberOfRowsStr) ?? 2
        let height = (CGFloat(numberOfRows)*64.0)+50
        navigateToCustomPopoverVC(height: height)
    }
    
    
    func navigateToCustomPopoverVC(height: CGFloat) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "CustomPopOverVC") as? CustomPopOverVC else { return}
        if height < (view.frame.height - 70) {
            popupVC.height = height
        }else {
            popupVC.height = view.frame.height - 70
        }
        
        //popupVC.addressType = addressType
        //popupVC.Types = type
        popupVC.topCornerRadius = 20
        popupVC.presentDuration = 0
        popupVC.dismissDuration = 0
        popupVC.delegate = self
        //popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
        
    }
}

extension ViewController: CustomPopOverVCDelegate {
    func getNumberOfRows() -> Int {
        return numberOfRows
    }
    

}




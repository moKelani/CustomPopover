//
//  ViewController.swift
//  BottomPopOverDemo
//
//  Created by Mohamed El-Said on 8/1/19.
//  Copyright © 2019 Mohamed El-Said. All rights reserved.
//

import UIKit

protocol CustomPopOverVCDelegate {
    func getNumberOfRows() -> Int
}
class CustomPopOverVC: BottomPopupViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    
    var delegate: CustomPopOverVCDelegate?
    
    
    var dataSource: [Int] = [0]
    override func viewDidLoad() {
        super.viewDidLoad()
        makeDataSource()
        print(height!)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func getPopupHeight() -> CGFloat {
        return height ?? CGFloat(300)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(10)
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration ?? 1.0
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration ?? 1.0
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }
    
    func makeDataSource(){
        guard let count = delegate?.getNumberOfRows() else { return }
        for y in 0..<count {
           dataSource.append(y+1)
            print(dataSource)
        }
    }
    
}

extension CustomPopOverVC: UITableViewDelegate {
    
}

extension CustomPopOverVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(dataSource[indexPath.row])"
        
        return cell
    }
    
    
}

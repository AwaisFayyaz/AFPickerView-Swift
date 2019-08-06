//
//  ViewController.swift
//  AFPickerView
//
//  Created by BugDev Studios on 18/03/2019.
//  Copyright © 2019 BugDev Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
//    pickerView.showFrom(viewController: self, with: ["A", "B", "C" ]) { (selectedRow, selectedValue) in
//      print("selectedRow = \(selectedRow), selectedValue = \(selectedValue) ")
//    }
    
    
  
  }

  
  @IBAction func btnShowFromWindowTapped(_ sender: UIButton) {
    
    let pickerValues = ["Pakistan", "India", "Sri Lanka", "China", "Maldives", "Russia", "Iran"]
    
    let pickerView = AFPickerView.init(dataSource: pickerValues, selectedIndex: 0)
    
    pickerView.showFromWindow { (selectedIndex, selectedValue) in
      print("selectedIndex = \(selectedIndex), value = \(selectedValue)")
    }

    
  }
  
  @IBAction func btnShowPickerTapped(_ sender: UIButton) {
    
    let pickerValues = ["A", "B", "C", "D", "E", "F", "G"]
    
    //Static method can be used.
    AFPickerView.showFrom(viewController: self, dataSource: pickerValues) { (index, value) in
      print("index = \(index), value = \(value)")
    }
    
    //Another way of using
    
//    let pickerView = AFPickerView.init(dataSource: pickerValues, selectedIndex: 3)
////    pickerView.showFromWindow()
//
    pickerView.showFrom(viewController: self) { (index, value) in
      print("index = \(index), value = \(value)")
    }
    
    
  }
}


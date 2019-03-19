//
//  AFPickerView.swift
//  AFPickerView
//
//  Created by BugDev Studios on 18/03/2019.
//  Copyright © 2019 BugDev Studios. All rights reserved.
//

import UIKit

class AFPickerView: UIView {
  //MARK:- OUTLETS
  @IBOutlet fileprivate weak var pickerView_: UIPickerView!
  @IBOutlet var view: UIView!
  @IBOutlet weak var dimView: UIView!
  //Constraints.
  ///for animating up and down
  @IBOutlet weak var bottomViewPickerContainer: NSLayoutConstraint!
  
  //MARK:- PROPERTIES
  var heightPickerView: CGFloat = 233
  //MARK:- Variables
  private var appWindow: UIWindow {
    
    guard let window = UIApplication.shared.keyWindow else {
      debugPrint("KeyWindow not set. Returning a default window for unit testing.")
      return UIWindow()
    }
    return window
  }
  
  
  var pickerView : UIPickerView {
    get { return pickerView_ }
  }
  
  //////// Data ////////
  fileprivate var dataSourceArray =    [String]()
  fileprivate var selectedRowIndex:   Int = 0
  
  fileprivate weak var viewController: UIViewController?
  
  //////// UI ////////
  
  fileprivate var screenHeight = UIScreen.main.bounds.height
  fileprivate var screenWidth = UIScreen.main.bounds.width
  fileprivate var backGroundView = UIView.init(frame: UIScreen.main.bounds)
  fileprivate var screenRect = UIScreen.main.bounds
  
  //////// Handlers ////////
  var doneHandler   :((Int, String) -> Void)?
  var changeHandler :((Int, String) -> Void)?
  
  
  //MARK:- Initializers
  
  init(){
    super.init(frame: .zero)
    LoadFromNib()
  }
  
  init(dataSource: [String], selectedIndex: Int? = nil) {
    
    super.init(frame: screenRect)
    initializeWith(dataSource: dataSource, selectedIndex: selectedIndex ?? 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    LoadFromNib()

  }
  class func showFrom(viewController: UIViewController, dataSource: [String], selectedRowIndex: Int = 0,
                       doneHandler: @escaping (Int, String) ->() ) {
    
    let picker = AFPickerView.init(dataSource: dataSource, selectedIndex: selectedRowIndex)
    picker.showFrom(viewController: viewController) { ( index, value) in
      doneHandler(index, value)
    }
    
    
    
  }
  
  func initializeWith(dataSource: [String], selectedIndex: Int ) {
    
    self.selectedRowIndex = selectedIndex
    self.dataSourceArray = dataSource
    LoadFromNib()
    
    bottomViewPickerContainer.constant = -heightPickerView
    UIView.animate(withDuration: 0) {
      self.view.layoutIfNeeded()
      
    }
    
    self.layer.cornerRadius = 11
    self.pickerView.selectRow(self.selectedRowIndex, inComponent: 0, animated: true)
    
  }
  //MARK:- FUNCTIONS
  func showFrom(viewController: UIViewController, _ doneHandler: @escaping (Int, String) -> () ){
    
    
    self.pickerView_.reloadAllComponents()
    self.viewController = viewController
    
    self.alpha = 0
    self.viewController?.view.addSubview(self)
    bottomViewPickerContainer.constant = 0
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
      self.dimView.alpha = 0.3
      self.alpha = 1
      self.view.layoutIfNeeded()
    })
    
    self.doneHandler = doneHandler
    
  }
  
  func hide() {
    
    bottomViewPickerContainer.constant = -heightPickerView
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      
      self.dimView.alpha = 0
      self.view.layoutIfNeeded()
      
    }) { (completed) in
      self.removeFromSuperview()
    }
    
    
  }
  
  func showFromWindow(_ doneHandler: @escaping (Int, String) -> ()){
    
//    addSubview(pickerView)
    LoadFromNib()
    
    self.pickerView_.reloadAllComponents()
    self.alpha = 0
    self.appWindow.addSubview(self)
    
    bottomViewPickerContainer.constant = 0
    
    UIView.animate(withDuration:1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
      self.dimView.alpha = 0.3
      self.alpha = 1
      
      self.view.layoutIfNeeded()
    })
    
    self.doneHandler = doneHandler
    
    
  }
  
  //MARK:-ACTIONS
  
  @IBAction func btnDoneTapped(_ sender: Any) {
    
    self.doneHandler?(selectedRowIndex, dataSourceArray[selectedRowIndex])
    hide()
  }
  
  @IBAction func btnCancelTapped(_ sender: UIButton) {
    hide()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    if touch?.view == dimView {
      hide()
    }
  }
  
}

extension AFPickerView {
  static var nibName : String = String.init(describing: AFPickerView.self)
}

//MARK:- UIPickerViewDataSource, UIPickerViewDelegate
extension AFPickerView : UIPickerViewDataSource, UIPickerViewDelegate {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return dataSourceArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    let title = dataSourceArray[row]
    return title
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedRowIndex = row
    changeHandler?(row, dataSourceArray[row])
  }
}


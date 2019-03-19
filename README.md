# AFPickerView-Swift
This is a simple Picker View subclass for showing pickerview from any view controller or from window.

# Usage

Follow 3 simple steps.

1. Just Declare a string array for possible values.

    let pickerValues = ["Pakistan", "India", "Sri Lanka", "China", "Maldives", "Russia", "Iran"]

2. Initialize the PickerView with values and an optional selectedIndex
                                                                  //selectedIndex is optional paramter
    let pickerView = AFPickerView.init(dataSource: pickerValues, selectedIndex: 0)

3. Show the picker View 

    // Either show from a view controller (Recommended)  // 
     AFPickerView.showFrom(viewController: self, dataSource: pickerValues) { (index, value) in
      print("index = \(index), value = \(value)")
    }
    
    // OR From UIWindow  //
    
    pickerView.showFromWindow { (selectedIndex, selectedValue) in
      print("selectedIndex = \(selectedIndex), value = \(selectedValue)")
    }


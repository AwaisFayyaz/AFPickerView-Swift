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
    
        pickerView.showFrom(viewController: self) { (index, value) in
          print("index = \(index), value = \(value)")
        }

    
    // OR From UIWindow  //
    
        pickerView.showFromWindow { (selectedIndex, selectedValue) in
          print("selectedIndex = \(selectedIndex), value = \(selectedValue)")
        }

Get the Selected Value and index from the closure, as indicated in sample code above. 
Note: Closure does not get called when used presses the cancel button or hides the picker by tapping elseWhere.

Credits.

Awais Fayyaz.
AwaisFayyaz17@gmail.com

iOS Developer @ BugdevStudios,
Lahore.

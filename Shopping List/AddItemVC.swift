//
//  AddItemVC.swift
//  Shopping List
//
//  Created by Tsering Lama on 11/2/20.
//

import UIKit

protocol AddItemVCDelegate: AnyObject {
    func addNewItem(VC: AddItemVC, item: Item)
}

class AddItemVC: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    weak var delegate: AddItemVCDelegate?
    
    private var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        selectedCategory = Category.allCases.first
    }
    
    @IBAction func addItemtoShoppingList() {
        guard let name = nameTextField.text, !name.isEmpty,
              let priceText = priceTextField.text, !priceText.isEmpty,
              let price = Double(priceText),
              let selectedCategory = selectedCategory else {
            print("missing category")
            return
        }
        
        let item = Item(name: name, price: price, category: selectedCategory)
        delegate?.addNewItem(VC: self, item: item)
        dismiss(animated: true)
    }
    
}

extension AddItemVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

extension AddItemVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Category.allCases[row]
    }
}

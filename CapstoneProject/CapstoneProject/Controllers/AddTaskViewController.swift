//
//  AddTaskViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/15.
//

import UIKit

public class AddTaskViewController: UIViewController {
    
    // MARK: - Instance Properties
    public var addTaskView: AddTaskView! {
        guard isViewLoaded else { return nil }
        return (view as! AddTaskView)
    }
    
    let datePicker: UIDatePicker = UIDatePicker()
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addTaskView.taskNameTextField.delegate = self
        self.addTaskView.dateTextField.delegate = self
        self.tapGesture.delegate = self
        
        setupBackButton()
        setupAddTaskButton()
        setKeyboardActions()
        setStackViewsCorners()
        createDataPickerView()
    }
    
    private func setupBackButton() {
        let action = UIAction { _ in
            self.presentingViewController?.dismiss(animated: true)
        }
        self.addTaskView.backButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupAddTaskButton() {
        let action = UIAction { _ in
            // TO-DO: 새로운 task 생성 후 HomeViewController로 넘겨주기
            self.presentingViewController?.dismiss(animated: true)
        }
        self.addTaskView.addTaskButton.addAction(action, for: .touchUpInside)
    }
    
    // TextField에서 다른 화면 터치하거나 return키 입력 시, 키보드 dismiss.
    // keyboard가 나타날 때 textField를 가리지 않도록, view의 높이 변화시킴.
    private func setKeyboardActions() {
        self.view.addGestureRecognizer(self.tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setStackViewsCorners() {
        self.addTaskView.stackFirstView.layer.cornerRadius = 15
        self.addTaskView.stackSecondView.layer.cornerRadius = 15
    }
}

extension AddTaskViewController: UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    // TextField에서 다른 화면 터치 시, 키보드 dismiss.
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        self.addTaskView.addTaskButton.isHidden = true
        self.view.frame.origin.y = 0
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if keyboardHeight > 300 {
                self.view.frame.origin.y = -200
            } else {
                self.view.frame.origin.y = -100
            }
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.addTaskView.addTaskButton.isHidden = false
        self.view.frame.origin.y = 0
    }
}

extension AddTaskViewController {
    
    private func createDataPickerView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 45))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        self.addTaskView.dateTextField.inputAccessoryView = toolbar
        self.addTaskView.dateTextField.inputView = datePicker
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .inline
    }
    
    @objc
    func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        self.addTaskView.dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc
    func cancelPressed() {
        self.view.endEditing(true)
    }
}

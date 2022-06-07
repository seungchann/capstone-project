//
//  AddTaskViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/15.
//

import UIKit

public class AddTaskViewController: UIViewController {
    
    enum ButtonState {
        case initial
        case assignment
        case project
        case exam
        case quiz
        case presentation
    }
    
    // MARK: - Instance Properties
    public var addTaskView: AddTaskView! {
        guard isViewLoaded else { return nil }
        return (view as! AddTaskView)
    }
    
    let calendarDatePicker: UIDatePicker = UIDatePicker()
    let timeDatePicker: UIDatePicker = UIDatePicker()
    let expectedTimeDatePicker: UIDatePicker = UIDatePicker()
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    var tempTask: Task_ = Task_(name: "", tag: "", expectedTime: 0, dueDateStr: "", dueTimeStr: "", color: 0)
    var tempTag: ButtonState!
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addTaskView.taskNameTextField.delegate = self
        self.addTaskView.dateTextField.delegate = self
        self.addTaskView.timeTextField.delegate = self
        self.tapGesture.delegate = self
        
        // TO-DO : 태그와 컬러 찾아서 매치시키기
        self.tempTask.tag = "과제"
        self.tempTask.color = 0xFFFFFF
        
        setupBackButton()
        setupAddTaskButton()
        setKeyboardActions()
        setStackViewsCorners()
        setDataPickerView()
        setCategoryButtons()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tempTag = .initial
    }
    
    private func setupBackButton() {
        let action = UIAction { _ in
            self.presentingViewController?.dismiss(animated: true)
        }
        self.addTaskView.backButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupAddTaskButton() {
        let action = UIAction { _ in
            guard PersistenceManager.shared.insertTask(task: self.tempTask) else {
                // TO-DO : 데이터 저장 실패 시 예외처리
                print("데이터가 저장되지 않았습니다.")
                return
            }
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
    
    private func setValueFromTextField() {
        if self.addTaskView.taskNameTextField.isEditing {
            tempTask.name = self.addTaskView.taskNameTextField.text ?? ""
            print(tempTask.name)
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        
        if self.addTaskView.dateTextField.isEditing {
            // CoreData에 저장
            formatter.dateFormat = "yyyy-MM-dd"
            tempTask.dueDateStr = formatter.string(from: calendarDatePicker.date)
            
            // View에 표현
            formatter.dateFormat = "yyyy-MM-dd EEE"
            self.addTaskView.dateTextField.text = formatter.string(from: calendarDatePicker.date)
        }
        
        if self.addTaskView.timeTextField.isEditing {
            // CoreData에 저장
            formatter.dateFormat = " HH:mm"
            tempTask.dueTimeStr = formatter.string(from: timeDatePicker.date)

            // View에 표현
            formatter.dateFormat = "a hh시 mm분"
            self.addTaskView.timeTextField.text = formatter.string(from: timeDatePicker.date)
        }
        
        if self.addTaskView.expectedTimeTextField.isEditing {
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            
            var expectedMin: Int = 0
            var expectedHour: Int = 0
            
            if expectedTimeDatePicker.countDownDuration == 60 {
                expectedMin = 15
            } else {
                expectedMin = Int(round(expectedTimeDatePicker.countDownDuration / 60))
            }
            
            self.tempTask.expectedTime = expectedMin
            
            if expectedMin > 60 {
                expectedHour = Int(floor(Double(expectedMin / 60)))
                expectedMin -= (expectedHour * 60)
                self.addTaskView.expectedTimeTextField.text = "총 \(expectedHour)시간 \(expectedMin) 분"
            } else {
                self.addTaskView.expectedTimeTextField.text = "총 \(expectedMin) 분"
            }
        }
    }
}

extension AddTaskViewController: UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    // TextField에서 다른 화면 터치 시, 키보드 dismiss.
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        setValueFromTextField()
        self.view.endEditing(true)
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setValueFromTextField()
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
                self.view.frame.origin.y = -150
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
    
    private func setDataPickerView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 45))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        
        var components = DateComponents()
        components.day = 0
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())

        self.addTaskView.dateTextField.inputAccessoryView = toolbar
        self.addTaskView.dateTextField.inputView = calendarDatePicker
        self.addTaskView.dateTextField.tintColor = .clear
        
        self.addTaskView.timeTextField.inputAccessoryView = toolbar
        self.addTaskView.timeTextField.inputView = timeDatePicker
        self.addTaskView.timeTextField.tintColor = .clear
        
        self.addTaskView.expectedTimeTextField.inputAccessoryView = toolbar
        self.addTaskView.expectedTimeTextField.inputView = expectedTimeDatePicker
        self.addTaskView.expectedTimeTextField.tintColor = .clear
        
        self.calendarDatePicker.locale = Locale(identifier: "ko-KR")
        self.calendarDatePicker.datePickerMode = .date
        self.calendarDatePicker.preferredDatePickerStyle = .inline
        self.calendarDatePicker.minimumDate = minDate
        
        self.timeDatePicker.locale = Locale(identifier: "ko-KR")
        self.timeDatePicker.datePickerMode = .time
        self.timeDatePicker.preferredDatePickerStyle = .wheels
        
        self.expectedTimeDatePicker.locale = Locale(identifier: "ko-KR")
        self.expectedTimeDatePicker.datePickerMode = .countDownTimer
        self.expectedTimeDatePicker.preferredDatePickerStyle = .automatic
        self.expectedTimeDatePicker.minuteInterval = 15
    }
    
    @objc
    func donePressed() {
        setValueFromTextField()
        self.view.endEditing(true)
    }
    
    
    @objc
    func cancelPressed() {
        self.view.endEditing(true)
    }
}

// MARK: - 각 카테고리 버튼, 내부 Action 설정
extension AddTaskViewController {
    private func setCategoryButtons() {
        let bgImageViews: [UIImageView] = [self.addTaskView.assignBtnBgImageView,
                                           self.addTaskView.examBtnBgImageView,
                                           self.addTaskView.projectBtnBgImageView,
                                           self.addTaskView.quizBtnBgImageView,
                                           self.addTaskView.presentationBtnBgImageView]
        
        // 체크박스 배경 초기 설정
        bgImageViews.forEach { $0.layer.cornerRadius = 8 }
        self.clearCheckMarks()
        
        // 각 Button마다 Action 설정
        self.addTaskView.assignButton.addAction(UIAction { _ in
            self.categoryButtonTapped(checkbuttonState: .assignment)
        }, for: .touchUpInside)
        
        self.addTaskView.projectButton.addAction(UIAction { _ in
            self.categoryButtonTapped(checkbuttonState: .project)
        }, for: .touchUpInside)
        
        self.addTaskView.examButton.addAction(UIAction { _ in
            self.categoryButtonTapped(checkbuttonState: .exam)
        }, for: .touchUpInside)
        
        self.addTaskView.quizButton.addAction(UIAction { _ in
            self.categoryButtonTapped(checkbuttonState: .quiz)
        }, for: .touchUpInside)
        
        self.addTaskView.presentationButton.addAction(UIAction { _ in
            self.categoryButtonTapped(checkbuttonState: .presentation)
        }, for: .touchUpInside)
    }
    
    // 탭한 버튼의 Checkmark를 표시해주고, tempTask에 category 정보를 넣어줌
    private func categoryButtonTapped(checkbuttonState: ButtonState) {
        let categoryColors: [String: Int] = ["Blue":0x485DDA, "Lighter Green":0x44AF12, "Deeper Green":0x44AF12, "Sky Blue":0x3197F4, "Emerald":0x48BEC6]
        
        self.clearCheckMarks()
        switch checkbuttonState {
        case .initial:
            break
        case .assignment:
            self.addTaskView.assignBtnCheckBoxImageView.isHidden = false
            self.tempTask.tag = "과제"
            self.tempTask.color = categoryColors["Blue"] ?? 0xFFFFFF
        case .project:
            self.addTaskView.projectBtnCheckBoxImageView.isHidden = false
            self.tempTask.tag = "프로젝트"
            self.tempTask.color = categoryColors["Lighter Green"] ?? 0xFFFFFF
        case .exam:
            self.addTaskView.examBtnCheckBoxImageView.isHidden = false
            self.tempTask.tag = "시험준비"
            self.tempTask.color = categoryColors["Deeper Green"] ?? 0xFFFFFF
        case .quiz:
            self.addTaskView.quizBtnCheckBoxImageView.isHidden = false
            self.tempTask.tag = "퀴즈준비"
            self.tempTask.color = categoryColors["Sky Blue"] ?? 0xFFFFFF
        case .presentation:
            self.addTaskView.presentationCheckBoxImageView.isHidden = false
            self.tempTask.tag = "발표준비"
            self.tempTask.color = categoryColors["Emerald"] ?? 0xFFFFFF
        }
    }
    
    // 모든 체크박스를 해제하는 함수
    private func clearCheckMarks() {
        let checkMarkImageViews: [UIImageView] = [self.addTaskView.assignBtnCheckBoxImageView,
                                                  self.addTaskView.projectBtnCheckBoxImageView,
                                                  self.addTaskView.examBtnCheckBoxImageView,
                                                  self.addTaskView.quizBtnCheckBoxImageView,
                                                  self.addTaskView.presentationCheckBoxImageView]
        checkMarkImageViews.forEach { $0.isHidden = true }
    }
}

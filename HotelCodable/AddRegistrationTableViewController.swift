//
//  AddRegistrationTableViewController.swift
//  HotelCodable
//
//  Created by Nazrin Sultanlı on 15.01.25.
//

import UIKit

protocol SelectRoomTypeTableControllerDelegate: AnyObject {
    func selectRoomTypeTableController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType)
}

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableControllerDelegate {
  
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    
    @IBOutlet var chargesNumberOfNightsLabel: UILabel!
    @IBOutlet var chargesNumberOfNightsDetailLabel: UILabel!
    @IBOutlet var chargesRoomRateLabel: UILabel!
    @IBOutlet var chargesRoomTypeLabel: UILabel!
    @IBOutlet var chargesWifiRateLabel: UILabel!
    @IBOutlet var chargesWifiDetailLabel: UILabel!
    @IBOutlet var chargesTotalLabel: UILabel!
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var isCheckOutDatePickerVisible: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    var roomType: RoomType?


    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren,
                            wifi: hasWifi,
                            roomType: roomType)
    }
    var existingRegistration: Registration?
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let existingRegistration = existingRegistration {
//            title = "View Guest Registration"
//            doneButton.isEnabled = false
//            
//            roomType = existingRegistration.roomType
//            firstNameTextField.text = existingRegistration.firstName
//            lastNameTextField.text = existingRegistration.lastName
//            emailTextField.text = existingRegistration.emailAddress
//            checkInDatePicker.date = existingRegistration.checkInDate
//            checkOutDatePicker.date = existingRegistration.checkOutDate
//            numberOfAdultsStepper.value = Double(existingRegistration.numberOfAdults)
//            numberOfChildrenStepper.value = Double(existingRegistration.numberOfChildren)
//            wifiSwitch.isOn = existingRegistration.wifi
//        } else {
//            let midnightToday = Calendar.current.startOfDay(for: Date())
//            checkInDatePicker.minimumDate = midnightToday
//            checkInDatePicker.date = midnightToday
//        }
//        
//        let midNightToday = Calendar.current.startOfDay(for: Date())
//        checkInDatePicker.minimumDate = midNightToday
//        checkInDatePicker.date = midNightToday
//        updateDateViews()
//        updateNumberOfGuests()
//        updateRoomType()
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let existingRegistration = existingRegistration {
            title = "View Guest Registration"
            roomType = existingRegistration.roomType
            
            // Populate the fields with existing registration data
            firstNameTextField.text = existingRegistration.firstName
            lastNameTextField.text = existingRegistration.lastName
            emailTextField.text = existingRegistration.emailAddress
            checkInDatePicker.date = existingRegistration.checkInDate
            checkOutDatePicker.date = existingRegistration.checkOutDate
            numberOfAdultsStepper.value = Double(existingRegistration.numberOfAdults)
            numberOfChildrenStepper.value = Double(existingRegistration.numberOfChildren)
            wifiSwitch.isOn = existingRegistration.wifi
            
            // Update labels and views
            updateDateViews()
            updateNumberOfGuests()
            updateRoomType()
            updateChargesSection()
            
            // Disable "Done" button if just viewing
            doneButton.isEnabled = false
        } else {
            let midnightToday = Calendar.current.startOfDay(for: Date())
            checkInDatePicker.minimumDate = midnightToday
            checkInDatePicker.date = midnightToday
            
            // Update default views
            updateDateViews()
            updateNumberOfGuests()
            updateRoomType()
            updateChargesSection()
        }
    }

    func updateDateViews() {
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        
    }
 
    @IBAction func DateInPickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
        updateChargesSection()
    }
    
    @IBAction func DateOutPickerValueChanged(_ sender: Any) {
        updateDateViews()
        updateChargesSection()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
            return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return 190
        case checkOutDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
            // Check-in label selected, check-out picker is not visible, toggle check-in picker
            isCheckInDatePickerVisible.toggle()
        } else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
            // Check-out label selected, check-in picker is not visible, toggle check-out picker
            isCheckOutDatePickerVisible.toggle()
        } else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
            // Either label was selected, previous conditions failed meaning at least one picker is visible, toggle both
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        } else {
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func updateNumberOfGuests() {    numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    @IBAction func stepperValueChangedAdults(_ sender: UIStepper) {
        updateNumberOfGuests()
        updateChargesSection()
    }
    @IBAction func stepperValueChangedChildren(_ sender: UIStepper) {
        updateNumberOfGuests()
        updateChargesSection()
    }
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        updateChargesSection()
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
        doneButton.isEnabled = registration != nil && existingRegistration == nil
    }
    func selectRoomTypeTableController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
        updateChargesSection()
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        
        return selectRoomTypeController
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func updateChargesSection() {
        let dateComponents = Calendar.current.dateComponents([.day], from: checkInDatePicker.date, to: checkOutDatePicker.date)
        let numberOfNights = dateComponents.day ?? 0
        
        chargesNumberOfNightsLabel.text = "\(numberOfNights)"
        chargesNumberOfNightsDetailLabel.text = "\(checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)) - \(checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted))"
        
        let roomRateTotal: Int
        if let roomType = roomType {
            roomRateTotal = roomType.price * numberOfNights
            chargesRoomRateLabel.text = "$ \(roomRateTotal)"
            chargesRoomTypeLabel.text = "\(roomType.name) @ $\(roomType.price)/night"
        } else {
            roomRateTotal = 0
            chargesRoomRateLabel.text = "--"
            chargesRoomTypeLabel.text = "--"
        }
        
        
        let wifiTotal: Int
        if wifiSwitch.isOn {
            wifiTotal = 10 * numberOfNights
        } else {
            wifiTotal = 0
        }
        chargesWifiRateLabel.text = "$ \(wifiTotal)"
        chargesWifiDetailLabel.text = wifiSwitch.isOn ? "Yes" : "No"
        
        chargesTotalLabel.text = "$ \(roomRateTotal + wifiTotal)"
    }
    
}

//
//  ViewController.swift
//  IntroducePierre-Johnson
//
//  Created by Pierre Johnson on 12/20/22.
//

import UIKit

class ViewController: UIViewController {

    // outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var morePetsSwitch: UISwitch!
    @IBOutlet weak var classStandingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var decrementPetsButton: UIButton!
    @IBOutlet weak var incrementPetsButton: UIButton!
    @IBOutlet weak var petCountLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstName = defaults.string(forKey: "firstName") ?? ""
        let lastName = defaults.string(forKey: "lastName") ?? ""
        let schoolName = defaults.string(forKey: "schoolName") ?? ""
        let classStanding = defaults.integer(forKey: "classStanding")
        let petCount = defaults.string(forKey: "petCount") ?? "0"
        let morePets = defaults.bool(forKey: "morePets")
        
        // populate fields with stored data from user defaults
        firstNameTextField.text! = firstName
        lastNameTextField.text! = lastName
        schoolNameTextField.text! = schoolName
        classStandingSegmentedControl.selectedSegmentIndex = classStanding
        petCountLabel.text! = petCount
        morePetsSwitch.isOn = morePets
        
    }

    // update default fields when editing has ended for all fields
    @IBAction func editFirstName(_ sender: Any) {
        let text = firstNameTextField.text!
        
        defaults.set(text, forKey: "firstName")
    }
    
    @IBAction func editLastName(_ sender: Any) {
        let text = lastNameTextField.text!
            
        defaults.set(text, forKey: "lastName")
    }
    
    @IBAction func editSchoolName(_ sender: Any) {
        let text = schoolNameTextField.text!
        
        defaults.set(text, forKey: "schoolName")
    }
    
    @IBAction func selectClassStanding(_ sender: Any) {
        let standingIndex = classStandingSegmentedControl.selectedSegmentIndex
            
        defaults.set(standingIndex, forKey: "classStanding")
    }
    
    @IBAction func toggleMorePets(_ sender: Any) {
        let morePets = morePetsSwitch.isOn
            
        defaults.set(morePets, forKey: "morePets")
    }
    
    // down button decrements pet count label
    @IBAction func didTapDownButton(_ sender: UIButton!) {
        if (Int(petCountLabel.text!)! > 0) {
            let temp = petCountLabel.text!
            petCountLabel.text = String(Int(temp)! - 1)
        }
            
        let petCount = petCountLabel.text
            
        defaults.set(petCount, forKey: "petCount")
        
    }
    
    // up button increments pet count label
    @IBAction func upButtonDidTap(_ sender: UIButton!) {
        if (Int(petCountLabel.text!)! < 99) {
            let temp = petCountLabel.text!
            petCountLabel.text = String(Int(temp)! + 1)
        }
        
        let petCount = petCountLabel.text
        
        defaults.set(petCount, forKey: "petCount")
    }
    
    // introduce yourself generates introduction
    @IBAction func introduceSelfDidTap(_ sender: UIButton!) {
        var classStanding = "student"
        var petCountString = "I don't have any pets,"
        var morePetsString = "am not looking to adopt one!"
        
        // update class standing
        if (classStandingSegmentedControl.selectedSegmentIndex == 0) {
            classStanding = "freshman"
        } else if (classStandingSegmentedControl.selectedSegmentIndex == 1) {
            classStanding = "sophomore"
        } else if (classStandingSegmentedControl.selectedSegmentIndex == 2) {
            classStanding = "junior"
        } else if (classStandingSegmentedControl.selectedSegmentIndex == 3) {
            classStanding = "senior"
        }
        

        if (Int(petCountLabel.text!) == 0){
            if (morePetsSwitch.isOn){
                // update more pets string
                
                morePetsString = "am looking to adopt one!"
            }
        } else if (Int(petCountLabel.text!) == 1) {
            // update pet number
            
            petCountString = "I have a pet,"
            morePetsString = "am not looking to adopt another!"
            
            if (morePetsSwitch.isOn) {
                // update pets string
                
                morePetsString = "am looking to adopt another!"
            }
        } else {
            // update pet number
            petCountString = "I have \(petCountLabel.text!) pets,"
            morePetsString = "am not looking to adopt any more!"
            
            if (morePetsSwitch.isOn) {
                // update pets string
                
                morePetsString = "am looking to adopt more!"
                
            }
        }

        
        // generate filler for empty text fields
        if (firstNameTextField.text! == "") {
            firstNameTextField.text! = "FIRST NAME"
        }
        if (lastNameTextField.text! == "") {
            lastNameTextField.text! = "LAST NAME"
        }
        if (schoolNameTextField.text! == "") {
            schoolNameTextField.text! = "UNIVERSITY"
        }
        
        // update introduction
        let introduction = "My name is \(firstNameTextField.text!) \(lastNameTextField.text!) and I am a \(classStanding) at \(schoolNameTextField.text!). \(petCountString) and \(morePetsString)"
        
        // create alert to display generated introduction
        let alertController = UIAlertController(title: "My Introduction", message: introduction, preferredStyle: .alert)
        
        // allow dismissal of introduction alert
        let action = UIAlertAction(title: "Nice to meet you!", style: .default, handler: nil)
        
        // pass action to alert ocontroller to be dismissed
        alertController.addAction(action)
        
        present(alertController, animated:true, completion: nil)
    }
    
}

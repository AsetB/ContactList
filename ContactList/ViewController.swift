//
//  ViewController.swift
//  ContactList
//
//  Created by Aset Bakirov on 06.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var addSurname: UITextField!
    @IBOutlet weak var addNumber: UITextField!
    
    @IBAction func saveContact(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        let contactName = addName.text ?? ""
        let contactSurname = addSurname.text ?? ""
        let contactNumber = addNumber.text ?? ""
        
        var newContact = ContactItem()
        
        newContact.name = contactName
        newContact.surname = contactSurname
        newContact.telnumber = contactNumber
        
        do {
            if let data = defaults.data(forKey: "contactItemArray") {
                var array = try JSONDecoder().decode([ContactItem].self, from: data)
                
                array.append(newContact)
                
                let encodedata = try JSONEncoder().encode(array)
                
                defaults.set(encodedata, forKey: "contactItemArray")
            } else {
                let encodedata = try JSONEncoder().encode([newContact])
                
                defaults.set(encodedata, forKey: "contactItemArray")
            }
        }
        catch {
            print("unable to encode \(error)")
        }
        addName.text = ""
        addSurname.text = ""
        addNumber.text = ""
    }
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSurname: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    var contacts = ContactItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Вопрос по коду: пока не сделал ? nil-coalescing operator выкидывало fatal error на 62 строке, нужно понять почему так.
        labelName?.text = contacts.name
        labelSurname?.text = contacts.surname
        labelNumber?.text = contacts.telnumber
        
    }


}


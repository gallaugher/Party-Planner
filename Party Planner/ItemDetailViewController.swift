//
//  ItemDetailViewController.swift
//  Party Planner
//
//  Created by John Gallaugher on 3/19/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var personResponsibleField: UITextField!
    @IBOutlet weak var partyItemField: UITextField!
    
    var partyItem: PartyItemStruct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if partyItem == nil{
            partyItem.name = ""
            partyItem.personResponsible = ""
        }

        personResponsibleField.text = partyItem.personResponsible
        partyItemField.text = partyItem.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        partyItem.personResponsible = personResponsibleField.text!
        partyItem.name = partyItemField.text!
    }

    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

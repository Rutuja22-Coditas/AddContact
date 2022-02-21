//
//  AddPhoneViewController.swift
//  AddContact
//
//  Created by Coditas on 15/02/22.
//

import UIKit

struct categoryForSecondVC {
    var section : Int
    var arrayToPrint : [String]
    //var arrayToInsert : [String]
}
//protocol passSelectedName{
//    func setCheckMark(changeTextOf: String )
//}
class AddPhoneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var doneButtn: UIBarButtonItem!
    @IBOutlet weak var addPhoneTableView: UITableView!
    
    var firstSection = [String]()
    var secondSection = [String]()
    var checkmarkTo : String?
    var sectionsInListVC = [categoryForSecondVC]()
    //var delegate : passSelectedName?
    var sectionName : String = ""
    typealias completionHandler = ([String:Any])-> Void
    var callBack : completionHandler?
    var customLbl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButtn.isEnabled = false
        sectionsInListVC = [categoryForSecondVC(section: 0, arrayToPrint: firstSection), categoryForSecondVC(section: 1, arrayToPrint: secondSection)]
        
        addPhoneTableView.register(UINib(nibName: "AddCustomLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCustomLabelTableViewCell")
        
        addPhoneTableView.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
        addPhoneTableView.tableFooterView = UIView()
        addPhoneTableView.sectionFooterHeight = 50
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
        
//        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil)
//        navigationItem.rightBarButtonItem = editButton
//        editButton.isEnabled = false
        
        let cancelButtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtnTapped))
        navigationItem.leftBarButtonItem = cancelButtn
        
        
    }
    
    @objc func cancelButtnTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsInListVC.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsInListVC[section].arrayToPrint.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 0 {
            let cell = addPhoneTableView.dequeueReusableCell(withIdentifier: "AddCustomLabelTableViewCell") as? AddCustomLabelTableViewCell
            cell?.addCustomLbl.text = sectionsInListVC[indexPath.section].arrayToPrint[indexPath.row]
            return cell!
        }
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel!.font = UIFont.systemFont(ofSize: 18)
            cell?.textLabel?.text = sectionsInListVC[indexPath.section].arrayToPrint[indexPath.row]
        
        if cell?.textLabel?.text == checkmarkTo{
            cell?.accessoryType = .checkmark
        }
        else{
            cell?.accessoryType = .none
        }

        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerV = UIView()
        footerV.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0 )
        return footerV
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0{
            let currentCell = tableView.cellForRow(at: indexPath) as? AddCustomLabelTableViewCell
            
            tableView.deselectRow(at: indexPath, animated: true)
            doneButtn.isEnabled = true
            currentCell?.addCustomLbl.isHidden = true
            //currentCell?.txtField.isHidden = false
            //currentCell?.customLblWidthConstraint.constant = 500
            currentCell?.txtfieldWidthConstraint.constant = 680
           
            currentCell?.tag = indexPath.row
            
            customLbl = currentCell?.txtField.text
            
        }
        else{
        let currentCell = tableView.cellForRow(at: indexPath)
            currentCell?.accessoryType = .checkmark

        self.dismiss(animated: true, completion: nil)
        }
        //currentCell?.accessoryType = .checkmark
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let passDataArray = ["name": sectionsInListVC[indexPath.section].arrayToPrint[indexPath.row]] as [String : String]
        guard let completionBlk = self.callBack else {
            return
        }
        completionBlk(passDataArray)
    
        
    }
    
    
//    @objc func doneButtnClicked(sender:UIBarButtonItem){
//        addPhoneTableView.isEditing = !addPhoneTableView.isEditing
//        sender.title = (addPhoneTableView.isEditing) ? "Done":"Edit"
//        sectionsInListVC[1].arrayToPrint.append(customLbl!)
//        print(sectionsInListVC[1].arrayToPrint.append(customLbl!))
//
//        // addPhoneTableView.reloadData()
//        self.dismiss(animated: true, completion: nil)
//    }
   
    @IBAction func doneButtnClicked(_ sender: UIBarButtonItem) {
        let currentCell = addPhoneTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddCustomLabelTableViewCell
        //print(currentCell?.txtField.text!)
        addPhoneTableView.isEditing = !addPhoneTableView.isEditing
        sender.title = (addPhoneTableView.isEditing) ? "Done":"Edit"
        if customLbl != nil{
            DispatchQueue.main.async {
                self.sectionsInListVC[1].arrayToPrint.append((currentCell?.txtField.text!)!)
                self.addPhoneTableView.insertRows(at: [IndexPath(row: self.secondSection.count - 1, section: 1)], with: .automatic)
                
                let passDataArray = ["name": self.sectionsInListVC[1].arrayToPrint[self.secondSection.count - 1]] as [String : String]
                guard let completionBlk = self.callBack else {
                    return
                }
                completionBlk(passDataArray)
                //print(sectionsInListVC)
            }
            
        }
        //print("!!!",sectionsInListVC[1].arrayToPrint.append(customLbl!))
        
        // addPhoneTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            tableView.setEditing(true, animated: true)
        }
    }
    
}

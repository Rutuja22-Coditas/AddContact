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

    @IBOutlet weak var addPhoneTableView: UITableView!
    
    var firstSection = [String]()
    var secondSection = [String]()
    var checkmarkTo : String?
    var sectionsInListVC = [categoryForSecondVC]()
    //var delegate : passSelectedName?
    var sectionName : String = ""
    typealias completionHandler = ([String:Any])-> Void
    var callBack : completionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionsInListVC = [categoryForSecondVC(section: 0, arrayToPrint: firstSection), categoryForSecondVC(section: 1, arrayToPrint: secondSection)]
        
        addPhoneTableView.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
        addPhoneTableView.tableFooterView = UIView()
        addPhoneTableView.sectionFooterHeight = 50
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = editButton
        editButton.isEnabled = false
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel!.font = UIFont.systemFont(ofSize: 18)
        cell?.textLabel?.text = sectionsInListVC[indexPath.section].arrayToPrint[indexPath.row]
        
        
        if cell?.textLabel?.text == checkmarkTo{
            cell?.accessoryType = .checkmark
        }
        else{
            cell?.accessoryType = .none
        }
//        for i in sectionsInListVC[indexPath.section].arrayToPrint{
//            if i == checkmarkTo{
//                cell?.accessoryType = .checkmark
//            }
//        }
       
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerV = UIView()
        footerV.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0 )
        return footerV
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        print("selectedRowIS", sectionsInListVC[indexPath.section].arrayToPrint[indexPath.row])
        self.dismiss(animated: true, completion: nil)

        //currentCell?.accessoryType = .checkmark
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let passDataArray = ["name": sectionsInListVC[indexPath.section].arrayToPrint[indexPath.row]] as [String : String]
        print("passdata",passDataArray)
        guard let completionBlk = self.callBack else {
            return
        }
        completionBlk(passDataArray)
        currentCell?.accessoryType = .checkmark

        //delegate?.setCheckMark(changeTextOf: sectionsInListVC[indexPath.section].arrayToPrint[indexPath.row])
//        let doneButtn = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
//        addPhoneTableView.deselectRow(at: indexPath, animated: true)
//        let selectedCell = addPhoneTableView.cellForRow(at: indexPath)
//        if selectedCell?.textLabel?.text == "Add Custom Label"{
//            selectedCell?.isEditing = true
//            navigationItem.rightBarButtonItem = doneButtn
//        }
        
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

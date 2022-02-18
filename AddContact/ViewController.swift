//
//  ViewController.swift
//  AddContact
//
//  Created by Coditas on 13/02/22.
//

import UIKit

var details = [Contact]()
var txtFData = [basicDetails]()

struct category {
    var sectionName : String
    var items : [String]
    var dataToPrint : [String]

}
var sections = [category]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PassCountryName{
    
    
    var checkmark : String?
  
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButtn: UIBarButtonItem!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        doneButtn.isEnabled = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        tableView.sectionFooterHeight = 50
        tableView.register(UINib(nibName: "AddTableViewCell", bundle: nil), forCellReuseIdentifier: "AddTableViewCell")
        tableView.register(UINib(nibName: "AddPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "AddPhoneTableViewCell")
        tableView.register(UINib(nibName: "AddAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddAddressTableViewCell")
        
        sections = [category(sectionName: "TextFields", items: placeHolderForTxtF, dataToPrint: ["ok"]), category(sectionName: "Phone", items: addPhone, dataToPrint: phoneNumberOf),category(sectionName: "Email", items: addEmail, dataToPrint: emailIdOf), category(sectionName: "Address", items: addAddress, dataToPrint: addressOf)]
        
//        sectionsToprint = [buttonCategories(index: "Add Phone", dataToPrint: phoneNumberOf),buttonCategories(index: "Add Email", dataToPrint: addEmail), buttonCategories(index: "Add Address", dataToPrint: addAddress)]
        
        tableView.isEditing = true
        
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerV = UIView()
        footerV.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 2.0)
        return footerV
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    var txtFields = [UITextField]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TxtFTableViewCell
        cell?.txtField.tag = indexPath.row
            cell?.txtField.placeholder = sections[indexPath.section].items[indexPath.row]
            
                   return cell!
        }
        
        if indexPath.row == sections[indexPath.section].items.count - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddTableViewCell", for: indexPath) as? AddTableViewCell
            cell?.addPhoneButton.setTitle(sections[indexPath.section].items[indexPath.row], for: .normal)
            return cell!
        }
       
        
        else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressTableViewCell", for: indexPath) as? AddAddressTableViewCell
            cell?.countryTap = {
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "CountryViewController") as? CountryViewController
                let navigationController = UINavigationController(rootViewController: newVC!)
                newVC?.delegate = self
                newVC?.index = indexPath
                cell?.addressOfButtn.setTitle(self.checkmark, for: .normal)
                self.present(navigationController, animated: true, completion: nil)
            }
            cell?.tapblock = {
                let newvc = self.storyboard?.instantiateViewController(withIdentifier: "AddPhoneViewController") as? AddPhoneViewController
                newvc?.firstSection = addressOf
                newvc?.secondSection = insertData
                newvc?.checkmarkTo = sections[indexPath.section].dataToPrint[indexPath.row]
                print("passingData",sections[indexPath.section].dataToPrint[indexPath.row])
                //cell?.addressOfButtn.setTitle(self.checkmark, for: .normal)
                
                newvc?.callBack = { passDataArray in
                    sections[indexPath.section].dataToPrint.remove(at: indexPath.row)
                    sections[indexPath.section].dataToPrint.insert(passDataArray["name"] as! String, at: indexPath.row)
                cell?.addressOfButtn.setTitle(passDataArray["name"] as? String, for: .normal)
                    print("!!!!!!!!!!!!!!",passDataArray["name"]!)
                }
                let navController = UINavigationController(rootViewController: newvc!)
                self.present(navController, animated:true, completion: nil)
                
            }
            
            if indexPath.row < sections[indexPath.section].dataToPrint.count{
                cell?.addressOfButtn.setTitle(sections[indexPath.section].dataToPrint[indexPath.row], for: .normal)
            }
            else{
                cell?.addressOfButtn.setTitle(sections[indexPath.section].dataToPrint.first, for: .normal)
            }
            return cell!
        }
        
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPhoneTableViewCell", for: indexPath) as? AddPhoneTableViewCell
            //cell?.editingAccessoryType = .disclosureIndicator
            
            cell?.phoneTxtF.placeholder = sections[indexPath.section].sectionName
            cell?.tapBlock = {
                let newvc = self.storyboard?.instantiateViewController(withIdentifier: "AddPhoneViewController") as? AddPhoneViewController
                if indexPath.section == 1{
                    newvc?.firstSection = phoneNumberOf
                }
                else if indexPath.section == 2{
                    newvc?.firstSection = emailIdOf
                }
                
                newvc?.secondSection = insertData

                newvc?.checkmarkTo = sections[indexPath.section].dataToPrint[indexPath.row]
                
                newvc?.callBack = { passDataArray in
                    sections[indexPath.section].dataToPrint.remove(at: indexPath.row)
                    sections[indexPath.section].dataToPrint.insert(passDataArray["name"] as! String, at: indexPath.row)
                cell?.selectPhoneButtn.setTitle(passDataArray["name"] as? String, for: .normal)
                    print("!!!!!!!!!!!!!!",passDataArray["name"]!)
                    
                }
                //cell?.selectPhoneButtn.setTitle(self.checkmark, for: .normal)
                //tableView.reloadData()

                let navController = UINavigationController(rootViewController: newvc!)
                self.present(navController, animated:true, completion: nil)
                
            }
            if indexPath.row < sections[indexPath.section].dataToPrint.count{
                cell?.selectPhoneButtn.setTitle(sections[indexPath.section].dataToPrint[indexPath.row], for: .normal)
            }
            else{
                cell?.selectPhoneButtn.setTitle(sections[indexPath.section].dataToPrint.first, for: .normal)
            }
           
            return cell!
        }
       // return UITableViewCell()
    
}
    
    func setCountryName(countryName: String, indexP: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexP) as? CountryTableViewCell
        print("countryName",countryName)
        currentCell?.countryLbl.text = countryName
    }
    
   
    func setCheckMark(changeTextOf : String) {
        checkmark = changeTextOf
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TxtFTableViewCell
//            cell?.txtField.tag = indexPath.row
//            cell?.txtField.placeholder = placeHolderForTxtF[indexPath.row]
//            return cell!
//        }
//
//        else if indexPath.section == 1{
//
//            if indexPath.row == addPhone.count - 1  {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "AddTableViewCell", for: indexPath) as? AddTableViewCell
//                cell?.addPhoneButton.setTitle(addPhone[indexPath.row], for: .normal)
//                cell?.addPhoneButton.addTarget(self, action: #selector(addPhoneButtnClicked), for: .touchUpInside)
//                return cell!
//            }
//            else{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "AddPhoneTableViewCell", for: indexPath) as? AddPhoneTableViewCell
//                cell?.selectPhoneButtn.addTarget(self, action: #selector(phonePlace), for: .touchUpInside)
//                if indexPath.row < phoneNumberOf.count {
//                    //print("\(indexPath.row)",phoneFrom[indexPath.row])
//                    print("addPhone",addPhone)
//                    cell?.selectPhoneButtn.setTitle(phoneNumberOf[indexPath.row], for: .normal)
//                }
//                else{
//                    cell?.selectPhoneButtn.setTitle("mobile", for: .normal)
//
//                }
//                return cell!
//            }
//        }
//        return UITableViewCell()
//    }

    @objc func addPhoneButtnClicked(){
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .none
        }
        else{
            if indexPath.row == sections[indexPath.section].items.count - 1{
                return .insert
            }
            else{
                return .delete
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            sections[indexPath.section].items.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .left)
            tableView.reloadData()
        }
        if editingStyle == .insert{
            sections[indexPath.section].items.insert("\(indexPath.row+1)", at: 0)
            tableView.insertRows(at: [IndexPath(row: 0, section: indexPath.section)], with: .automatic)
            tableView.reloadData()
        }
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            addPhone.remove(at: indexPath.row)
//            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 1)], with: .left)
//            tableView.reloadData()
//        }
//        if editingStyle == .insert{
//            addPhone.insert("add Phone \(indexPath.row+1)", at: 0)
//            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .bottom)
//                tableView.reloadData()
//        }
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete){
//            addPhone.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.reloadData()
//            print(addPhone)
//        }
//        if editingStyle == .insert{
//            addPhone.insert("add Phone \(indexPath.row+1)", at: addPhone.count-1)
//            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .bottom)
//            tableView.reloadData()
//        }
//
//    }

    
    
//    @objc func phonePlace(){
////        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//               let newvc = self.storyboard?.instantiateViewController(withIdentifier: "AddPhoneViewController") as? AddPhoneViewController
//
//              let navController = UINavigationController(rootViewController: newvc!)
//               self.present(navController, animated:true, completion: nil)
//    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
//
//        addPhone.insert("add Phone \(indexPath.row+1)", at: addPhone.count-1)
//        tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .bottom)
//        tableView.reloadData()
////        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
////        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "AddPhoneViewController") as? AddPhoneViewController
////        let navController = UINavigationController(rootViewController: newvc!)
////        self.present(navController, animated:true, completion: nil)
////        if let newVC = self.storyboard?.instantiateViewController(withIdentifier: "AddPhoneViewController") as? AddPhoneViewController{
////            //present(newVC, animated: true, completion: nil)
////            self.navigationController?.pushViewController(newVC, animated: true)
////        }
//

//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 3{
//            tableView.rowHeight = UITableView.automaticDimension
//            tableView.estimatedRowHeight = 270
//            return 55
//        }
//        else{
//
//            return 55
//        }
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if  indexPath.section == 3{
//            if indexPath.row == indexPath.last {
//                return 55
//            }
//            else{
//                if indexPath.row == indexPath.first{
//                    return 200
//                }
//            }
//        }
//        return 55
//        //return UITableView.automaticDimension
//    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        for i in txtFields{
            if i.text!.count >= 1{
                doneButtn.isEnabled = true
            }
            else{
                doneButtn.isEnabled = false
            }
        }
        return true
    }
    
}


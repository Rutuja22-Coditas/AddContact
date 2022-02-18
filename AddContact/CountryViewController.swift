//
//  CountryViewController.swift
//  AddContact
//
//  Created by Coditas on 17/02/22.
//

import UIKit

struct Section {
    var letter : String
    var countries : [String]
}

protocol PassCountryName {
    func setCountryName(countryName: String, indexP : IndexPath)
}
class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancelButtonCliked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    var country = [Section]()
    var delegate : PassCountryName?
    var index : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        var countries = [String]()
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
            
            let groupedDictionary = Dictionary(grouping: countries, by: {String($0.prefix(1))})
            let keys = groupedDictionary.keys.sorted()
            country = keys.map{ Section(letter: $0, countries: groupedDictionary[$0]!.sorted()) }
            
            tableView.sectionHeaderHeight = 50
            tableView.rowHeight = 50
            self.tableView.reloadData()
        }
       

    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryTableViewCell
            cell?.countryLbl.text = country[indexPath.section].countries[indexPath.row]
            
            return cell!
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return country[section].countries.count
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return country.count
        }

        func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            return country.map{$0.letter}
        }

        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return country[section].letter
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let currentCell = tableView.cellForRow(at: indexPath) as? CountryTableViewCell
        currentCell?.checkmarkImg.image = UIImage(systemName: "checkmark")
        delegate?.setCountryName(countryName: country[indexPath.section].countries[indexPath.row], indexP: index!)
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.accessoryType = .none
        let currentCell = tableView.cellForRow(at: indexPath) as? CountryTableViewCell
        currentCell?.checkmarkImg.image = nil
    }
   

}

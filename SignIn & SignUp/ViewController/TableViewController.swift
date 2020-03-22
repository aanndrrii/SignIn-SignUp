//
//  TableViewController.swift
//  SignIn & SignUp
//
//  Created by Andrii on 3/13/20.
//  Copyright © 2020 Andrii. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addFieldTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var tableData:Array = [["Downloading data..."], []]
    let headerTitles = ["Data downloaded from the API", "Manualy entered data"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        addButton.layer.cornerRadius = 5
        
        let requestURL: NSURL = NSURL(string:  "http://names.drycodes.com/10")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest as URLRequest) {(data, response, error) -> Void in

          let httpResponse = response as! HTTPURLResponse
          let statusCode = httpResponse.statusCode

          if (statusCode == 200) {
            print("Everyone is fine, file downloaded successfully.")
            var result = String(data: data!, encoding: .utf8)!
            result = String(result.dropLast(2))
            result = String(result.dropFirst(2))
            self.tableData[0] = result.components(separatedBy: "\",\"")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
          } else  {
            self.tableData[0][0] = "Failed to download data..."
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
          }
        }
        task.resume()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    @IBAction func editButtonDidClick(_ sender: UIButton) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBAction func logOutButtonDidClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonDidClick(_ sender: UIButton) {
        if addFieldTextField.text! == "" {
            return
        }
        tableData[1].append(addFieldTextField.text!)
        tableView.reloadData()
        addFieldTextField.text = ""
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        cell.textLabel!.text = tableData[indexPath.section][indexPath.row]
        return cell;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableData[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
            view.endEditing(true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = tableData[sourceIndexPath.section][sourceIndexPath.row]
        tableData[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        tableData[destinationIndexPath.section].insert(movedObject, at: destinationIndexPath.row)
    }
    
}


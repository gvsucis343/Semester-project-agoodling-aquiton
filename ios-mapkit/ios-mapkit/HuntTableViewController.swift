//
//  HuntTableViewController.swift
//  ios-mapkit
//
//  Created by Alex Quiton on 12/6/23.
//

import Foundation
import UIKit

protocol HuntTableViewControllerDelegate{
    func hasSelected(entry: ScavengerHunts)
    func pressedCreate(entry: Bool, hunt: ScavengerHunts)
}


var hunts: [ScavengerHunts] = []



class HuntTableViewController: UITableViewController{
 
  
    //var hunts: [ScavengerHunts] = []
    @IBOutlet var huntViewTable: UITableView!
    var newHuntName: String?
    var huntCreated: ScavengerHunts!
    var huntDelegate: HuntTableViewControllerDelegate?

    
    @IBAction func createHunt(_ sender: UIBarButtonItem) {
                
        
        // Create an alert controller
               let alertController = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
               
               // Add a text field to the alert controller
               alertController.addTextField { (textField) in
                   textField.placeholder = "Name"
               }
               
               // Add a "OK" button to the alert controller
               let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                   // Get the text from the text field
                   if let name = alertController.textFields?.first?.text {
                       // Assign the entered name to the variable
                       self.newHuntName = String(name)
                       let newHunt: ScavengerHunts = ScavengerHunts(name: self.newHuntName ?? "")
                       if(newHunt.huntName != ""){
                           self.huntDelegate?.pressedCreate(entry: false, hunt: newHunt)
                           self.dismiss(animated: true)
                       }
                   }
               }
               
               // Add a "Cancel" button to the alert controller
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               
               // Add the actions to the alert controller
               alertController.addAction(okAction)
               alertController.addAction(cancelAction)
               
               // Present the alert controller
               present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    var tableViewData: [(sectionHeader: String, entries: [ScavengerHunts])] = [] {
            didSet {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        if(hunts.count == 0){
            let newHunt: ScavengerHunts = ScavengerHunts(name: "GrandRapids")
            let newHunt2: ScavengerHunts = ScavengerHunts(name: "Test")
            
            newHunt.CreatePin(lat: 42.9634, long: -85.6681, pinName: "GR")
            newHunt.CreatePin(lat: 43, long: -84, pinName: "Random")
            newHunt2.CreatePin(lat: 30, long: -80, pinName: "Test")
            
            hunts.append(newHunt)
            hunts.append(newHunt2)
        }
       
    }
    
    func updateScavengerHunts(){
        hunts.append(huntCreated)
    }
    
    func checkHunts(){
        for hunt in hunts{
            var completed: Int = 0
            for annotation in hunt.annotations{
                if(annotation.subtitle == "Done"){
                    completed += 1
                }
            }
            if(completed == hunt.annotations.count){
                hunt.huntProgress = "Done"
            }
        }
                    
    }
    

    
    //displays cells in table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID" )
        
        
        cell?.textLabel?.text = hunts[indexPath.row].huntName
        cell?.detailTextLabel?.text = hunts[indexPath.row].huntProgress
        
        
        return cell!
    }
   
    //used for delegation
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hunts.count
    }
    
  
    
}

//delegation
extension HuntTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        huntDelegate?.hasSelected(entry: hunts[indexPath.row])
        dismiss(animated: true)
    }
    
    
}


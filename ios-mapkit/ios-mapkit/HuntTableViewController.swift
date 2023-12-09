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
}

class HuntTableViewController: UITableViewController{
 
  
    
    @IBOutlet var huntViewTable: UITableView!

    
    
    @IBAction func createButton(_ sender: UIButton) {
        
        
        
        dismiss(animated: true)
    }
    
    
    
    var huntDelegate: HuntTableViewControllerDelegate?
    
    var hunts: [ScavengerHunts] = []
    var newHunt: ScavengerHunts = ScavengerHunts(name: "GrandRapids")
    var newHunt2: ScavengerHunts = ScavengerHunts(name: "Test")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newHunt.CreatePin(lat: 42.9634, long: -85.6681, pinName: "GR")
        newHunt.CreatePin(lat: 43, long: -84, pinName: "Random")
        newHunt2.CreatePin(lat: 30, long: -80, pinName: "Test")
        
        hunts.append(newHunt)
        hunts.append(newHunt2)
    }
    
//    var tableViewData: [(sectionHeader: String, entries: [ScavengerHunts])]? {
//        didSet{
//            DispatchQueue.main.async{
//                self.tableView.reloadData()
//            }
//        }
//    }
    
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


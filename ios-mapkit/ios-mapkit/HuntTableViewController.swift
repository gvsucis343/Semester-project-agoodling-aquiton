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
    
  
    var huntDelegate: HuntTableViewControllerDelegate?
    
    var hunts: [ScavengerHunts] = []
    var newHunt: ScavengerHunts = ScavengerHunts(latitudes: [42.9634, 42.8], longitudes: [-85.6681,-85.7], huntName: "GrandRapids")
    var newHunt2: ScavengerHunts = ScavengerHunts(latitudes: [30], longitudes: [-80], huntName: "Test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hunts.append(newHunt)
        hunts.append(newHunt2)
    }
    
    var tableViewData: [(sectionHeader: String, entries: [ScavengerHunts])]? {
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    //displays cells
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

extension HuntTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        huntDelegate?.hasSelected(entry: hunts[indexPath.row])
        dismiss(animated: true)
    }
}


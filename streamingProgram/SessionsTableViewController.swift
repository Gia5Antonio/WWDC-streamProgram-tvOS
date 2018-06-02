//
//  SessionsTableViewController.swift
//  streamingProgram
//
//  Created by Antonio Giaquinto on 01/06/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class SessionsTableViewController: UITableViewController {

    var timer: Timer?
    var seconds = Int()
    
    let formatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "hh:mm a"
        return tmpFormatter
    }()
    
    let timeLabel = UILabel()

    let dateFormatter = DateFormatter().string(from: Date() as Date)

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController?.navigationBar
        let firstFrame = CGRect(x: (navigationBar?.frame.width)!/7, y: 0, width: (navigationBar?.frame.width)!/2, height: (navigationBar?.frame.height)!)
        timeLabel.frame = firstFrame
        
        timeLabel.text = DataSource.shared.timeString
        navigationBar?.addSubview(timeLabel)
        
        runTimer()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(checkLabel)), userInfo: nil, repeats: true)
    }
    
    @objc func checkLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        DataSource.shared.timeString = dateFormatter.string(from: Date() as Date)
        timeLabel.text = DataSource.shared.timeString
        seconds += 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        debugPrint("Number of Times")
        switch section {
        case 0:
            debugPrint("LIVE NOW")
            return 5
        case 1:
            debugPrint("UP NEXT")
            return 5
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            debugPrint("LIVE NOW")
            return "LIVE NOW"
        case 1:
            debugPrint("UP NEXT")
            return "UP NEXT"
        default:
            return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SessionsTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.layer.cornerRadius = cell.frame.height / 4
            cell.layer.masksToBounds = true
            return cell
        }
        cell.layer.cornerRadius = cell.frame.height / 4
        cell.layer.masksToBounds = true
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

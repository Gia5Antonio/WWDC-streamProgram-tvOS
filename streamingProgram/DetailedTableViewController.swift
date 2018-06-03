//
//  DetailedTableViewController.swift
//  streamingProgram
//
//  Created by Antonio Giaquinto on 01/06/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class DetailedTableViewController: UITableViewController {
    var timer = Timer()
    var second = 0
    
    var rulesDescription: [String] = []
    var rulesResponsible: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rulesDescription = ["Lab 1 is reserved as a quiet space, please avoid disruptions", "No food or drinks are allowed in the Seminar.", "Handling of food and drinks is limited to the Kitchen.", "As always, tidy up every space, leave it better than you found it.", "Don’t have open containers close to the sofas to prevent spillages.", "After 7pm we only leave the academy in groups of 5 or more people, the more the merrier. Groups gather at the welcome desk 15 minutes before each train’s departure time. Train departure timetables are available in Collab 1"]
        rulesResponsible = ["Use of spaces", "Food and Drinks", "Food and Drinks", "Food and Drinks", "Food and Drinks", "Security"]
        
        
        let today = Date()
        let weekday = Calendar.current.component(.weekday, from: today)
        let month = Calendar.current.component(.month, from: today)
        let date = Calendar.current.component(.day, from: today)

        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            let secondFrame = CGRect(x: navigationBar.frame.width/1.3, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            
            let titleLabel = UILabel(frame: firstFrame)
            titleLabel.text = "Apple Academy WWDC Week"
            
            let dateLabel = UILabel(frame: secondFrame)
            dateLabel.text = "\(Calendar.current.weekdaySymbols[weekday-1]), \(date) \(Calendar.current.shortMonthSymbols[month-1])"
            
            navigationBar.addSubview(titleLabel)
            navigationBar.addSubview(dateLabel)
        }
//        tableViewScrollToBottom(animated: true)
        
        runTimer()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRows(inSection: numberOfSections-1)

            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func runTimerMovSti() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(runTimers)), userInfo: nil, repeats: true)
    }
    
    @objc func runTimer() {
        second += 1
        debugPrint("Timer Called")
//        tableViewScrollToBottom(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        debugPrint("Number of Times News")
        switch section {
        case 0:
            debugPrint("News")
            return 3
        case 1:
            debugPrint("Rules")
            return rulesDescription.count
        case 2:
            debugPrint("Reminders")
            return 5
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            debugPrint("News")
            return "News"
        case 1:
            debugPrint("Rules")
            return "Rules"
        case 2:
            debugPrint("Reminders")
            return "Reminders"
        default:
            return " "
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailedTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
            return cell
        }
        
        switch indexPath.section {
        case 0:
            cell.descriptionLabel.text = "NO"
            cell.responsibleLabel.text = "NO"
        case 1:
            cell.descriptionLabel.text = rulesDescription[indexPath.row]
            cell.responsibleLabel.text = rulesResponsible[indexPath.row]
            cell.timerLabel.text = "Always"
        case 2:
            cell.descriptionLabel.text = "NO"
            cell.responsibleLabel.text = "NO"
        default:
            cell.descriptionLabel.text = "NO"
            cell.responsibleLabel.text = "NO"
        }
        
        // Configure the cell...
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

extension UITableView {
    func scrollToBottom() {
        let rows = self.numberOfRows(inSection: 0)
        
        let indexPath = IndexPath(row: rows - 1, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

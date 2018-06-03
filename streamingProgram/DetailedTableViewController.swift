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
    
    let myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rulesDescription = ["Lab 1 is reserved as a quiet space, please avoid disruptions", "No food or drinks are allowed in the Seminar.", "Handling of food and drinks is limited to the Kitchen.", "As always, tidy up every space, leave it better than you found it.", "Don’t have open containers close to the sofas to prevent spillages.", "After 7pm we only leave the academy in groups of 5 or more people, the more the merrier. Groups gather at the welcome desk 15 minutes before each train’s departure time. Train departure timetables are available in Collab 1"]
        rulesResponsible = ["Use of spaces", "Food and Drinks", "Food and Drinks", "Food and Drinks", "Food and Drinks", "Security"]
        
        let today = Date()
        let weekday = Calendar.current.component(.weekday, from: today)
        let month = Calendar.current.component(.month, from: today)
        let date = Calendar.current.component(.day, from: today)

        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width/1.5, height: navigationBar.frame.height)
            let secondFrame = CGRect(x: navigationBar.frame.width/1.3, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            
            let titleLabel = UILabel(frame: firstFrame)
            titleLabel.textColor = .white
            titleLabel.text = "Apple Developer Academy WWDC Week"
            
            let dateLabel = UILabel(frame: secondFrame)
            dateLabel.textColor = .white
            dateLabel.text = "\(Calendar.current.weekdaySymbols[weekday-1]), \(date) \(Calendar.current.shortMonthSymbols[month-1])"
            
            navigationBar.addSubview(titleLabel)
            navigationBar.addSubview(dateLabel)
        }
        
//        tableView.scroll()
        scroll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scroll() {
        tableView.reloadData()
//        myGroup.enter()
//        UIView.animate(withDuration: Double(self.tableView.numberOfRows(inSection: 0))*2.0, animations: {
//            let rows = self.tableView.numberOfRows(inSection: 0)
//            let indexPath = IndexPath(row: rows - 1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//        })
//        myGroup.leave()
//        myGroup.enter()
//        UIView.animate(withDuration: Double(self.tableView.numberOfRows(inSection: 1))*2.0, animations: {
//            let rows1 = self.tableView.numberOfRows(inSection: 1)
//            let indexPath1 = IndexPath(row: rows1 - 1, section: 1)
//            self.tableView.scrollToRow(at: indexPath1, at: .bottom, animated: true)
//        })
//        myGroup.leave()
//        myGroup.enter()
//        UIView.animate(withDuration: Double(self.tableView.numberOfRows(inSection: 2))*2.0, animations: {
//            let rows2 = self.tableView.numberOfRows(inSection: 2)
//            let indexPath2 = IndexPath(row: rows2 - 1, section: 2)
//            self.tableView.scrollToRow(at: indexPath2, at: .bottom, animated: true)
//        })
//        myGroup.leave()
        myGroup.enter()
        UIView.animate(withDuration: Double(self.tableView.numberOfRows(inSection: 2))*2.0, animations: {
            let rows = self.tableView.numberOfRows(inSection: 2)
            let indexPath = IndexPath(row: rows - 1, section: 2)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            self.myGroup.leave()
        })
        
        myGroup.enter()
        UIView.animate(withDuration: Double(self.tableView.numberOfRows(inSection: 1))*2.0, animations: {
            let rows1 = self.tableView.numberOfRows(inSection: 1)
            let indexPath1 = IndexPath(row: rows1 - 1, section: 1)
            self.tableView.scrollToRow(at: indexPath1, at: .top, animated: true)
            self.myGroup.leave()
        })
        
        myGroup.enter()
        UIView.animate(withDuration: Double(self.tableView.numberOfRows(inSection: 0))*2.0, animations: {
            let rows2 = self.tableView.numberOfRows(inSection: 0)
            let indexPath2 = IndexPath(row: rows2 - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath2, at: .top, animated: true)
            self.myGroup.leave()
        })
        
        myGroup.notify(queue: DispatchQueue.main){
            debugPrint("All done")
        }
//        myGroup.notify(queue: DispatchQueue.main) {
//            debugPrint("main")
//            UIView.animate(withDuration: 10.0, animations: {
//                let rows = self.tableView.numberOfRows(inSection: 0)
//                let indexPath = IndexPath(row: rows - 1, section: 0)
//
//                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            })
//
//        }
    }
    
    func runTimerM() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(runTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func runTimer() {
        second += 1
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
            return "News"
        case 1:
            return "Rules"
        case 2:
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
}

extension UITableView {
    func scroll() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 10.0, animations: {
                let rows = self.numberOfRows(inSection: 2)
                let indexPath = IndexPath(row: rows - 1, section: 2)

                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
                
                self.scrollToRow(at: indexPath, at: .top, animated: true)
            })
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
//            UIView.animate(withDuration: 10.0, animations: {
//                let rows = self.numberOfRows(inSection: 0)
//                let indexPath = IndexPath(row: rows - 1, section: 0)
//
//                self.scrollToRow(at: indexPath, at: .top, animated: true)
//            })
//        }
//        UIView.animate(withDuration: 10.0, animations: {
//            let rows = self.numberOfRows(inSection: 0)
//            let indexPath = IndexPath(row: rows - 1, section: 0)
//            self.scrollToRow(at: indexPath, at: .top, animated: true)
//        })
    }
    
//    func scrollToBottom() {
//        let rows = self.numberOfRows(inSection: 2)
//        let indexPath = IndexPath(row: rows - 1, section: 2)
//
//        self.scrollToRow(at: indexPath, at: .bottom, animated: true)
//    }
}

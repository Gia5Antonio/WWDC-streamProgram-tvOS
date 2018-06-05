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
  var secondTimer = Timer()
  var second = 0
  let dummyCount = 3
  
  var rulesDescription: [String] = []
  var rulesResponsible: [String] = []
  var trains: [Event] = []
  
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
    
    tableView.decelerationRate = UIScrollViewDecelerationRateNormal
    
    loadTrains()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    secondTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(startScrolling), userInfo: nil, repeats: true)
  }
  
  func loadTrains() {
    let events = loadEvents()
    
    for event in events {
      if(event.tag == "Train"){
        trains.append(event)
      }
    }
  }
  
  var isOnBottom: Bool = false
  var currentRow: Int = 0
  var currentSection: Int = 0
  
  @objc func startScrolling() {
    
    var calculatedIndexPath = IndexPath()
    
    if isOnBottom {
      calculatedIndexPath = tableView.indexPath(for: tableView.visibleCells.first!)!
    } else {
      calculatedIndexPath = tableView.indexPath(for: tableView.visibleCells.last!)!
    }
    
    let lastSection = tableView.numberOfSections - 1
    let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
    
    if calculatedIndexPath == IndexPath(row: lastRow, section: lastSection) {
      isOnBottom = true
    } else if calculatedIndexPath == IndexPath(row: 0, section: 0) {
      isOnBottom = false
    }
    
    self.tableView.scrollToRow(at: calculatedIndexPath, at: isOnBottom ? .bottom : .top, animated: true)
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
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    switch section {
    case 0:
      debugPrint("Trains")
      return trains.count
    case 1:
      debugPrint("Rules")
      return rulesDescription.count
    default:
      return 0
    }
  }
  
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Trains"
    case 1:
      return "Rules"
    default:
      return " "
    }
  }
  
  let trainNames: [String] = ["Pozzuoli", "Campi Flegrei", "Salerno"]
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailedTableViewCell else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
      return cell
    }
    
    let train = trains[indexPath.row]
    
    switch indexPath.section {
    case 0:
        cell.responsibleLabel.text = "Destination: \(trainNames[train.day])"
        if train.startingHour < 10 {
          cell.descriptionLabel.text = "Meeting time at Welcome Desk \(train.startingHour):0\(train.startingMinute)"
          cell.timerLabel.text = "\(train.endingHour):0\(train.endingMinute)"
        } else {
          cell.descriptionLabel.text = "Meeting time at Welcome Desk \(train.startingHour):\(train.startingMinute)"
          cell.timerLabel.text = "\(train.endingHour):\(train.endingMinute)"
        }
    case 1:
      cell.descriptionLabel.text = rulesDescription[indexPath.row]
      cell.responsibleLabel.text = rulesResponsible[indexPath.row]
      cell.timerLabel.text = "Always"
      
    default:
      cell.descriptionLabel.text = "NO"
      cell.responsibleLabel.text = "NO"
    }
    
    // Configure the cell...
    cell.layer.cornerRadius = cell.frame.height / 4
    cell.layer.masksToBounds = true
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200.0
  }
}

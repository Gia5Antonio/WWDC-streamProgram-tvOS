//
//  SessionsTableViewController.swift
//  streamingProgram
//
//  Created by Antonio Giaquinto on 01/06/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class SessionsTableViewController: UITableViewController {

    var labelTimer: Timer?
  var startEventsTimer: Timer?
  var sessionTimer: Timer?
    var seconds = Int()
  var dailyEvents: [Event] = []
  var liveEvents: [Event] = []
  var nextEvents: [Event] = []
 
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
        
        timeLabel.textColor = .white
        timeLabel.frame = firstFrame
        
        timeLabel.text = DataSource.shared.timeString
        navigationBar?.addSubview(timeLabel)
      
      loadDailyEvents()
      
      checkLiveNextEvents()
      
      runTimers()
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
      
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func runTimers() {
      labelTimer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(checkLabel)), userInfo: nil, repeats: true)
    }
  
  func loadDailyEvents() {
    let events = loadEvents()
    
    let todayDate = NSDate()
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    guard let dayWeek = calendar?.component(.weekday, from: todayDate as Date) else { return }
    let day = dayWeek - 2
    let weekOfYear = calendar?.component(.weekOfYear, from: todayDate as Date)
    if(weekOfYear == 23 ) {
      let hour = calendar?.component(.hour, from: todayDate as Date)
      let minute = calendar?.component(.minute, from: todayDate as Date)
      for event in events {
        if(event.tag != "Train") {
          if(event.day == day && event.endingHour >= hour! ) {
            if(event.endingHour == hour!){
              if(event.endingMinute >= minute!) {
                dailyEvents.append(event)
              }
            } else {
              dailyEvents.append(event)
            }
          }
        }
      }
    }
  }
  
  func checkLiveNextEvents() {
    let todayDate = NSDate()
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    let hour = calendar?.component(.hour, from: todayDate as Date)
    let minute = calendar?.component(.minute, from: todayDate as Date)
    
    for event in dailyEvents {
      if(event.startingHour == hour) {
        if(event.startingMinute == minute! ||  event.startingMinute < minute!) {
          liveEvents.append(event)
        }
      } else {
        nextEvents.append(event)
      }
    }
  }
  
    @objc func checkLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        DataSource.shared.timeString = dateFormatter.string(from: Date() as Date)
        timeLabel.text = DataSource.shared.timeString
        seconds += 1
    }
  
  @objc func updateTableSessions() {
    liveEvents = []
    nextEvents = []
    checkLiveNextEvents()
    tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return liveEvents.count
        case 1:
            return nextEvents.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "LIVE NOW"
        case 1:
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
      
      switch indexPath.section {
      case 0:
        cell.topicLabel.text = liveEvents[indexPath.row].name
        cell.labTimerLabel.text = liveEvents[indexPath.row].location
      case 1:
        cell.topicLabel.text = nextEvents[indexPath.row].name
      default:
        break
      }
        return cell
    }
}

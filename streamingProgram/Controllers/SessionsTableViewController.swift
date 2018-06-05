//
//  SessionsTableViewController.swift
//  streamingProgram
//
//  Created by Antonio Giaquinto on 01/06/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class SessionsTableViewController: UITableViewController {
  
  var secondsTimer: Timer?
  var sessionsTimer: Timer?
  
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
  }
  
  func runTimers() {
    secondsTimer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(checkLabel)), userInfo: nil, repeats: true)
    sessionsTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(updateTableSessions), userInfo: nil, repeats: true)
    
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
      if(event.startingHour <= hour!) {
        if(event.startingMinute <= minute! &&  event.startingHour == hour!) {
          liveEvents.append(event)
        } else{
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
    updateTimerSessions()
  }
  
  @objc func updateTableSessions() {
    dailyEvents = []
    liveEvents = []
    nextEvents = []
    loadDailyEvents()
    checkLiveNextEvents()
    tableView.reloadData()
  }
  
  func updateTimerSessions() {
    let currentDate = NSDate()
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    let hour = calendar?.component(.hour, from: currentDate as Date)
    let minute = calendar?.component(.minute, from: currentDate as Date)

    guard let indexPathVisibleRows = tableView.indexPathsForVisibleRows else {return}
    for indexPath in indexPathVisibleRows {
      let cell = tableView.cellForRow(at: indexPath) as! SessionsTableViewCell
      switch indexPath.section {
      case 0:
        print("LIVE SESSIONS")
        let start = (liveEvents[indexPath.row].startingHour * 60) + liveEvents[indexPath.row].startingMinute
        let current = (hour! * 60) + minute!
        
        let startedTime = current - start
        let startedHour = Int(startedTime / 60)
        if startedHour == 0 {
          cell.countdownLabel.text = "From \(startedTime)m"
        } else {
          let startedMinute = startedTime - (startedHour * 60)
          cell.countdownLabel.text = "From \(startedHour)h \(startedMinute)m"
        }
      case 1:
        print("NEXT SESSIONS")
        let startTime = (nextEvents[indexPath.row].startingHour * 60) + nextEvents[indexPath.row].startingMinute
        let currentTime = (hour! * 60) + minute!
        
        let difference = startTime - currentTime
        if difference < 60 {
          cell.countdownLabel.text = "Start in \(difference)m"
          cell.countdownLabel.textColor = .red
        } else {
          cell.countdownLabel.textColor = UIColor(red: 127.0 / 255.0, green: 127.0 / 255.0, blue: 127.0 / 255.0, alpha: 1)
        }
      default:
        break
      }
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 2
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 88.0;//Choose your custom row height
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
      cell.roomLabel.text = liveEvents[indexPath.row].location
    case 1:
      cell.topicLabel.text = nextEvents[indexPath.row].name
      cell.roomLabel.text = nextEvents[indexPath.row].location
      if nextEvents[indexPath.row].startingMinute == 0 {
        cell.countdownLabel.text = "\(nextEvents[indexPath.row].startingHour):00"
      } else {
        cell.countdownLabel.text = "\(nextEvents[indexPath.row].startingHour):\(nextEvents[indexPath.row].startingMinute)"
      }
    default:
      break
    }
    return cell
  }
}

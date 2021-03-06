//
//  Event.swift
//  streamingProgram
//
//  Created by Pasquale Spisto on 02/06/18.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import Foundation
import UIKit


struct Event: Codable {
  
  var id: Int
  var name: String
  var tag: String
  var day: Int
  var startingHour: Int
  var startingMinute: Int
  var endingHour: Int
  var endingMinute: Int
  var location: String
  var calendarLink: String
  var description: String
  
  init(id: Int, name: String, tag: String, day: Int, startingHour: Int, startingMinute: Int, endingHour:Int, endingMinute:Int, location:String, calendarLink: String, description: String) {
    self.id = id
    self.name = name
    self.tag = tag
    self.day = day
    self.startingHour = startingHour
    self.startingMinute = startingMinute
    self.endingHour = endingHour
    self.endingMinute = endingMinute
    self.location = location
    self.calendarLink = calendarLink
    self.description = description
  }
  
  init() {
    self.id = 0
    self.name = ""
    self.tag = ""
    self.day = 0
    self.startingHour = 0
    self.startingMinute = 0
    self.endingHour = 0
    self.endingMinute = 0
    self.location = ""
    self.calendarLink = ""
    self.description = ""
  }
  
}

func loadEvents()->[Event] {
  var events : [Event] = []
  let jsonUrl = "https://www.gennaroamura.it/academy/query/getEvents.php"
  
  guard let url = URL(string: jsonUrl) else { return events }
  let request: URLRequest = URLRequest(url: url)
  let session = URLSession.shared
  
  let semaphore = DispatchSemaphore(value: 0)
  session.dataTask(with: request) { (data, response, err) in
    guard let data = data else { return }
    
    do {
      events = try JSONDecoder().decode([Event].self, from: data)
      
    } catch let jsonErr {
      print("Error: ",jsonErr)
    }
    
    semaphore.signal()
    }.resume()
  
  semaphore.wait()
  return events
}


//func getDayOfWeek() {
//    let todayDate = NSDate()
//    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
//    let weekOfYear = calendar?.component(.weekOfYear, from: todayDate as Date)
//    let year = calendar?.component(.year, from: todayDate as Date)
//    let dayWeek = calendar?.component(.weekday, from: todayDate as Date)
//    let hour = calendar?.component(.hour, from: todayDate as Date)
//    let minute = calendar?.component(.minute, from: todayDate as Date)
//}


//
//  KHCalendar.swift
//  KHCalendar
//
//  Created by DevLee on 20/05/2019.
//  Copyright © 2019 DevLee. All rights reserved.
//

import UIKit
//MARK: - KHCalendar
class KHCalendar: NSObject {

 
  static let sharedInstance = KHCalendar()
  override init() {
    print("LKH")
  }
  
  
  
  private var now = Date()
  private var cal = Calendar.current
  private let dateFormatter = DateFormatter()
  private var components = DateComponents()
  
  
  
  
  
 fileprivate func previousDays(needDayCount:Int, preYear:Bool) ->Array<KHDate> {
    
    var preDaysList = Array<KHDate>()
    
    var preDateCom = DateComponents()
    preDateCom.year = self.cal.component(.year, from: self.now)
    if preYear {
      preDateCom.year = self.cal.component(.year, from: self.now) - 1
    }
    preDateCom.month = self.cal.component(.month, from: self.now) - 1
    preDateCom.day = 1
    
    let preDate = cal.date(from: preDateCom)
    let preDays = cal.range(of: .day, in: .month, for: preDate!)
    
    
    for day in preDays!.count - needDayCount ... preDays!.count {
      
      var createDay = DateComponents()
      createDay.year = self.cal.component(.year, from: preDate!)
      createDay.month = self.cal.component(.month, from: preDate!)
      createDay.day = day
      let date = KHDate()
      date.dateInfo = createDay
      date.weekDayCode = cal.dateComponents([.weekday], from: self.cal.date(from: createDay)!).weekday
      date.weekDay = self.findWeekday(weekdayCode: date.weekDayCode!)
      preDaysList.append(date)
    }
    
    return preDaysList
  }
  
 fileprivate func forwardDays(needDayCount:Int, nextYear:Bool) -> Array<KHDate> {
    var forwardDaysList = Array<KHDate>()
    
    var forwardDateCom = DateComponents()
    forwardDateCom.year = self.cal.component(.year, from: self.now)
    if nextYear {
      forwardDateCom.year = self.cal.component(.year, from: self.now) + 1
    }
    forwardDateCom.month = self.cal.component(.month, from: self.now) + 1
    forwardDateCom.day = 1
    
    let forwardDate = cal.date(from: forwardDateCom)
    
    for day in 1 ... needDayCount {
      
      var createDay = DateComponents()
      createDay.year = self.cal.component(.year, from: forwardDate!)
      createDay.month = self.cal.component(.month, from: forwardDate!)
      createDay.day = day
      let date = KHDate()
      date.dateInfo = createDay
      date.weekDayCode = cal.dateComponents([.weekday], from: self.cal.date(from: createDay)!).weekday
      date.weekDay = self.findWeekday(weekdayCode: date.weekDayCode!)
      forwardDaysList.append(date)
    }
    
    return forwardDaysList
  }
  
  
  func days() -> Array<KHDate> {

    var days = Array<KHDate>()
    
    
    let currentDays = cal.range(of: .day, in: .month, for: self.now)
    
    for day in currentDays! {
      var createDay = DateComponents()
      createDay.year = self.cal.component(.year, from: self.now)
      createDay.month = self.cal.component(.month, from: self.now)
      createDay.day = day
    
      let date = KHDate()
      date.dateInfo = createDay
      date.weekDayCode = cal.dateComponents([.weekday], from: self.cal.date(from: createDay)!).weekday
      date.weekDay = self.findWeekday(weekdayCode: date.weekDayCode!)
      days.append(date)
    }
    
    if let firstDay = days.first, firstDay.weekDayCode! > 1 {
      let preDays = self.previousDays(needDayCount: firstDay.weekDayCode! - 2, preYear: firstDay.dateInfo.month == 1)
      
      days.insert(contentsOf: preDays, at: 0)
      
      
    }
    
    if let lastDay = days.last, lastDay.weekDayCode! < 7 {
      let forwardDays = self.forwardDays(needDayCount: 7 - lastDay.weekDayCode!, nextYear: lastDay.dateInfo.month == 12)
      days.append(contentsOf: forwardDays)
      
    }
    
    
    
    return days
  }
  
  
  fileprivate func oldDate() ->DateComponents {
   
    var old = DateComponents()
    old.year = self.cal.component(.year, from: self.now)
    old.month = self.cal.component(.month, from: self.now)
    old.day = self.cal.component(.day, from: self.now)
    
    return old
  }
  
  
  func previousMonth(callBack:() -> Void)  {
    
    
    let preYear = self.oldDate().month == 1
    
    
    
    var preDateCom = DateComponents()
    preDateCom.year = self.cal.component(.year, from: self.now)
    if preYear {
      preDateCom.year = self.cal.component(.year, from: self.now) - 1
    }
    preDateCom.month = self.cal.component(.month, from: self.now) - 1
    preDateCom.day = 1
    
    let preDate = cal.date(from: preDateCom)
    
    self.now = preDate!
    
    callBack()
    
    
  }
  
  func forwardMonth(callBack:() -> Void) {
    
    let nextYear = self.oldDate().month == 12
    
    var forwardDateCom = DateComponents()
    forwardDateCom.year = self.cal.component(.year, from: self.now)
    if nextYear {
      forwardDateCom.year = self.cal.component(.year, from: self.now) + 1
    }
    forwardDateCom.month = self.cal.component(.month, from: self.now) + 1
    forwardDateCom.day = 1
    
    self.now = cal.date(from: forwardDateCom)!
    callBack()
  }
  
  func presentMonth(callBack:() -> Void) {
    self.now = Date()
    callBack()
  }
  
  
  func findWeekday(weekdayCode:Int) -> String {
    
    switch weekdayCode {
    case 1:
      return "일요일"
    case 2:
      return "월요일"
    case 3:
      return "화요일"
    case 4:
      return "수요일"
    case 5:
      return "목요일"
    case 6:
      return "금요일"
    case 7:
      return "토요일"
    default:
      return ""
    }
    
  }
  
  
}

//MARK: - KHDate
class KHDate: NSObject {
  var dateInfo:DateComponents!
  var weekDayCode:Int?
  var weekDay:String?
}

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
  
  
  
  private var currentDate = Date()
  private var calenar = Calendar.current
  private let dateFormatter = DateFormatter()
  private var components = DateComponents()
  
  
 fileprivate func previousDays(needDayCount:Int, preYear:Bool) ->Array<KHDate> {
    
    var preDaysList = Array<KHDate>()
    
    let preDateCom = self.dateComponentInit(year: -1, month: -1, day: 1, isChageYear: preYear)
  
    let preDate = self.calenar.date(from: preDateCom)
    let preDays = self.calenar.range(of: .day, in: .month, for: preDate!)
    
    
    for day in preDays!.count - needDayCount ... preDays!.count {
      
      var createDay = DateComponents()
      createDay.year = self.calenar.component(.year, from: preDate!)
      createDay.month = self.calenar.component(.month, from: preDate!)
      createDay.day = day
      let date = KHDate()
      date.dateInfo = createDay
      date.weekDayCode = self.calenar.dateComponents([.weekday], from: self.calenar.date(from: createDay)!).weekday
      date.weekDay = self.findWeekday(weekdayCode: date.weekDayCode!,isShort: false)
      date.shortWeekDay = self.findWeekday(weekdayCode: date.weekDayCode!,isShort: true)
      preDaysList.append(date)
    }
    
    return preDaysList
  }
  
  
  fileprivate func dateComponentInit(year:Int, month:Int, day:Int , isChageYear:Bool) -> DateComponents {
    
    var newDateCom = DateComponents()
    
    newDateCom.year = self.calenar.component(.year, from: self.currentDate)
    if isChageYear {
      newDateCom.year = self.calenar.component(.year, from: self.currentDate) + year
    }
    newDateCom.month = self.calenar.component(.month, from: self.currentDate) + month
    newDateCom.day = day
    
    return newDateCom
  }
  
  
  
  
 fileprivate func forwardDays(needDayCount:Int, nextYear:Bool) -> Array<KHDate> {
    var forwardDaysList = Array<KHDate>()
    
    let forwardDateCom = self.dateComponentInit(year: 1, month: 1, day: 1, isChageYear: nextYear)
  
    let forwardDate = self.calenar.date(from: forwardDateCom)
    
    for day in 1 ... needDayCount {
      
      var createDay = DateComponents()
      createDay.year = self.calenar.component(.year, from: forwardDate!)
      createDay.month = self.calenar.component(.month, from: forwardDate!)
      createDay.day = day
      let date = KHDate()
      date.dateInfo = createDay
      date.weekDayCode = self.calenar.dateComponents([.weekday], from: self.calenar.date(from: createDay)!).weekday
      date.weekDay = self.findWeekday(weekdayCode: date.weekDayCode!,isShort: false)
      date.shortWeekDay = self.findWeekday(weekdayCode: date.weekDayCode!,isShort: true)
      forwardDaysList.append(date)
    }
    
    return forwardDaysList
  }
  
  
  
  func currentYear() -> String {
    return "\(String(describing: self.oldDate().year))"
  }
  
  func currentMonth() -> String {
    return "\(String(describing: self.oldDate().month))"
  }

  func currentDay() -> String {
    return "\(String(describing: self.oldDate().day))"
  }
  
  func currentWeekDay() -> String {
    return self.findWeekday(weekdayCode: self.oldDate().weekday!, isShort: false)
  }
  
  
  func days() -> Array<KHDate> {

    var days = Array<KHDate>()
    
    
    let currentDays = self.calenar.range(of: .day, in: .month, for: self.currentDate)
    
    for day in currentDays! {
      var createDay = DateComponents()
      createDay.year = self.calenar.component(.year, from: self.currentDate)
      createDay.month = self.calenar.component(.month, from: self.currentDate)
      createDay.day = day
    
      let date = KHDate()
      date.dateInfo = createDay
      date.weekDayCode = self.calenar.dateComponents([.weekday], from: self.calenar.date(from: createDay)!).weekday
      date.weekDay = self.findWeekday(weekdayCode: date.weekDayCode!,isShort: false)
      date.shortWeekDay = self.findWeekday(weekdayCode: date.weekDayCode!,isShort: true)
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
    old.year = self.calenar.component(.year, from: self.currentDate)
    old.month = self.calenar.component(.month, from: self.currentDate)
    old.day = self.calenar.component(.day, from: self.currentDate)
    
    return old
  }
  
  
  func previousMonth(callBack:() -> Void)  {
    
    let preYear = self.oldDate().month == 1
    
    let preDateCom = self.dateComponentInit(year: -1, month: -1, day: 1, isChageYear: preYear)
    
    let preDate = self.calenar.date(from: preDateCom)
    
    self.currentDate = preDate!
    
    callBack()
    
    
  }
  
  func forwardMonth(callBack:() -> Void) {
    
    let nextYear = self.oldDate().month == 12
    
    let forwardDateCom = self.dateComponentInit(year: 1, month: 1, day: 1, isChageYear: nextYear)
    
    self.currentDate = self.calenar.date(from: forwardDateCom)!
    callBack()
  }
  
  func presentMonth(callBack:() -> Void) {
    self.currentDate = Date()
    callBack()
  }
  
  
  func findWeekday(weekdayCode:Int, isShort:Bool) -> String {
    
    switch weekdayCode {
    case 1:
      return isShort == true ? "일" : "일요일"
    case 2:
      return isShort == true ? "월" : "월요일"
    case 3:
      return isShort == true ? "화" : "화요일"
    case 4:
      return isShort == true ? "수" : "수요일"
    case 5:
      return isShort == true ? "목" : "목요일"
    case 6:
      return isShort == true ? "금" : "금요일"
    case 7:
      return isShort == true ? "토" : "토요일"
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
  var shortWeekDay:String?
  
  
  
}

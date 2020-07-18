//
//  StudyModel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase


struct StudyModel: Codable {
  let title: String
  let lectureID: String
  let lectureTitle: String
  let chapterID: Int
  let unitID: Int
  let unitTitle: String
  let unitDescription: String
  let date: Timestamp
  let fixed: Int
  let rule: String
  var userIDs: [String]
  var qnaIDs: [String]
  var inProcess: ProcessStatus
  
  var dateValue: Date {
    date.dateValue()
  }
  
  enum ProcessStatus: Int, Codable {
    case wait
    case inProcess
    case finished
  }
}

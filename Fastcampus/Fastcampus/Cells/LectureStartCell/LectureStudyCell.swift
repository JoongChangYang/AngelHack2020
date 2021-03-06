//
//  LectureStartCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol LectureStudyCellDelegate: class {
  func joinStudy(studyID: String)
  func notice()
}

class LectureStudyCell: UITableViewCell {
  static let identifier = "LectureStudyCell"
  weak var delegate: LectureStudyCellDelegate?
  private var studyID: String?
  private let levelButton = UIButton()
  private let nameLabel = UILabel()
  private let titleLabel = UILabel()
  private let startDateBgView = UIView()
  private let startDateLabel = UILabel()
  private let peopleLabel = UILabel()
  private let noticeButton = UIButton()
  private let joinButton = UIButton()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setProperties(study: StudyModel, user: UserModel) {
    titleLabel.text = study.title
    let formatter = DateFormatter()
    formatter.dateFormat = "MM월 dd일 HH시 mm분"
    let date = formatter.string(from: study.date.dateValue())
    let dateList = date.split(separator: " ")
    startDateLabel.text = "\(dateList[0].dropLast()).\(dateList[1].dropLast()) \(dateList[2].dropLast()):\(dateList[3].dropLast()) 시작"
    peopleLabel.text = "\(study.userIDs.count)명 / \(study.fixed)명"
    if study.userIDs.count == study.fixed {
      joinButton.setTitle("모집마감", for: .normal)
      joinButton.setTitleColor(.darkGray, for: .normal)
      joinButton.backgroundColor = UIColor.lightGray
      joinButton.isUserInteractionEnabled = false
      noticeButton.isHidden = false
      
      titleLabel.snp.remakeConstraints {
        $0.top.equalTo(levelButton.snp.bottom).offset(15 / 3)
        $0.leading.equalTo(contentView).offset(15)
        $0.trailing.equalTo(noticeButton.snp.leading).offset(-15)
      }
      layoutIfNeeded()
    }
    
    if study.userIDs.contains(SignService.uid) {
      joinButton.setTitle("참여완료", for: .normal)
      joinButton.setTitleColor(.darkGray, for: .normal)
      joinButton.backgroundColor = UIColor.lightGray
      joinButton.isUserInteractionEnabled = false
      noticeButton.isHidden = true
      titleLabel.snp.remakeConstraints {
        $0.top.equalTo(levelButton.snp.bottom).offset(15 / 3)
        $0.leading.equalTo(contentView).offset(15)
        $0.trailing.equalTo(joinButton.snp.leading).offset(-15)
      }
      layoutIfNeeded()
    } else {
      if study.userIDs.count != study.fixed {
        makeGradientJoinButton()
        noticeButton.isHidden = true
        titleLabel.snp.remakeConstraints {
          $0.top.equalTo(levelButton.snp.bottom).offset(15 / 3)
          $0.leading.equalTo(contentView).offset(15)
          $0.trailing.equalTo(joinButton.snp.leading).offset(-15)
        }
        layoutIfNeeded()
      }
    }
    
    nameLabel.text = user.nickName
    studyID = study.documentID
    levelButton.setTitle("Lv.\(user.level)", for: .normal)
  }
  
  func makeGradientJoinButton() {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = [
      UIColor(red: 204/255, green: 35/255, blue: 69/255, alpha: 1).cgColor,
      UIColor(red: 253/255, green: 113/255, blue: 80/255, alpha: 1).cgColor
    ]
    gradient.locations = [0.0, 1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = CGRect(x: 0, y: 0, width: 80, height: 34)
    joinButton.layer.insertSublayer(gradient, at: 0)
    joinButton.layer.cornerRadius = 8
    joinButton.clipsToBounds = true
    joinButton.addTarget(self, action: #selector(touchUpJoinButton), for: .touchUpInside)
  }
  
  private func attribute() {
    levelButton.setTitleColor(.red, for: .normal)
    levelButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    levelButton.layer.borderColor = UIColor.red.cgColor
    levelButton.layer.borderWidth = 1
    levelButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
    
    nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
    
    startDateBgView.backgroundColor = #colorLiteral(red: 1, green: 0.9131416678, blue: 0.8906806111, alpha: 1)
    
    startDateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    peopleLabel.textColor = #colorLiteral(red: 0.5988813043, green: 0.5989002585, blue: 0.6190659404, alpha: 1)
    peopleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    noticeButton.setImage(#imageLiteral(resourceName: "icon_notice_color"), for: .normal)
    noticeButton.contentMode = .scaleAspectFit
    noticeButton.isHidden = true
    noticeButton.addTarget(self, action: #selector(touchUpNoticeButton), for: .touchUpInside)
    
    joinButton.setTitle("참여하기", for: .normal)
    joinButton.setTitleColor(.white, for: .normal)
    joinButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    joinButton.layer.cornerRadius = 8
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [levelButton, nameLabel, titleLabel, startDateBgView, startDateLabel, peopleLabel, noticeButton, joinButton]
      .forEach { contentView.addSubview($0) }
    
    levelButton.snp.makeConstraints {
      $0.top.leading.equalTo(contentView).offset(margins)
    }
    
    nameLabel.snp.makeConstraints {
      $0.centerY.equalTo(levelButton)
      $0.leading.equalTo(levelButton.snp.trailing).offset(margins / 3)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(levelButton.snp.bottom).offset(margins / 3)
      $0.leading.equalTo(contentView).offset(margins)
      $0.trailing.equalTo(joinButton.snp.leading).offset(-margins)
    }
    
    startDateLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(contentView).offset(margins + 3)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    startDateBgView.snp.makeConstraints {
      $0.top.leading.equalTo(startDateLabel).offset(-3)
      $0.trailing.bottom.equalTo(startDateLabel).offset(3)
    }
    
    peopleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(startDateBgView.snp.trailing).offset(margins / 2)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    noticeButton.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(joinButton.snp.leading).offset(-margins)
      $0.width.height.equalTo(40)
    }
    
    joinButton.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(contentView).offset(-margins)
      $0.width.equalTo(80)
      $0.height.equalTo(34)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension LectureStudyCell {
  @objc private func touchUpJoinButton() {
    if let studyID = studyID {
      delegate?.joinStudy(studyID: studyID)
    }
  }
  
  @objc private func touchUpNoticeButton() {
    delegate?.notice()
  }
}

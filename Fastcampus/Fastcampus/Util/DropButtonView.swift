//
//  DropButtonView.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol DropButtonViewDelegate: class {
  func titlButtonDidTap(_ view: UIView)
  func selectedElement(_ view: UIView, _ element: Int)
}

class DropButtonView: UIView {
  
  weak var delegate: DropButtonViewDelegate?
  
  var isFold = true { didSet { animationFold() } }
  private let amount: Int
  private let title: String
  
  private let titleButton = UIButton()
  private let guideLine = UIView()
  private let elementTableView = UITableView()
  
  private var bottomConstraint: NSLayoutConstraint?

  init(amount: Int, title: String) {
    self.amount = amount
    self.title = title
    super.init(frame: .zero)
    
    setUI()
    setConstraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}




// MARK: - UI

extension DropButtonView {
  private func setUI() {
    self.layer.cornerRadius = 2
    self.shadow()
    self.backgroundColor = .myGray
    
    titleButton.setTitle("  " + title, for: .normal)
    titleButton.backgroundColor = .clear
    titleButton.setTitleColor(.black, for: .normal)
    titleButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
    titleButton.addTarget(self, action: #selector(titleButtonDidTap), for: .touchUpInside)
    
    guideLine.isHidden = true
    guideLine.backgroundColor = .gray
    guideLine.shadow()
    
    elementTableView.isHidden = true
    elementTableView.backgroundColor = .clear
    elementTableView.separatorStyle = .none
    elementTableView.dataSource = self
    elementTableView.delegate = self
  }
  
  private func setConstraint() {
    [titleButton, guideLine, elementTableView].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let space: CGFloat = 8
    
    NSLayoutConstraint.activate([
      titleButton.topAnchor.constraint(equalTo: self.topAnchor),
      titleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      titleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      titleButton.heightAnchor.constraint(equalToConstant: 32),
      
      guideLine.topAnchor.constraint(equalTo: titleButton.bottomAnchor),
      guideLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
      guideLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space),
      guideLine.heightAnchor.constraint(equalToConstant: 1),
      
      elementTableView.topAnchor.constraint(equalTo: guideLine.bottomAnchor),
      elementTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      elementTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      elementTableView.heightAnchor.constraint(equalToConstant: 104)
    ])
    
    bottomConstraint = self.bottomAnchor.constraint(equalTo: elementTableView.bottomAnchor)
    bottomConstraint?.isActive = true
    bottomConstraint?.priority = .defaultLow
    
    let tempBottomConstraint = self.bottomAnchor.constraint(equalTo: titleButton.bottomAnchor)
    tempBottomConstraint.isActive = true
    tempBottomConstraint.priority = .init(500)
  }
  
  private func animationFold() {
    guideLine.isHidden = isFold
    elementTableView.isHidden = isFold
    bottomConstraint?.priority = isFold ? .defaultLow : .defaultHigh
  }
  
  func setTitle(_ title: String) {
    titleButton.setTitle(title, for: .normal)
  }
}



// MARK: - Action

extension DropButtonView {
  @objc private func titleButtonDidTap() {
    isFold.toggle()
    superview?.bringSubviewToFront(self)
    delegate?.titlButtonDidTap(self)
  }
}




// MARK: - UITableViewDataSource

extension DropButtonView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { amount }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.backgroundColor = .clear
    cell.textLabel?.text = String(indexPath.row + 1)
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.font = .boldSystemFont(ofSize: 15)
    cell.selectionStyle = .none
    return cell
  }
}



// MARK: - UITableViewDelegate

extension DropButtonView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 32 }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    titleButton.setTitle("\(indexPath.row + 1) \(title)", for: .normal)
    delegate?.selectedElement(self, indexPath.row + 1)
    isFold = true
  }
}

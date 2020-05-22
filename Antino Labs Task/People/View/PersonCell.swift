//
//  PersonCell.swift
//  Antino Labs Task
//
//  Created by Ajay Choudhary on 22/05/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

final class PersonCell: UICollectionViewCell {
  
  private let profileImage = UIImageView()
  private let nameLabel = UILabel()
  private let ageLabel = UILabel()
  private let locationLabel = UILabel()
  
  var person: Person? {
    didSet {
      guard let person = person else { return }
      nameLabel.text = person.name
      ageLabel.text = person.age
      locationLabel.text = person.location
      self.profileImage.image = nil
      MockDataClient.fetchProfileImage(urlString: person.profileUrl) { (image, error) in
        DispatchQueue.main.async { self.profileImage.image = image }
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let margins = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    contentView.frame = contentView.frame.inset(by: margins)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = .white
    layer.cornerRadius = 10
    setupProfileImage()
    setupNameLabel()
    setupDescriptionLabel()
    setupLocationLabel()
  }
  
  private func setupProfileImage() {
    addSubview(profileImage)
    
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    let centerY = profileImage.centerYAnchor.constraint(equalTo: centerYAnchor)
    let leading = profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    let height = profileImage.heightAnchor.constraint(equalToConstant: 66)
    let width = profileImage.widthAnchor.constraint(equalToConstant: 66)
    NSLayoutConstraint.activate([centerY, leading, height, width])
    
    profileImage.layer.cornerRadius = 66/2
    profileImage.clipsToBounds = true
    profileImage.image = UIImage(named: "placeholder")
  }
  
  private func setupNameLabel() {
    addSubview(nameLabel)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = nameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor)
    let leading = nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 28)
    let trailing = nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
    let height = nameLabel.heightAnchor.constraint(equalToConstant: 25)
    NSLayoutConstraint.activate([top, leading, trailing, height])
    
    nameLabel.font = .boldSystemFont(ofSize: 22)
  }
  
  private func setupDescriptionLabel() {
    addSubview(ageLabel)
    
    ageLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
    let leading = ageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
    let height = ageLabel.heightAnchor.constraint(equalToConstant: 20)
    NSLayoutConstraint.activate([top, leading, height])
    
    ageLabel.font = .systemFont(ofSize: 19)
    ageLabel.sizeToFit()
  }
  
  private func setupLocationLabel() {
    addSubview(locationLabel)
    
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
    let leading = locationLabel.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 8)
    let trailing = locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    let height = locationLabel.heightAnchor.constraint(equalToConstant: 20)
    NSLayoutConstraint.activate([top, leading, trailing, height])
    
    locationLabel.font = .systemFont(ofSize: 17)
  }
  
}

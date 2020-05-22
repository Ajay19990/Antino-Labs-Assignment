//
//  ContentView.swift
//  Antino Labs Task
//
//  Created by Ajay Choudhary on 22/05/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

final class PeopleVC: UIViewController {
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 15.0, left: 1.0, bottom: 1.0, right: 1.0)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  
  private var activityIndicatorContainer: UIView!
  private var activityIndicator: UIActivityIndicatorView!
  
  private let cellId = "cellid"
  private var people = [Person]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    MockDataClient.fetchPersonData(completion: handlePeople)
  }
  
  // MARK: - Setup View
  
  private func setupView() {
    view.backgroundColor = .systemGroupedBackground
    navigationItem.title = "People"
    navigationController?.navigationBar.prefersLargeTitles = true
    setupTableView()
    setupActivityIndicator()
    loadingData(true)
  }
  
  private func setupTableView() {
    view.addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    let top = collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    let leading = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let trailing = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    let bottom = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    NSLayoutConstraint.activate([top, leading, trailing, bottom])
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(PersonCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.backgroundColor = .systemGroupedBackground
    collectionView.alwaysBounceVertical = true
  }
  
  private func setupActivityIndicator() {
    activityIndicatorContainer = ActivityIndicatorContainer(view: view)
    
    activityIndicator = UIActivityIndicatorView()
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorContainer.addSubview(activityIndicator)
    view.addSubview(activityIndicatorContainer)
    
    activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
  }
  
  // MARK: - Networking
  
  private func handlePeople(people: [Person], error: ErrorMessage?) {
    DispatchQueue.main.async { self.loadingData(false) }
    if let error = error {
      presentAlertOnMainThread(title: "An error occured", message: error.rawValue)
    }
    self.people = people
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  private func loadingData(_ loadingData: Bool) {
    if loadingData {
      activityIndicator.startAnimating()
      collectionView.isScrollEnabled = false
      collectionView.isUserInteractionEnabled = false
    } else {
      activityIndicator.stopAnimating()
      activityIndicatorContainer.removeFromSuperview()
      collectionView.isScrollEnabled = true
      collectionView.isUserInteractionEnabled = true
    }
  }
  
}

  // MARK: - Extensions

extension PeopleVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if people.isEmpty {
      collectionView.setEmptyView(title: "Data unavailable", message: "Unable to get the requested data.")
    } else {
      collectionView.restore()
    }
    return people.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PersonCell
    cell.person = people[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width - 30
    return CGSize(width: width, height: 100)
  }
  
}

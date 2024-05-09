//
//  CustomNavbarTitle.swift
//  Crypto-App
//
//  Created by alihizardere on 6.05.2024.
//

import UIKit

class NavbarTitleView: UIView {

  var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()

  var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15)
    label.textAlignment = .center
    label.textColor = .systemGray5
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(titleLabel)
    addSubview(subtitleLabel)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: topAnchor),
      subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

      titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

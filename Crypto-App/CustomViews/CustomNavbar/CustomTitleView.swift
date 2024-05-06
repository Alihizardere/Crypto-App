//
//  CustomNavbarTitle.swift
//  Crypto-App
//
//  Created by alihizardere on 6.05.2024.
//

import UIKit

class CustomTitleView: UIView {

  var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.textAlignment = .center
    return label
  }()

  var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .center
    label.textColor = UIColor.gray
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

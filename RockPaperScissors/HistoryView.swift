//
//  HistoryView.swift
//  RockPaperScissors
//
//  Created by Jesús Lugo Sáenz on 26/10/24.
//

import UIKit

class HistoryView: UIView {

    lazy var labelHistory: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView(){
        addSubview(labelHistory)
        addLabelHistory()
    }
    
    private func addLabelHistory(){
        NSLayoutConstraint.activate([
            labelHistory.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            labelHistory.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            labelHistory.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            labelHistory.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -8),
        ])
    }
}

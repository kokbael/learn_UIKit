//
//  TodoTableViewCell.swift
//  TodoDemo
//
//  Created by 김동영 on 3/21/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    let checkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "circle"), for: .normal) // 체크 안 된 상태
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected) // 체크된 상태
        button.tintColor = .systemBlue
        return button
    }()
    
    let title = UILabel()
    
    var toggleCompletion: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(checkButton)
        contentView.addSubview(title)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 24),
            checkButton.heightAnchor.constraint(equalToConstant: 24),
            title.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
        
        checkButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    }
    
    @objc private func didTapCheckButton() {
        toggleCompletion?()
    }
    
    func configure(item: TodoItem) {
        title.attributedText = nil
        title.text = item.title
        checkButton.isSelected = item.isComplete
        title.textColor = item.isComplete ? .gray : .black
        if item.isComplete {
            title.attributedText = item.title.strikeThrough()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

//
//  GFButton.swift
//  GitHubProgrammatically
//
//  Created by Doğa Bayram on 4.02.2022.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backGroundColor:UIColor,title : String) {
        self.init(frame: .zero)
        self.backgroundColor = backGroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backGroundColor: UIColor, title: String) {
        self.backgroundColor = backGroundColor
        setTitle(title, for: .normal)
    }
    
}

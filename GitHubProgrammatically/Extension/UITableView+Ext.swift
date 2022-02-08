//
//  UITableView+Ext.swift
//  GitHubProgrammatically
//
//  Created by Doğa Bayram on 8.02.2022.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

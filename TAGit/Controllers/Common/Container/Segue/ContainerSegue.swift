//
//  ContainerSegue.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class ContainerSegue: UIStoryboardSegue {
    override func perform() {
        guard let source = self.source as? ContainerViewController,
            let container = source.container else {
            return
        }
        
        for view in  container.subviews {
            view.removeFromSuperview()
        }
        
        if let stack = container as? UIStackView {
            stack.addArrangedSubview(destination.view)
        }
        else {
            container.addSubview(destination.view)
            destination.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
        source.currentViewController = destination
    }
}

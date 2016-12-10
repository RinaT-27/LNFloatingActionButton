//
//  ViewController.swift
//  LNFloatingActionButton-Example
//
//  Created by Shuhei Kawaguchi on 2016/11/26.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import UIKit
import LNFloatingActionButton

class ViewController: UIViewController {
    
    var cells: [LNFloatingActionButtonCell] = []
    var floatingActionButton: LNFloatingActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cell = LNFloatingActionButtonTitleCell()
        cell.title = "sample text"
//        cell.titleLabelSize = CGSize(width: 200, height: 40)
        cell.titleColor = UIColor.red
        cell.titleLabelBackgroundColor = UIColor.blue
        cell.image = UIImage(named: "like")
        
//        cells.append(LNFloatingActionButtonCell())
        cells.append(cell)
        let ellipseCell = LNFloatingActionButtonEllipseCell()
        ellipseCell.ellipseSize = CGSize(width: 150, height: 30)
        ellipseCell.titleTextAlignment = .center
        ellipseCell.title = "test text"
        ellipseCell.image = UIImage(named: "like")
//        ellipseCell.isVariableSize = true
        cells.append(ellipseCell)
        
        floatingActionButton = LNFloatingActionButton(x: view.frame.size.width - 100, y: view.frame.size.height - 100)
        floatingActionButton.delegate = self
        floatingActionButton.dataSource = self
        floatingActionButton.closedImage = UIImage(named: "plus")
//        floatingActionButton.openedImage = UIImage(named: "like")
//        floatingActionButton.cellAnimationWithOpen = { btn in btn.customeAnimation() }
//        floatingActionButton.titleLabelPosition = .left
//        floatingActionButton.cellHorizontalAlign = .left
        view.addSubview(floatingActionButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: LNFloatingActionButtonDelegate {
    func floatingActionButton(_ floatingActionButton: LNFloatingActionButton, didSelectItemAtIndex index: Int) {
        print(index)
    }
}

extension ViewController: LNFloatingActionButtonDataSource {
    func numberOfCells(_ floatingActionButton: LNFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(_ index: Int) -> LNFloatingActionButtonCell {
        return cells[index]
    }
}

extension LNFloatingActionButton {
    func customeAnimation() {
        // original animation ...
    }
}

//
//  LNFloatingActionButton.swift
//  LNFloatingActionButton
//
//  Created by Shuhei Kawaguchi on 2016/11/26.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import UIKit
import QuartzCore


@objc public protocol LNFloatingActionButtonDataSource {
    func numberOfCells(_ floatingActionButton: LNFloatingActionButton) -> Int
    func cellForIndex(_ index: Int) -> LNFloatingActionButtonCell
}

@objc public protocol LNFloatingActionButtonDelegate {
    @objc optional func floatingActionButton(_ floatingActionButton: LNFloatingActionButton, didSelectItemAtIndex index: Int)
}


open class LNFloatingActionButton: UIView {
    open let imageView = UIImageView()
    open var internalRatio: CGFloat = 0.75
    
    open override var frame: CGRect {
        didSet {
            resizeSubviews()
        }
    }
    open var color = UIColor(red: 0/255.0, green: 157/255.0, blue: 238/255.0, alpha: 1.0) {
        didSet {
            backgroundColor = color
        }
    }
    open var responsible = true
    open fileprivate(set) var isClosed = true
    
    open var delegate:   LNFloatingActionButtonDelegate?
    open var dataSource: LNFloatingActionButtonDataSource?
    
    private var touching = false
    
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Open
    open func open() {
        print("open")
        // btn animation
        // insert cell
        cells().forEach { insert(cell: $0) }
        // open animation
        isClosed = false
    }
    
    open func close() {
        print("close")
        // btn animation
        // close animation -> delete cell
        isClosed = true
    }
    
    open override func draw(_ rect: CGRect) {
        drawCircle()
    }
    
    
    // MARK: - Private
    private func setup() {
        self.backgroundColor = color
        self.clipsToBounds = false
        imageView.clipsToBounds = false
        self.addSubview(imageView)
        resizeSubviews()
    }
    
    private func resizeSubviews() {
        let size = CGSize(width: frame.width * 0.5, height: frame.height * 0.5)
        imageView.frame = CGRect(x: frame.width - frame.width * internalRatio, y: frame.height - frame.height * internalRatio,
                                 width: size.width, height: size.height)
    }
    
    private func drawCircle() {
        self.layer.cornerRadius = frame.width / 2
        self.layer.masksToBounds = true
        if touching && responsible {
//            self.layer.backgroundColor = self.color.white(0.5).cgColor
        } else {
            self.layer.backgroundColor = self.color.cgColor
        }
    }
    
    private func cells() -> [LNFloatingActionButtonCell] {
        var result: [LNFloatingActionButtonCell] = []
        guard let source = dataSource else { return result }
        
        for i in 0..<source.numberOfCells(self) {
            result.append(source.cellForIndex(i))
        }
        return result
    }
    
    private func insert(cell: LNFloatingActionButtonCell) {
        cell.alpha = 0
        cell.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        cell.actionButton = self
        self.addSubview(cell)
    }
    
    
    // MARK: - Action
    private func didTap() {
        isClosed ? open() : close()
    }
    
    
    // MARK: - Event
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touching = true
        setNeedsDisplay()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touching = false
        setNeedsDisplay()
        didTap()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        self.touching = false
        setNeedsDisplay()
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }
}

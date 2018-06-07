//
//  ViewController.swift
//  FEScrollView
//
//  Created by FlyElephant on 2018/6/7.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var mainScrollView = UIScrollView()
    var subHeaderView = UIView()
    var subScrollView = UIScrollView()
    var screenWidth = UIScreen.main.bounds.size.width
    var screenHeight = UIScreen.main.bounds.size.height
    let maxOffsetY: CGFloat = 130
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.subScrollView { // 是否在滑动子ScrollView
            let isScrollUp = self.mainScrollView.contentOffset.y < maxOffsetY
            let offsetY = self.mainScrollView.contentOffset.y + self.subScrollView.contentOffset.y
            if isScrollUp { // 子ScrollView和主ScrollView一起向上滚动
                self.mainScrollView.contentOffset = CGPoint(x: 0, y: offsetY)
                self.subScrollView.contentOffset = .zero
            } else if self.subScrollView.contentOffset.y <= 0 && !isScrollUp { // ScrollView向下拉
                self.mainScrollView.contentOffset = CGPoint(x: 0, y: offsetY)
            }
        } else if scrollView == self.mainScrollView { // 滑动的ScrollView是主ScrollView
            if self.mainScrollView.contentOffset.y >= maxOffsetY {
                self.mainScrollView.contentOffset = CGPoint(x: 0, y: maxOffsetY)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.subScrollView {
            if self.mainScrollView.contentOffset.y < 0 { // 子视图拖拽结束之后，主视图没法回到原来的位置
                self.mainScrollView.contentOffset = .zero
            }
        }
    }

    func setupUI() {
        self.mainScrollView.frame = CGRect(x: 0, y: 44, width: screenWidth, height: screenHeight - 100)
        self.mainScrollView.showsHorizontalScrollIndicator = false
        self.mainScrollView.delegate = self
        self.mainScrollView.clipsToBounds = true
        self.mainScrollView.backgroundColor = .gray
        self.mainScrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        self.view.addSubview(self.mainScrollView)
        
        self.subHeaderView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 150)
        self.subHeaderView.backgroundColor = .red
        self.mainScrollView.addSubview(self.subHeaderView)
        
        self.subScrollView.frame = CGRect(x: 0, y: 150, width: screenWidth, height: 500)
        self.subScrollView.showsHorizontalScrollIndicator = false
        self.subScrollView.delegate = self
        self.subScrollView.clipsToBounds = true
        self.subScrollView.backgroundColor = .orange
        self.subScrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        self.mainScrollView.addSubview(self.subScrollView)
        
        let lablel1 = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        lablel1.text = "内容1"
        lablel1.backgroundColor = .blue
        self.subScrollView.addSubview(lablel1)
        let lablel2 = UILabel(frame: CGRect(x: 0, y: 200, width: screenWidth, height: 200))
        lablel2.text = "内容2"
        lablel2.backgroundColor = .cyan
        self.subScrollView.addSubview(lablel1)
        let lablel3 = UILabel(frame: CGRect(x: 0, y: 400, width: screenWidth, height: 200))
        lablel3.text = "内容3"
        lablel3.backgroundColor = .yellow
        self.subScrollView.addSubview(lablel3)
        let lablel4 = UILabel(frame: CGRect(x: 0, y: 600, width: screenWidth, height: 400))
        lablel4.text = "内容4"
        lablel4.backgroundColor = .blue
        self.subScrollView.addSubview(lablel4)
    }

}


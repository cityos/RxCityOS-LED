//
//  UIScrollView+CityOS.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import Foundation

extension UIScrollView {
    enum UIScrollViewError : ErrorType {
        case PageDoesNotExist(page: Int)
    }
    
    var numberOfPages : Int {
        let fullWidth = self.contentSize.width
        let width = self.frame.width
        let pages = Int(fullWidth / width)
        return pages
    }
    
    var currentPage : Int {
        let page = self.contentOffset.x / self.frame.size.width
        return Int(page)
    }
    
    func goToPage(page: Int) throws {
        if page > numberOfPages - 1 {
            throw UIScrollViewError.PageDoesNotExist(page: page)
        }
        
        let x = self.frame.width * CGFloat(page)
        self.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}

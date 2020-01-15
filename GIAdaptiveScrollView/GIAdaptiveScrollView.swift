//
//  GIAdaptiveScrollView.swift
//  Scrolling1
//
//  Created by daleijn on 15/01/2020.
//  Copyright © 2020 daleijn. All rights reserved.
//

import UIKit

class GIAdaptiveScrollView: UIScrollView {
    
    private lazy var previousContentInsets: UIEdgeInsets = {
        return self.contentInset
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyboardNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupKeyboardNotifications()
    }
    
    
    // MARK: - Setup keyboard notif
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(adjustInsetForKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(adjustInsetForKeyboard(_:)),
            name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustInsetForKeyboard(_ notification: Notification) {
        guard let keyboardHeight = self.calculateKeyboardHeightFrom(notification) else {
            return adjustContentInsets(self.previousContentInsets)
        }
        
        var contentInsets = self.previousContentInsets
        contentInsets.bottom = keyboardHeight
        
        adjustContentInsets(contentInsets)
    }
    
    
    func calculateKeyboardHeightFrom(_ notification: Notification) -> CGFloat? {
        guard let userInfo = notification.userInfo else { return nil }
        
        let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let isShowing = notification.name == UIResponder.keyboardWillShowNotification
        guard isShowing else { return nil }
        
        let keyboardHeight = keyboardFrame.height
        
        return keyboardHeight
    }
    
    private func adjustContentInsets(_ contentInsets: UIEdgeInsets) {
        contentInset = contentInsets
        
        scrollIndicatorInsets = {
            var newScrollIndicatorInsets = UIEdgeInsets.zero
            newScrollIndicatorInsets.bottom = contentInsets.bottom
            return newScrollIndicatorInsets
        }()
    }
    
}

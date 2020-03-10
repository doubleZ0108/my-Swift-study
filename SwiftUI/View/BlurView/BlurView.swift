//
//  BlueView.swift
//  DesignCode
//
//  Created by double Z on 2020/3/10.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)   //带system的会自动设配深色
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0) //at => z-index   0 => underneath everything
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}

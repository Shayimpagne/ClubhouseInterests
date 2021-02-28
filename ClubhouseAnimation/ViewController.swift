//
//  ViewController.swift
//  ClubhouseAnimation
//
//  Created by Emir on 24.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    let group = InterestsGroup(items: [
        [Interest(emoji: "🌊", title: "Art"),
         Interest(emoji: "🍣", title: "Food & Drink"),
         Interest(emoji: "👘", title: "Fashion"),
         Interest(emoji: "🤯", title: "Burning Man")],
        
        [Interest(emoji: "💃🏽", title: "Dance"),
         Interest(emoji: "🎭", title: "Theater"),
         Interest(emoji: "💈", title: "Advertising"),
         Interest(emoji: "💋", title: "Beauty"),
         Interest(emoji: "📚", title: "Books")],
        
        [Interest(emoji: "📷", title: "Photography"),
         Interest(emoji: "📖", title: "Writing"),
         Interest(emoji: "📐", title: "Architecture"),
         Interest(emoji: "🛸", title: "Sci-Fi"),
         Interest(emoji: "🎏", title: "Design")]
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = InterestGroupView()
        containerView.addSubview(view)
        view.bindToSuperview()
        view.setup(with: group)
    }

}

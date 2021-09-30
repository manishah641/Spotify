//
//  HapticsManagers.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation
import UIKit
final class HapticsManagers{
    static let shared=HapticsManagers()
    
    private init(){}
    
    public func vibrateForSelection(){
        DispatchQueue.main.async {
            let generator  = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let generator  = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}

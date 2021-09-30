//
//  PlayBackPresenter.swift
//  Spotify
//
//  Created by Syed Muhammad on 22/09/2021.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource:AnyObject {
    var songName:String? {get}
    var subtitle:String?{get}
    var imageURL:URL? {get}
}

final class PlayBackPresenter {
    static let shared = PlayBackPresenter()
    private var track : AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var player:AVPlayer?
    var playerQueue:AVQueuePlayer?
    var playerVC:PlayerViewController?
    
    var currentTrack:AudioTrack?{
        if let track = track ,tracks.isEmpty{
            return track
        }else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }
     func startPlayback(
        from viewcontroller:UIViewController,
        track:AudioTrack){
        guard let url  = URL(string: track.preview_url ?? "")else {return}
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.tracks = []
        self.track  = track
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource  = self
        vc.delegate  = self
        viewcontroller.present(UINavigationController(rootViewController: vc), animated: true) {[weak self]  in
            self?.player?.play()
            
        }
            self.playerVC = vc
    }
     func startPlayback(
        from viewcontroller:UIViewController,
        tracks:[AudioTrack]){
        self.tracks = tracks
        self.track  = nil
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap ({
         guard let url = URL(string: $0.preview_url ?? "") else {
            return nil
         }
           return AVPlayerItem(url: url)
            
        }))
            self.playerQueue?.volume  = 0.5
        self.playerQueue?.play()
        let vc = PlayerViewController()
        vc.dataSource  = self
        vc.delegate  = self
        viewcontroller.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            self.playerVC = vc
    }
}
extension PlayBackPresenter:PlayerViewControllerDelegate {
    func didSlideSlider(value: Float) {
        player?.volume = value
    }
    
    func didTapPlayPause() {
        if let player  = player{
            if player.timeControlStatus == .playing{
                player.pause()
            }else if player.timeControlStatus == .paused{
                player.play()
            }
        }else if let player = playerQueue{
            if player.timeControlStatus == .playing{
                player.pause()
            }else if player.timeControlStatus == .paused{
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
          
        }else if let player  = playerQueue  {
            player.advanceToNextItem()
            if index<tracks.count-1{
                index+=1

            }
            playerVC?.refreshUI()
            
        }
    }
    
    func didTapBack() {
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        }else if let firstItem = playerQueue?.items().first {

            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0.5
            
        }
    }
    
    
}
extension PlayBackPresenter:PlayerDataSource{
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    
}

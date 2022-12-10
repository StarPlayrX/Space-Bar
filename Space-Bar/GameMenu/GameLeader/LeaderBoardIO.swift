//
//  LeaderBoardIO.swift
//  Space-Bar
//
//  Created by Todd Bruss on 12/8/22.
//

import Foundation

//
//  Async.swift
//  StarPlayrX
//
//  Created by Todd Bruss on 5/7/20.
//  Copyright © 2020 Todd Bruss. All rights reserved.
//

import Foundation
import UIKit

//Completion Handlers
typealias DataHandler             = (_ data:Data?) -> Void
typealias TextHandler             = (_ text:String?) -> Void

func getData() {
    let dataUrl = "https://pearsc.com/spacebarlb"
    
    Async.api.CommanderData(endpoint: dataUrl, method: "getData") { (data) in
        guard let data = data
        else { return }
                
        do {
            let jsonDecoder = JSONDecoder()
            
            let lb = try jsonDecoder.decode([LeaderBoard].self, from: data)
            leaderBoard = lb
        } catch {
            print("Leaderboard Error:", error)
        }
    }
}



func sendText(score: Int, player: String, start: Int, stop: Int) {
    var player = player.replacingOccurrences(of: " ", with: "_")
    player = removeSpecialChars(player)
    
    let checksum = player.count + score + start + stop
    let pinpoint = "http://pearsc.com/spacebarup/\(player)/\(score)/\(start)/\(stop)/\(checksum)"
    Async.api.Text(endpoint: pinpoint, timeOut: 5 ) {  air in
        if air == "air" {
            DispatchQueue.global(qos: .background).async {
                getData()
            }
        } else {
            print("AIR", air)
        }
    }
}

func removeSpecialChars(_ text: String) -> String {
    let okayChars : Set<Character> =
        Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890-_")
    return String(text.filter {okayChars.contains($0) })
}


//MARK: Async
internal class Async {
    static let api = Async()
    
    //let g = Global.obj
    
    //MARK: Data
    internal func CommanderData(endpoint: String, method: String, DataHandler: @escaping DataHandler )  {
        guard let url = URL(string: endpoint) else { DataHandler(.none); return}
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.timeoutInterval = TimeInterval(10)
        urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in
            
            guard
                let d = data
            else {
                DataHandler(.none); return
            }
            
            DataHandler(d)
        }
        
        task.resume()
    }
    
    //MARK: Text
    internal func Text(endpoint: String, timeOut: Double = 5, TextHandler: @escaping TextHandler) {
        
        
        guard let url = URL(string: endpoint) else { TextHandler("error"); return}
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.timeoutInterval = TimeInterval(timeOut)
        urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in
            
            guard
                let d = data,
                let text = String(data: d, encoding: .utf8)
            else {
                TextHandler("error"); return
            }
            
            TextHandler(text)
        }
        
        task.resume()
    }
    
    
    
}

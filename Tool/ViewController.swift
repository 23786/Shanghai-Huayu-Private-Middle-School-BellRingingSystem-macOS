//
//  ViewController.swift
//  Tool
//
//  Created by apple on 2020/3/3.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa
import AVFoundation
import NotificationCenter

typealias NSLabel = NSTextField

var audioPlayer: AVAudioPlayer!
var lastMinute: String = "00"

class ViewController: NSViewController, NSUserNotificationCenterDelegate {

    @IBOutlet weak var TimerLabel: NSLabel!
    @IBOutlet weak var TimerLabel2: NSLabel!
    @IBOutlet weak var OpenPlaso: NSButton!
    var FirstTimer: DispatchSourceTimer!
    
    @IBOutlet var MainView: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateTime()
        updateTime2()
        
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .default)
        
        
        let timer2 = Timer(timeInterval: 60.0, target: self, selector: #selector(updateTime2), userInfo: nil, repeats: true)
        RunLoop.current.add(timer2, forMode: .default)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func updateTime() {
        let date = Date()//NSDate.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let string = dateFormatter.string(from: date)
        TimerLabel.stringValue = string
        
        // get the current second.
        let anotherDate = NSDate.now
        let anotherDateFormatter = DateFormatter()
        anotherDateFormatter.dateFormat = "mm"
        let anotherString = anotherDateFormatter.string(from: anotherDate)
        let a: Bool = anotherString != lastMinute
        lastMinute = anotherString
        print("anotherString.value = ", anotherString)
        
        if (string == "08:00" || string == "08:55" ||
            string == "09:45" || string == "10:45" || string == "13:00" ||
            string == "13:50" || string == "14:50" || string == "15:45") && a {
            sendUserNotification(title: "上课了！", subtitle: string)
            do {
                let path = Bundle.main.path(forResource: "上课铃声", ofType: "mp3")
                let soudURL = URL(fileURLWithPath: path!)
                try audioPlayer = AVAudioPlayer(contentsOf: soudURL)
                audioPlayer.prepareToPlay()
                audioPlayer.volume = 0.1
                audioPlayer.numberOfLoops = 0
                audioPlayer.play()
            } catch {
                fatalError()
            }
        }
        
        if (string == "09:45" || string == "13:50") && a {
            sendUserNotification(title: "眼保健操", subtitle: string)
            do {
                let path = Bundle.main.path(forResource: "最新眼保健操", ofType: "mp3")
                let soudURL = URL(fileURLWithPath: path!)
                try audioPlayer = AVAudioPlayer(contentsOf: soudURL)
                audioPlayer.prepareToPlay()
                audioPlayer.volume = 0.1
                audioPlayer.numberOfLoops = 0
                audioPlayer.play()
            } catch {
                fatalError()
            }
        }
        
        if (string == "08:40" || string == "09:35" ||
        string == "10:30" || string == "11:25" || string == "13:40" ||
        string == "14:35" || string == "15:30" || string == "16:25") && a {
            sendUserNotification(title: "下课了！", subtitle: string)
            do {
                let path = Bundle.main.path(forResource: "下课铃声", ofType: "mp3")
                let soudURL = URL(fileURLWithPath: path!)
                try audioPlayer = AVAudioPlayer(contentsOf: soudURL)
                audioPlayer.prepareToPlay()
                audioPlayer.volume = 0.1
                audioPlayer.numberOfLoops = 0
                audioPlayer.play()
            } catch {
                fatalError()
            }
        }
    }
    
    @objc func updateTime2() {
        let date = NSDate.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        let string = dateFormatter.string(from: date)
        TimerLabel2.stringValue = string
        
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool{
        return true
    }
    
    func sendUserNotification(title: String, subtitle: String) {
        let userNotification = NSUserNotification()
        userNotification.title = title
        userNotification.subtitle = subtitle
        userNotification.informativeText = ""
        let userNotificationCenter = NSUserNotificationCenter.default
        userNotificationCenter.delegate = self
        userNotificationCenter.scheduleNotification(userNotification)
    }
    @IBAction func OpenPlaso(_ sender: NSButton) {
        //let url = URL(string: "plaso://")
        NSWorkspace.shared.launchApplication("伯索")
        
    }
    @IBAction func OpenTencentMeeting(_ sender: NSButton) {
        NSWorkspace.shared.launchApplication("腾讯会议")
    }
}

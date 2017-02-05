//
//  ViewController.swift
//  ParaD_Remote
//
//  Created by David Para on 1/31/17.
//  Copyright © 2017 David Para. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    
    @IBOutlet weak var channelUpButton: UIButton!
    @IBOutlet weak var channelDownButton: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var favoritesSegControl: UISegmentedControl!
    
    // List of all buttons. Easier to control when adding more buttons and then turning them on and off.
    lazy var buttons: [UIButton] = [self.channelUpButton, self.channelDownButton, self.zero, self.one, self.two, self.three, self.four, self.five, self.six, self.seven, self.eight, self.nine]
    
    // Power Switch: on or off
    @IBAction func PowerSwitch(_ sender: UISwitch) {
        onOffLabel.text = sender.isOn ? "On" : "Off"
        powerSwitch.setOn(sender.isOn, animated: true)
        
        let onOrOff = (sender.isOn == true)
        remotePower(on: onOrOff)
    }

    // Volume control
    @IBAction func VolumeSlider(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value))"
    }
    
    // Channel up or down decision
    @IBAction func channelStep(_ sender: UIButton) {
        self.favoritesSegControl.selectedSegmentIndex = UISegmentedControlNoSegment
        if let upOrDown = sender.currentTitle {
            
            switch upOrDown {
            case "Ch +":
                channelUp()
            case "Ch -":
                channelDown()
            default:
                break
            }
            
        }
    }
    
    // Gets the channel number and concats a string of max count == 2. If count > 2, begins new string. Channel strings must be equal to 2. If user wants channel 01, user must press 0 and then 1.
    @IBAction func channelNumbers(_ sender: UIButton) {
        self.favoritesSegControl.selectedSegmentIndex = UISegmentedControlNoSegment
        if let channel = sender.currentTitle {
            if channelLabel.text == "0" && channel == "0" {
                channelLabel.text = "01"
            } else {
                if let digits = channelLabel.text?.characters.count {
                    if digits < 2 {
                        channelLabel.text?.append(channel)
                    } else {
                        channelLabel.text = channel
                    }
                }
            }
        }
    }
    
    // Favorite Channel
    @IBAction func favoriteChannelSegControl(_ sender: UISegmentedControl) {
        let favorite = sender.selectedSegmentIndex
        switch favorite {
        case 0:
            channelLabel.text = "17"
        case 1:
            channelLabel.text = "58"
        case 2:
            channelLabel.text = "30"
        case 3:
            channelLabel.text = "40"
        default:
            break
        }
    }
    
    // Gets current channel text, increases the number and prints to the channel label
    func channelUp () {
        if channelLabel != nil {
            var currentChannel = Int(channelLabel.text!)
            if currentChannel == 99 {
                currentChannel = 01
            } else {
                currentChannel! += 1
            }
            channelLabel.text = String(format: "%02d", currentChannel!)
        }
    }
    
    // Gets current channel text, decreases the number and prints to the channel label
    func channelDown () {
        if channelLabel != nil {
            var currentChannel = Int(channelLabel.text!)
            if currentChannel == 01 {
                currentChannel = 99
            } else {
                currentChannel! -= 1
            }
            channelLabel.text = String(format: "%02d", currentChannel!)
        }
    }
    
    // Activates/Deactivates volume, buttons and favorites
    func remotePower(on onOrOff: Bool) {
        volumePower(on: onOrOff)
        buttonsPower(on: onOrOff)
        favoritesPower(on: onOrOff)
    }
    
    // Activates/Deactivates the volume slider
    func volumePower(on OnOrOff: Bool) {
        volumeSlider.isEnabled = OnOrOff
    }
    
    // Activates/Deactivates the channel control buttons
    func buttonsPower(on onOrOff: Bool) {
        for button in self.buttons {
            button.isEnabled = onOrOff
        }
    }
    
    // Activates/Deactivates the favorites controls
    func favoritesPower(on onOrOff: Bool) {
        favoritesSegControl.isEnabled = onOrOff
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remotePower(on: false)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  NumberPad.swift
//  $Mate
//
//  Created by 郭振永 on 15/5/8.
//  Copyright (c) 2015年 guozy. All rights reserved.
//

import UIKit
protocol NumberPadDelegate {
    func tappedNumber(_ text: String)
    func tappedOK()
}

class NumberPad: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var padding: CGFloat = 0
    var font: UIFont = UIFont(name: "Avenir-Heavy", size: 18)!
    var fontColor: UIColor = UIColor.white
    var delegate: NumberPadDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.addSubview(blurEffectView)
        
        initNumberView()
    }
    
    var string: String = ""
    var dotTapped: Bool = false
    var afterDotTappedTapNumber: Int = 0

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initNumberView() {
        let width: CGFloat = (frame.width - padding) / 4
        let height: CGFloat = frame.height / 4
        for i in 1 ..< 10 {
            let label: UILabel = UILabel(frame: CGRect(x: width * CGFloat((i - 1) % 3), y: height * CGFloat(Int((i - 1) / 3)), width: width, height: height))
            label.text = "\(i)"
            label.font = font
            label.textColor = fontColor
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(NumberPad.tappedNumber(_:)))
            label.addGestureRecognizer(tap)
            addSubview(label)
        }
        let labelName = [".", "0", "⌫"]
        for (index, name) in labelName.enumerated() {
            let label: UILabel = UILabel(frame: CGRect(x: width * CGFloat(index), y: height * CGFloat(3), width: width, height: height))
            label.text = "\(name)"
            label.font = font
            label.textColor = fontColor
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(NumberPad.tappedNumber(_:)))
            label.addGestureRecognizer(tap)
            addSubview(label)
        }
        let controllerName = ["C", "OK"]
        for (index, name) in controllerName.enumerated() {
            let label: UILabel = UILabel(frame: CGRect(x: width * CGFloat(3), y: height * CGFloat(2 * index), width: width, height: height * CGFloat(2)))
            label.text = "\(name)"
            label.font = font
            label.textColor = fontColor
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(NumberPad.tappedNumber(_:)))
            label.addGestureRecognizer(tap)
            addSubview(label)
        }
    }
    
    func tappedNumber(_ sender: UITapGestureRecognizer) {
        if string == "0" {
            string = ""
        }
        if let label = sender.view as? UILabel{
            if let text = label.text {
                if dotTapped {
                    if text == "." {
                        
                    } else if text == "⌫" {
                        afterDotTappedTapNumber -= 1
                        let index = string.characters.index(string.endIndex, offsetBy: -1);
                        string = string.substring(to: index)
                        if afterDotTappedTapNumber < 0 {
                            afterDotTappedTapNumber = 0
                            dotTapped = false
                        }
                    } else if text == "C" {
                        dotTapped = false
                        afterDotTappedTapNumber = 0
                        string = "0"
                    } else if text == "OK" {
                        delegate!.tappedOK()
                    }else {
                        afterDotTappedTapNumber += 1
                        if afterDotTappedTapNumber > 2 {
                            afterDotTappedTapNumber = 2
                            let index = string.characters.index(string.endIndex, offsetBy: -1);
                            let newstring = string.substring(to: index)
                            string = newstring + text
                        } else {
                            string = string + text
                        }
                    }
                } else {
                    switch text {
                    case "0": string = string + text
                    case "1": string = string + text
                    case "2": string = string + text
                    case "3": string = string + text
                    case "4": string = string + text
                    case "5": string = string + text
                    case "6": string = string + text
                    case "7": string = string + text
                    case "8": string = string + text
                    case "9": string = string + text
                    case "C": string = "0"
                    case ".":
                        dotTapped = true
                        if string.isEmpty {
                            string = "0" + text
                        } else {
                            string = string + text
                        }
                    case "⌫":
                        if string == "0" || string == "" {
                            return
                        }
                        let index = string.characters.index(string.endIndex, offsetBy: -1);
                        let newstring = string.substring(to: index)
                        if newstring.isEmpty {
                            string = "0"
                        } else {
                            string = newstring
                        }
                    case "OK":
                        delegate!.tappedOK()
                    default: return
                    }
                }
            }
        }
        if string == "" {
            string = "0"
        }
        let label = sender.view as? UILabel
        if label?.text != "OK" {
            delegate?.tappedNumber(string)
        }
    }
}



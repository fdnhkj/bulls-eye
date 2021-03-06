//
//  ViewController.swift
//  BullsEye
//
//  Created by Fidan Hakaj on 14/02/2019.
//  Copyright © 2019 Fidan Hakaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var currentValue = 0
  var targetValue = 0
  var score = 0
  var currentRound = 0
    
  @IBOutlet weak var targetValueLabel: UILabel!
  @IBOutlet weak var slider:UISlider!
  @IBOutlet weak var scoreValueLabel: UILabel!
  @IBOutlet weak var roundValueLabel: UILabel!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    currentValue = Int(slider.value.rounded())
    startOver()
    
    let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
    slider.setThumbImage(thumbImageNormal, for: .normal)
    
    let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
    slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

    let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
    let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizable, for:.normal)
    
    let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
    let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizable, for:.normal)
  }

  @IBAction func showAlert() {
    let difference: Int = abs(currentValue - targetValue)
    var points = 100 - difference
        
    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "You almost had it!"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      title = "Pretty good!"
    } else {
      title = "Not even close..."
    }

    score += points
        
    let message = "You scored \(points) points"
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
    let action = UIAlertAction(title: "Awesome", style: .default, handler: {
      action in
        self.startNewRound()
    })

    alert.addAction(action);
    
    present(alert, animated: true, completion: nil);
  }
    
  @IBAction func onSliderValueChange(_ sender: UISlider) {
    currentValue = Int(sender.value.rounded())
  }
    
  func startNewRound() {
    currentRound += 1
    targetValue = Int.random(in: 1...100)
    currentValue = 50
    slider.value = Float(currentValue)
    updateLabels()
  }

  func updateLabels() {
    targetValueLabel.text = String(targetValue)
    scoreValueLabel.text = String(score)
    roundValueLabel.text = String(currentRound)
  }
  
  @IBAction func startOver() {
    score = 0
    currentRound = 0
    startNewRound()
  }
}

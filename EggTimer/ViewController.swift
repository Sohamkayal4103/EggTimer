//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = [
        "Soft" : 1,
        "Medium" : 7,
        "Hard" : 12
    ];
    var seconds = 15;
    var totalSeconds = 15;
    var timer = Timer();
    var player: AVAudioPlayer?
    var playAudio = true;
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle 
        else { return }
        runTimer(secs: eggTimes[hardness]!);
        
    }
    
    func runTimer(secs: Int) {
        timer.invalidate();
        seconds = secs;
        totalSeconds = secs;
        progressBar.setProgress(0.0, animated: true);
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        let progressFraction : Float = Float(totalSeconds - seconds) / Float(totalSeconds);
        progressBar.setProgress(progressFraction, animated: true);
        if(seconds == 0){
            endTimer();
            //print("Timer Complete");
            displayLabel.text = "Eggs done!";
            playSound();
            return;
        }
        print("Time Remaining: \(seconds)");
        seconds -= 1;
        
    }
    
    func endTimer(){
        timer.invalidate();
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url);
            player?.play();
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    @IBAction func resetTimer(_ sender: UIButton) {
        timer.invalidate();
        playAudio = false;
        seconds = totalSeconds;
        runTimer(secs: seconds);
    }
}

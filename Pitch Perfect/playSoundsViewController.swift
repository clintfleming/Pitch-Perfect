//
//  playSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Clinton Fleming on 2/26/15.
//  Copyright (c) 2015 Clinton Fleming. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // button to play the sound at a rate 1.5 faster than normal
    @IBAction func fastButtonAction(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        
        audioPlayer.play()
    }

    
    // stop the audio playback
    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    // play the sound at half the normal rate
    @IBAction func slowButtonAction(sender: UIButton) {
        
        audioPlayer.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
       
        audioPlayer.play()
    }

    // add some darthvader sounds!
    @IBAction func darthvaderButton(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
    }
    
    // Make the sound like a chipmunk
    @IBAction func chipmunkButton(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        // Stop the audio player and engine incase they were already in use
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

}

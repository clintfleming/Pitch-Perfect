//
//  RecordAudioViewController.swift
//  Pitch Perfect
//
//  Created by Clinton Fleming on 2/26/15.
//  Copyright (c) 2015 Clinton Fleming. All rights reserved.
//

import UIKit
import AVFoundation


// This is the implementation to Record audio for play back
class ViewController: UIViewController, AVAudioRecorderDelegate {


    @IBOutlet weak var stopAudio: UIButton!     // Making global to be able to hide when not playing audio
    @IBOutlet weak var RecordingInProgress: UILabel!  // used to hide/show the Recording textbox
    @IBOutlet weak var recordButton: UIButton!        // used to be able to change the settings of the record button, mainly the color to indicate its in use
    
    
    //Declared Globally
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopAudio.hidden        = true
        recordButton.enabled    = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // update views on the screen to indicate that a recording is taking place.
        recordButton.enabled = false
        RecordingInProgress.hidden = false
        stopAudio.hidden = false
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // set the name of the audio file to the current date including seconds so its always different.
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        // create a shared instace of a audio sesson
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        
        
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if (flag){
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
        
            // once the stop audio button is pressed, wait until it is saved and then pass the file name via a seque
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else{
            //error handling, re-show record button.
            println("Recording was not successful")
            recordButton.enabled = true
            stopAudio.hidden = true
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC:playSoundsViewController = segue.destinationViewController as playSoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    // hanlde the button press of the stop audio button.
    @IBAction func stopAudio(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        RecordingInProgress.hidden = true
    }

}


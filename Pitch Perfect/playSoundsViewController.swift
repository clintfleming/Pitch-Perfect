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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            var fileUrl = NSURL.fileURLWithPath(filePath)
             audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl, error: nil)
             audioPlayer.enableRate = true
        }else{
            println("File did not load")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fastButtonAction(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        
        audioPlayer.play()
    }

    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
    }
    @IBAction func slowButtonAction(sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.rate = 0.5
       
        audioPlayer.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

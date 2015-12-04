//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Ricardo Lamadrid on 02/12/2015.
//  Copyright © 2015 Lamadrid. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var audioPlayer2: AVAudioPlayer!
    var audioPlayer3: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let filePathUrl = NSBundle.mainBundle().URLForResource("way_up_rick", withExtension: "mp3")
        let filePathUrl2 = NSBundle.mainBundle().URLForResource("what_is_morty", withExtension: "mp3")
        
        audioPlayer = try!
            AVAudioPlayer(contentsOfURL: filePathUrl!)
        audioPlayer2 = try!
            AVAudioPlayer(contentsOfURL: filePathUrl2!)
        audioPlayer3 = try!
            AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint:nil)
        
        audioPlayer.enableRate = true
        audioPlayer2.enableRate = true
        audioPlayer3.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    @IBAction func rickAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func mortyAudio(sender: UIButton) {
        audioPlayer2.stop()
        audioPlayer2.rate = 1
        audioPlayer2.currentTime = 0.0
        audioPlayer2.play()
    }
    
    @IBAction func stopRate(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer2.stop()
        audioPlayer3.stop()
        audioEngine.stop()
    }
    
    @IBAction func fastAudio(sender: UIButton) {
        audioPlayer3.stop()
        audioPlayer3.rate = 1.5
        audioPlayer3.currentTime = 0.0
        audioPlayer3.play()
    }
    
    @IBAction func slowAudio(sender: UIButton) {
        audioPlayer3.stop()
        audioPlayer3.rate = 0.5
        audioPlayer3.currentTime = 0.0
        audioPlayer3.play()
    }

    @IBAction func chipAudio(sender: UIButton) {
        audioPlayer3.stop()
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func vaderAudio(sender: UIButton) {
        audioPlayer3.stop()
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

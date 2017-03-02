//
//  SoundAddViewController.swift
//  MicroPhone
//
//  Created by Apple on 3/2/17.
//  Copyright © 2017 itsviplove. All rights reserved.
//

import UIKit
import AVFoundation

class SoundAddViewController: UIViewController {
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioUrl : URL?
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var soundTextfield: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupRecorder()
        playButton.isEnabled = false
    }
    
    func setupRecorder() {
        do {
            // Create An Audio Session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL For AudioFile 
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
                audioUrl = NSURL.fileURL(withPathComponents: pathComponents)!
            
            // Create Setting for Audio Recorder 
            
            var settings : [String : AnyObject] = [:]
            settings[AVFormatIDKey] = kAudioFormatMPEG4AAC as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            // Create Audio Recorder Object
            
            audioRecorder = try AVAudioRecorder(url: audioUrl!, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
                print(error)
            }
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            // Stop the recording
            audioRecorder?.stop()
            
            // change button title to record
            recordButton.setTitle("Record", for: .normal)
            //Enable the Play button to Play
            playButton.isEnabled = true
        } else {
            // start the recording
            audioRecorder?.record()
            
            //change button title to Stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioUrl!)
            audioPlayer!.play()
            
        } catch {}
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
}

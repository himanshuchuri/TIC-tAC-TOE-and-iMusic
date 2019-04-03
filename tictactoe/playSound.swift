//
//  playSound.swift
//  iMacTicTacToe
//
//  Created by Pawan Badsewal on 03/04/19.
//  Copyright © 2019 Pawan Badsewal. All rights reserved.
//

import AVFoundation

var AudioPlayer: AVAudioPlayer!




func playAudio(){
    let path = Bundle.main.path(forResource: "BackgroundMusic" , ofType: "mp3")!
    let url = URL(fileURLWithPath: path)
    do{
        AudioPlayer = try AVAudioPlayer(contentsOf: url)
        AudioPlayer.prepareToPlay()
    }
    catch let error as NSError{
        print(error.description)
    }
    AudioPlayer.numberOfLoops = -1
    AudioPlayer.play()
}



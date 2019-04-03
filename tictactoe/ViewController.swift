//
//  ViewController.swift
//  tictactoe
//
//  Created by Student on 03/04/19.
//  Copyright © 2019 ACE. All rights reserved.
//
// action= when clicked or touvhed it is activated
// outlet= defines that it is the element of the ui board

import UIKit
import AVFoundation //

class ViewController: UIViewController {

    var turn:Bool = true
    
    var board:Array<String> = [" "," "," "," "," "," "," "," "," "]
    
    let winningcombos:Array<[Int]> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var y:Bool = true
    
    var btarray:Array<UIButton>!

    
    
    @IBOutlet var result: UILabel!
    @IBOutlet var reset: UIButton!
    
    @IBOutlet var firb: UIButton!
    @IBOutlet var secb: UIButton!
    @IBOutlet var thirb: UIButton!
    @IBOutlet var firtb: UIButton!
    @IBOutlet var fifb: UIButton!
    @IBOutlet var sixb: UIButton!
    @IBOutlet var sevb: UIButton!
    @IBOutlet var eigb: UIButton!
    @IBOutlet var ninb: UIButton!
    
    var audioPlayer: AVAudioPlayer!

    
    // let is used to define a constant
    // -> used to specify the return type of a fxn
    func check(){
        for combo in winningcombos{
        if( board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] && board[combo[0]] != " ") // gives if X or O is present at the position in the array
            {

                if(board[combo[0]] == "X")
                {
                    result.text = "X is the Winner"
                    result.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
                else
                {
                    result.text = "O is the Winner"
                    result.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
                
           y = false
              break //
          
        }
            else
            {

                var count = 0
                for i in 0...8
                {
                    if(board[i] != " ")
                    {
                        count += 1
                        
                    }
                    if (count == 9)
                    {
                        result.text = "It is a Tie"
                        result.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        y = false
                    }
                }
            }
        }
    }
        
    @IBAction func buttontap(_ sender: UIButton)// object for button
    {
        if(y)
        {
        if (board[sender.tag] == " ") // check if tag is empty
        {
        if(turn)
        {
        sender.setImage(#imageLiteral(resourceName: "NeonX"), for: .normal) // . normal os the type of selection(cliclk/touch)
            playAudio(targetSound: "xPop")
        board[sender.tag] = "X" // assigne the value X or o
        }else{
        sender.setImage(#imageLiteral(resourceName: "NeonO"), for: .normal)
        playAudio(targetSound: "oPop")
        board[sender.tag] = "O"

        }
        turn = !turn
            check()
            if(!y)
            {
                result.isHidden = false
                reset.isHidden = false
            }
    }
        }
    }
    
    @IBAction func Reset(_ sender: Any) {
        playAudio(targetSound: "Ding")
        board = [" "," "," "," "," "," "," "," "," "]
        y = true
        turn = true
        for btn in btarray
        {
            btn.setImage(nil, for: .normal)
            
        }
        result.isHidden = true
        reset.isHidden = true

    }

    func playAudio(targetSound:String) // argument of type string created inside fxn parameters
    {
        let path = Bundle.main.path(forResource: targetSound , ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
        }
        catch let error as NSError{
            print(error.description)
        }
        audioPlayer.numberOfLoops = 1
        audioPlayer.play()
    }

    
    
    override func viewDidLoad() // overriding=> name of fxn same and parameters different. it is the first priority fxn.  fxn loads when view is loaded.
    {
        super.viewDidLoad() // sets buttons and lables
        btarray = [firb, secb, thirb,firtb, fifb, sixb, sevb, eigb, ninb,]
        // Do any additional setup after loading the view, typically from a nib.
    }


}


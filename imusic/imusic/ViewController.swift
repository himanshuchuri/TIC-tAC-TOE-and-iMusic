//
//  ViewController.swift
//  imusic
//
//  Created by Himanshu Churi on 4/4/19.
//  Copyright © 2019 Himanshu Churi. All rights reserved.
//

import UIKit
import AVFoundation

var AudioPlayer: AVAudioPlayer!

struct songInfo
{
    var songArtwork:UIImage
    var songArtname:String
    var songName:String
    
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var menuCV: UICollectionView!
    @IBOutlet var b1: UIButton!
    
    var data:Data!
    var jsonResult:NSDictionary!
    
    var turn: Bool = false
    var ini: Bool = true

    @IBAction func plpu(_ sender: UIButton) {
        //while(true)
       // {
            if(turn == true)
            {
                sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                AudioPlayer.pause()
                turn = false
            }
            else
            {
                if(ini == true)
                {
                    playSound(targetSound: "OnAndOn")
                    AudioPlayer.play()
                    sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                    ini = false
                }
                else
                {
                    AudioPlayer.play()
                    sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                }
                turn = true
            }
       // }
    }
    

    func playSound(targetSound:String)
    {
        let path = Bundle.main.path(forResource: "songs/\(targetSound)" , ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do{
            AudioPlayer = try AVAudioPlayer(contentsOf: url)
            AudioPlayer.prepareToPlay()
        }
        catch let error as NSError
        {
            print(error.description)
        }
        AudioPlayer.play()
        b1.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        turn = false
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let songInfo = jsonResult["\( indexPath.row)"] as? [String]
        {
            playSound(targetSound: songInfo[1])
        }
    }
    
    func openJson(){
        let path = Bundle.main.path(forResource: "songsDB", ofType: "json")
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
            
        } catch{
            print("Error")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return jsonResult.count-1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "songsCVC", for: indexPath) as! songsCVC
        if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let songInfo = jsonResult["\( indexPath.row)"] as? [String]{
            print(songInfo)
            print(songInfo[0])
            print(songInfo[1])
            print(songInfo[2])
            cell.songImg.image = UIImage(named: songInfo[0])
            cell.songNamelbl.text = songInfo[1]
            cell.songArtistlbl.text = songInfo[2]
        }
        
        return cell
    }
    
   


    override func viewDidLoad() {
        super.viewDidLoad()
        openJson()
        // Do any additional setup after loading the view.
        
        let cellWidth = UIScreen.main.bounds.width / 2 - 25
        let cellHeight = cellWidth * 1.3125
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        menuCV.collectionViewLayout = collectionLayout
        menuCV.allowsMultipleSelection = false
        menuCV.register(UINib(nibName: "songsCVC", bundle: nil), forCellWithReuseIdentifier: "songsCVC")
    }


}


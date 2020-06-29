//
//  ViewController.swift
//  wok2
//
//  Created by jf19abc on 15/01/2020.
//  Copyright © 2020 jf19abc. All rights reserved.
//

import UIKit
import simd
import SpriteKit
import AVFoundation

protocol subviewDelegate
{
    func goBall()
}

class ViewController: UIViewController, subviewDelegate{
     
    @IBAction func button(_ sender: UIButton) {
    }
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehaviour: UIDynamicItemBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var collisionBehaviour: UICollisionBehavior!
    var counterBall = 0
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "btn_click_sound", ofType: "mp3")!)
   var audioPlayer = AVAudioPlayer()
    
    var initime = 15
    
    
    var timer = Timer()
    @IBOutlet var timerLabel: UILabel!
    
    func goBall() {
        
        // Instantiate ball
      
        // this is our array of arrays
        var balls = [String]()
        
        var ballsA = ["England", "Ireland", "Scotland", "Wales"]


        // we now append an item to one of the arrays
        //balls[counterBall].append("ball\(counterBall)")
        //print("\nAfter adding Costa Rica, the groups are:", balls)
        
        let imageName = "ball.png"
        let image = UIImage(named: imageName)
        let ball = UIImageView(image: image!)
        let pA = CGPoint(x: Aim.center.x, y: Aim.center.y)
        let pB = CGPoint(x: Aim.resetPosition.x, y: Aim.resetPosition.y)
        // Vector from A to B
        let vecAB = CGVector(dx: pB.x - pA.x, dy: pB.y - pA.y)
        print(vecAB)
        let spawnerx = CGFloat(Aim.resetPosition.x) - vecAB.dx
        let spawnery = CGFloat(Aim.resetPosition.y) - vecAB.dy
        ball.frame = CGRect(x: spawnerx, y: spawnery+40, width: 40, height: 40)
        view.addSubview(ball)
        counterBall = counterBall + 1
        
        //gravity to balls
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        

        gravityBehaviour = UIGravityBehavior(items: [ball])
        
        collisionBehaviour = UICollisionBehavior(items: [ball])
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = true
        
        
        
        dynamicItemBehaviour = UIDynamicItemBehavior(items: [ball])
        self.dynamicItemBehaviour.addLinearVelocity(CGPoint(x: 300, y: 300), for: ball)
        self.dynamicItemBehaviour.addAngularVelocity(150, for: ball)
        
        
        dynamicAnimator.addBehavior(gravityBehaviour)
        dynamicAnimator.addBehavior(dynamicItemBehaviour)
        dynamicAnimator.addBehavior(collisionBehaviour)
        
    }
    
        //countdown
    @objc func cntdwn(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.cnt), userInfo: nil, repeats: true)
        //initial time
        initime = 15
        label2.text = String(initime)
    }
    @IBAction func PianoC(sender: AnyObject) {
       do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
            audioPlayer.play()
       } catch {
          // couldn't load file
       }
   }
    //counter
    @objc func cnt() {
        initime -= 1
        label2.text = String(initime)
        
        //if timer = 0
        if initime == 0 {
//          print(setTimer)
            timer.invalidate()
            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(ViewController.endgame), userInfo: nil, repeats: false)
        }
    }
    //endgame view
    @objc func endgame(){
       
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBOutlet weak var birdsview: UIView!
    @IBOutlet weak var Aim: DragImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Aim.myDelegate = self
        // Instantiate bird
        let randomMax = Int.random(in: 2..<12)
        for n in 1...randomMax {
            let birdName = "bird\(n).png"
            let birdImage = UIImage(named: birdName)
            let bird = UIImageView(image: birdImage!)
            let randomX = Int.random(in: 8..<163)
            let randomY = Int.random(in: 0..<266)
            bird.frame = CGRect(x: randomX, y: randomY, width: 62, height: 56)
            birdsview.addSubview(bird)
            
        }
        cntdwn()
    }
}


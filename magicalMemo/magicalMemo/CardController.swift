//
//  CardController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/04.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class CardController: UIViewController {

    @IBOutlet weak var backCard: UIView!
    
    var centerOfCard:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = backCard.center

    }
    
    func reset() {
        backCard.center = self.centerOfCard
        backCard.transform = .identity
    }
    
    @IBAction func swip(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        let xPointCard = card.center.x - view.center.x
        card.transform = CGAffineTransform(rotationAngle: xPointCard / (view.frame.width / 2) * -0.785)
        
        //ドラッグを離した時
        if sender.state == UIGestureRecognizer.State.ended{
            if card.center.x < 75{
                reset()
            }else if card.center.x > view.frame.width - 75{
                reset()
            }
            
            UIView.animate(withDuration: 0.2) {
                self.reset()
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

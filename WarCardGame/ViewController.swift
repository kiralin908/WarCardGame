//
//  ViewController.swift
//  WarCardGame
//
//  Created by 林郁琦 on 2024/2/29.
//

import UIKit
import Foundation
//自創撲克牌型別，把花色跟點數用String宣告
struct Card {
    var suit: String
    var rank: String
}

class ViewController: UIViewController {
    
    //把需要設定的UI元件拉進Outlet
    @IBOutlet weak var bankerCard: UIImageView!
    @IBOutlet weak var playerCard: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    //建立52張牌
    var cards = [Card]()
    func createCard() {
        let suits = ["C", "D", "H", "S"]
        let ranks = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
        for suit in suits {
            for rank in ranks {
                let card = Card(suit: suit, rank: rank)
                cards.append(card)
                
            }
        }
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCard()
        resultLabel.layer.cornerRadius = 5
        resultLabel.clipsToBounds = true
        
        
        
    }
    //宣告花色大小的方法
    func cardSuitsNumber(suit: String) -> Int {
        var number = 0
        switch suit {
        case "C":
            number = 1
        case "D":
            number = 2
        case "H":
            number = 3
        default:
            number = 4
        }
        return number
    }
    //宣告點數大小的方法
    func cardRanksNumber(rank: String) -> Int {
        var number = 0
        switch rank {
        case "A":
            number = 1
        case "J":
            number = 11
        case "Q":
            number = 12
        case "K":
            number = 13
        default:
            number = Int(rank)!
        }
        return number
    }
    //設定play按鈕，比較莊家和玩家的花色跟點數，結果顯示到Label上
    @IBAction func playButton(_ sender: Any) {
        cards.shuffle()
        
        var bankerCard = cards.removeFirst()
        var playerCard = cards.removeFirst()
        while bankerCard.suit == playerCard.suit && bankerCard.rank == playerCard.rank {
            bankerCard = cards.removeFirst()
        }
        
        self.bankerCard.image = UIImage(named: "\(bankerCard.suit)\(bankerCard.rank)")
        self.playerCard.image = UIImage(named: "\(playerCard.suit)\(playerCard.rank)")
        
        let bankerRankNumber = cardRanksNumber(rank: bankerCard.rank)
        let playerRankNumber = cardRanksNumber(rank: playerCard.rank)
        if bankerRankNumber > playerRankNumber {
            resultLabel.text = "YOU LOST!"
        } else if  bankerRankNumber < playerRankNumber{
            resultLabel.text = "YOU WIN!"
        } else {
            let bankerSuitNumber = cardSuitsNumber(suit: bankerCard.suit)
            let playerSuitNumber = cardSuitsNumber(suit: playerCard.suit)
            if bankerSuitNumber > playerSuitNumber {
                resultLabel.text = "YOU LOST!"
            } else {
                resultLabel.text = "YOU WIN!"
            }
        }
    }
}


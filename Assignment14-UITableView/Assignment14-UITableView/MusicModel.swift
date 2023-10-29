
import UIKit

class Music {
    var image: UIImage
    var name: String
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    static let dummyData = [
        Music(image: UIImage(named: "endlessSacrifice")!, name: "Endless Sacrifice"),
        Music(image: UIImage(named: "nihilist")!, name: "Nihilist"),
        Music(image: UIImage(named: "mrhighway")!, name: "Mr.Highway's Thinking About The End"),
        Music(image: UIImage(named: "ceremony")!, name: "Ceremony"),
        Music(image: UIImage(named: "heaven")!, name: "Heaven Shall Burn"),
        Music(image: UIImage(named: "hallowed")!, name: "Hallowed By Thy Name"),
        Music(image: UIImage(named: "welcome")!, name: "Welcome To The Black Parade"),
        Music(image: UIImage(named: "dying")!, name: "The Dying Song"),
        Music(image: UIImage(named: "theman")!, name: "The Man Who Sold The World"),
        Music(image: UIImage(named: "theday")!, name: "The Day The World Went Away"),
        Music(image: UIImage(named: "nomore")!, name: "No More Sorrow"),
        Music(image: UIImage(named: "snakes")!, name: "And The Snakes Start To Sing")
    ]
    
}

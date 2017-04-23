//
//  ViewController.swift
//  PackingList
//
//  Created by chenzhongsong on 16/3/28.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonMenu: UIButton!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!

    
    var slider: HorizontallItemList!
    var isMenuOpen = false
    var items: [Int] = [5, 6, 7]

    @IBAction func actionToggleMenu(sender: AnyObject) {
        
        for con in titleLable.superview!.constraints {
            print(" -> \(con.description)")
        }
        
        isMenuOpen = !isMenuOpen
        
        for constraint in titleLable.superview!.constraints {
            
            if constraint.firstItem as? NSObject == titleLable && constraint.firstAttribute == .CenterX {
                constraint.constant = isMenuOpen ? -100.0 : 0.0
                continue
            }
            
            if constraint.identifier == "TitleCenterY" {
                constraint.active = false
                
                let newConstraint = NSLayoutConstraint(item: titleLable,
                    attribute: .CenterY,
                    relatedBy: .Equal,
                    toItem: titleLable.superview,
                    attribute: .CenterY,
                    multiplier: isMenuOpen ? 0.67 : 1.0,
                    constant: 5.0)
                
                newConstraint.identifier = "TitleCenterY"
                newConstraint.active = true
                
                continue
            }
        }
        
        
        menuHeightConstraint.constant = isMenuOpen ? 200 : 60
        titleLable.text = isMenuOpen ? "Select item" : "Packing List"
//        self.view.layoutIfNeeded()
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .CurveEaseIn, animations: { () -> Void in
            self.view.layoutIfNeeded()
            let angle = self.isMenuOpen ? CGFloat(M_PI_4) : 0.0
            self.buttonMenu.transform = CGAffineTransformMakeRotation(angle)
            }, completion: nil)
        
        
        //添加滚动视图
        if isMenuOpen {
            slider = HorizontallItemList(inView: view)
            slider.backgroundColor = UIColor.lightGrayColor()
            slider.didSelectItem = { index in
                print("add \(index)")
                self.items.append(index)
                self.tableView.reloadData()
                self.actionToggleMenu(self)
            }
            self.titleLable.superview!.addSubview(slider)//?.
        } else {
            slider.removeFromSuperview()
        }
   
    }
    
    func showItem(index: Int) {
    
        print("tapped item \(index)")
        
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_0\(index).png"))
        imageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        //添加约束
        let conX = imageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let conBottom = imageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: imageView.frame.height)
        let conWidth = imageView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.33, constant: -50)
        let conHeight = imageView.heightAnchor.constraintEqualToAnchor(imageView.widthAnchor)//宽和高相等
        NSLayoutConstraint.activateConstraints([conX, conBottom, conWidth, conHeight])
        
        view.layoutIfNeeded()
        
//        //修改约束
        UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            conBottom.constant = -imageView.frame.size.height/2
            conWidth.constant = 0.0
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        //消失
        UIView.animateWithDuration(0.8, delay: 1.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            conBottom.constant = imageView.frame.size.height
            conWidth.constant = -50.0
            self.view.layoutIfNeeded()
            }) { _ in
                imageView.removeFromSuperview()
        }
    }

    
}


let itenTitles = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView?.rowHeight = 54.0 //.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) //as UITableViewCell
        cell.accessoryType = .None
        cell.textLabel?.text = itenTitles[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        showItem(items[indexPath.row])
    }

}











































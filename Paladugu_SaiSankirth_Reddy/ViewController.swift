//
//  ViewController.swift
//  Puzzle Game
//
//  Created by Sai Sankirth Reddy Paladugu on 2/20/22
//

import UIKit

class ViewController: UIViewController {
    
    
    let mySpacing: CGFloat = 5.0
    
    var answerViews = [UIImageView]()
    
    var flag: Bool = false
    
    let shuffleButton: UIButton = {
        let s = UIButton()
        s.setTitle("Shuffle", for: .normal)
        s.backgroundColor = .yellow
        s.setTitleColor(.black, for: .normal)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.layer.cornerRadius = 10
        s.titleLabel?.font = UIFont(name: "Futura", size: 20)
        s.addTarget(self, action: #selector(shuffle), for: .touchUpInside)
        return s
    }()
    
    
    var shuffleDecision = false
    
    
    var answerButton: UIButton = {
        let s = UIButton()
        s.setTitle("Show answer", for: .normal)
        s.backgroundColor = .yellow
        s.setTitleColor(.black, for: .normal)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.layer.cornerRadius = 10
        s.titleLabel?.font = UIFont(name: "Futura", size: 20)
        s.addTarget(self, action: #selector(answer), for: .touchUpInside)
        return s
    }()
    
    let nameLabel: UILabel = {
       let n = UILabel()
        n.text = "Sai Sankirth Reddy"
        n.textColor = .orange
        n.font = UIFont(name: "Futura Bold", size: 20)
        n.translatesAutoresizingMaskIntoConstraints = false
        return n
    }()
    var views = [UIImageView]()
    var images = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"] // taking images in the array

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        if views.count == 0{
            //print("no count")
        setupViews()
        }
        navigationItem.hidesBackButton = true
        view.addSubview(shuffleButton)
        view.addSubview(answerButton)
        view.backgroundColor = .black
        view.addSubview(nameLabel)
        if shuffleDecision == true{
            views.shuffle()
        }
        for i in views{
            view.addSubview(i)
        }
        view.addSubview(shuffleButton)
        view.addSubview(answerButton)
    }
    
    
    @objc func tapped(_ gesture: UITapGestureRecognizer){   // tap gestures
        let currentImageIndex = views.firstIndex(of: gesture.view as! UIImageView)!
        if currentImageIndex < 19 && views[currentImageIndex+1].image == nil{
            let temp = views[currentImageIndex].image
            views[currentImageIndex].image = nil
            views[currentImageIndex+1].image = temp
            checkStatus()
        }else if currentImageIndex > 0 && views[currentImageIndex-1].image == nil{ // checking for the empty spot in the image to move the tile
            let temp = views[currentImageIndex].image
            views[currentImageIndex].image = nil
            views[currentImageIndex-1].image = temp
            checkStatus()
        }else if currentImageIndex < 16 && views[currentImageIndex+4].image == nil{
            let temp = views[currentImageIndex].image
            views[currentImageIndex].image = nil
            views[currentImageIndex+4].image = temp
            checkStatus()
        }else if currentImageIndex > 3 && views[currentImageIndex-4].image == nil{
            let temp = views[currentImageIndex].image
            views[currentImageIndex].image = nil
            views[currentImageIndex-4].image = temp
            checkStatus()
        }else{
            //print("false")
        }
    }
    
    
    
    
    func setupViews(){        // setting up the view 
        let n = images.count
        
        for i in 0..<n{
            let gestureRec = UITapGestureRecognizer(target: self, action: #selector(tapped))
            gestureRec.numberOfTapsRequired = 1
            gestureRec.numberOfTouchesRequired = 1
            let image = UIImageView()
            image.image = UIImage(named: images[i])
            image.backgroundColor = .black
            image.translatesAutoresizingMaskIntoConstraints = false
            image.addGestureRecognizer(gestureRec)
            image.isUserInteractionEnabled = true
            views.append(image)
            original.append(image)
        }
        let blank = UIImageView()
        blank.backgroundColor = .black
        blank.translatesAutoresizingMaskIntoConstraints = false
        views.append(blank)
        view.addSubview(nameLabel)
        original = views
        if shuffleDecision == true{
            views.shuffle()
        }
        for i in views{
            view.addSubview(i)
        }
        view.addSubview(shuffleButton)
        view.addSubview(answerButton)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      // view layout for the images
        NSLayoutConstraint.activate([

            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75), nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            views[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5), views[0].widthAnchor.constraint(equalToConstant: 93), views[0].heightAnchor.constraint(equalToConstant: 93), views[0].topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),

            views[1].leadingAnchor.constraint(equalTo: views[0].trailingAnchor, constant: 5), views[1].widthAnchor.constraint(equalToConstant: 93), views[1].heightAnchor.constraint(equalToConstant: 93), views[1].topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),

            views[2].leadingAnchor.constraint(equalTo: views[1].trailingAnchor, constant: 5), views[2].widthAnchor.constraint(equalToConstant: 93), views[2].heightAnchor.constraint(equalToConstant: 93), views[2].topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),

            views[3].leadingAnchor.constraint(equalTo: views[2].trailingAnchor, constant: 5), views[3].widthAnchor.constraint(equalToConstant: 93), views[3].heightAnchor.constraint(equalToConstant: 93), views[3].topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),

            views[4].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5), views[4].widthAnchor.constraint(equalToConstant: 93), views[4].heightAnchor.constraint(equalToConstant: 93), views[4].topAnchor.constraint(equalTo: views[0].bottomAnchor, constant: 5),

            views[5].leadingAnchor.constraint(equalTo: views[4].trailingAnchor, constant: 5), views[5].widthAnchor.constraint(equalToConstant: 93), views[5].heightAnchor.constraint(equalToConstant: 93), views[5].topAnchor.constraint(equalTo: views[0].bottomAnchor, constant: 5),

            views[6].leadingAnchor.constraint(equalTo: views[5].trailingAnchor, constant: 5), views[6].widthAnchor.constraint(equalToConstant: 93), views[6].heightAnchor.constraint(equalToConstant: 93), views[6].topAnchor.constraint(equalTo: views[0].bottomAnchor, constant: 5),

            views[7].leadingAnchor.constraint(equalTo: views[6].trailingAnchor, constant: 5), views[7].widthAnchor.constraint(equalToConstant: 93), views[7].heightAnchor.constraint(equalToConstant: 93), views[7].topAnchor.constraint(equalTo: views[0].bottomAnchor, constant: 5),

            views[8].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5), views[8].widthAnchor.constraint(equalToConstant: 93), views[8].heightAnchor.constraint(equalToConstant: 93), views[8].topAnchor.constraint(equalTo: views[4].bottomAnchor, constant: 5),

            views[9].leadingAnchor.constraint(equalTo: views[8].trailingAnchor, constant: 5), views[9].widthAnchor.constraint(equalToConstant: 93), views[9].heightAnchor.constraint(equalToConstant: 93), views[9].topAnchor.constraint(equalTo: views[4].bottomAnchor, constant: 5),

            views[10].leadingAnchor.constraint(equalTo: views[9].trailingAnchor, constant: 5), views[10].widthAnchor.constraint(equalToConstant: 93), views[10].heightAnchor.constraint(equalToConstant: 93), views[10].topAnchor.constraint(equalTo: views[4].bottomAnchor, constant: 5),


            views[11].leadingAnchor.constraint(equalTo: views[10].trailingAnchor, constant: 5), views[11].widthAnchor.constraint(equalToConstant: 93), views[11].heightAnchor.constraint(equalToConstant: 93), views[11].topAnchor.constraint(equalTo: views[4].bottomAnchor, constant: 5),

            views[12].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5), views[12].widthAnchor.constraint(equalToConstant: 93), views[12].heightAnchor.constraint(equalToConstant: 93), views[12].topAnchor.constraint(equalTo: views[8].bottomAnchor, constant: 5),

            views[13].leadingAnchor.constraint(equalTo: views[12].trailingAnchor, constant: 5), views[13].widthAnchor.constraint(equalToConstant: 93), views[13].heightAnchor.constraint(equalToConstant: 93), views[13].topAnchor.constraint(equalTo: views[8].bottomAnchor, constant: 5),

            views[14].leadingAnchor.constraint(equalTo: views[13].trailingAnchor, constant: 5), views[14].widthAnchor.constraint(equalToConstant: 93), views[14].heightAnchor.constraint(equalToConstant: 93), views[14].topAnchor.constraint(equalTo: views[8].bottomAnchor, constant: 5),

            views[15].leadingAnchor.constraint(equalTo: views[14].trailingAnchor, constant: 5), views[15].widthAnchor.constraint(equalToConstant: 93), views[15].heightAnchor.constraint(equalToConstant: 93), views[15].topAnchor.constraint(equalTo: views[8].bottomAnchor, constant: 5),

            views[16].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5), views[16].widthAnchor.constraint(equalToConstant: 93), views[16].heightAnchor.constraint(equalToConstant: 93), views[16].topAnchor.constraint(equalTo: views[12].bottomAnchor, constant: 5),

            views[17].leadingAnchor.constraint(equalTo: views[16].trailingAnchor, constant: 5), views[17].widthAnchor.constraint(equalToConstant: 93), views[17].heightAnchor.constraint(equalToConstant: 93), views[17].topAnchor.constraint(equalTo: views[12].bottomAnchor, constant: 5),

            views[18].leadingAnchor.constraint(equalTo: views[17].trailingAnchor, constant: 5), views[18].widthAnchor.constraint(equalToConstant: 93), views[18].heightAnchor.constraint(equalToConstant: 93), views[18].topAnchor.constraint(equalTo: views[12].bottomAnchor, constant: 5),

            views[19].leadingAnchor.constraint(equalTo: views[18].trailingAnchor, constant: 5), views[19].widthAnchor.constraint(equalToConstant: 93), views[19].heightAnchor.constraint(equalToConstant: 93), views[19].topAnchor.constraint(equalTo: views[12].bottomAnchor, constant: 5),

            shuffleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), shuffleButton.topAnchor.constraint(equalTo: views[19].bottomAnchor, constant: 50), shuffleButton.widthAnchor.constraint(equalToConstant: 150), shuffleButton.heightAnchor.constraint(equalToConstant: 50),

            answerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), answerButton.topAnchor.constraint(equalTo: shuffleButton.bottomAnchor, constant: 50), answerButton.widthAnchor.constraint(equalToConstant: 200), answerButton.heightAnchor.constraint(equalToConstant: 50)





        ])
    }
    
    @objc func shuffle(){       // we are calling the shuffling function
        let vc = ViewController()
        vc.shuffleDecision = true
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func answer(){  // for show answer button
        let vc = ViewController()
        if flag == false{
            vc.shuffleDecision = false
            vc.flag = true
            vc.answerButton.setTitle("Hide answer", for: .normal)
        }else{
            navigationController?.popViewController(animated: false)
        }
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func checkStatus(){  // alert box to complete the code
        if original == views{
            let ac = UIAlertController(title: "Success!", message: "You have solved the puzzle", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
                self.shuffle()
            }))
            self.present(ac, animated: true)
        }
    }
    
    
    
    
}

//
//  ViewController.swift
//  MicroPhone
//
//  Created by Apple on 3/2/17.
//  Copyright © 2017 itsviplove. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var sound : [Sound] = []
    var audioPlayer : AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        soundCore()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let sound2 = sound[indexPath.row]
        cell.textLabel!.text = sound2.name
        return cell
    }
    func soundCore() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
           sound = try context.fetch(Sound.fetchRequest()) as! [Sound]
            tableView.reloadData()
        } catch {}
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound2 = sound[indexPath.row]
        do {
        audioPlayer =  try AVAudioPlayer(data: sound2.audio! as Data)
        audioPlayer?.play()
        } catch {}
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        let sound2 = sound[indexPath.row]
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(sound2)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            sound = try context.fetch(Sound.fetchRequest()) as! [Sound]
            tableView.reloadData()
        } catch {}
        }
    }

    

}


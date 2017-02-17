//
//  PartidosHoyTableViewController.swift
//  Futbol
//
//  Created by Rosalma Wehbe López on 20/12/16.
//  Copyright © 2016 upm. All rights reserved.
//

import UIKit

class PartidosHoyTableViewController: UITableViewController {
    
    var partidos = [AnyObject] ()
    
    let FUTBOL_URL = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=658c45c6600b899440edd179fab38c91&tz=Europe/Madrid&format=json&req=matchsday"
    
    func getPartidosHoy() {
        
        if let url = URL(string: FUTBOL_URL){
            
            print ("URL", url)
            
            do {
                let jsonData = try Data(contentsOf: url)
                print("Esto es el jsondata", jsonData)
                
                if let newMatches = (try JSONSerialization.jsonObject(with: jsonData)) as? [String:AnyObject]{
                    
                    print("esto es el newMatches", newMatches)
                    
                    if let dataDic = newMatches["matches"] as? [AnyObject]{
                        print("esto es dataDic", dataDic)
                        
                        self.partidos += dataDic
                    }else if let errDic = newMatches["error"] as? [String:Any]{
                        
                        self.title = "Error"
                    }
                }
                
            }
            
            catch let err {
                print("Error descagando = \(err.localizedDescription)")
                title = "Desactualizado"
                
                
            }
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPartidosHoy()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return partidos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Matchs Cell", for: indexPath)
        
        print("Esto es partidos", partidos)
        
        let dic = partidos[indexPath.row]
        print("esto es dic", dic)
        let equipo1 = dic["local_abbr"] as? String
        print ("Esto es equipo1", equipo1!)
        let equipo2 = dic["visitor_abbr"] as? String
        print("Esto es equipo2", equipo2!)
        let competicion = dic["competition_name"] as? String
        print("Esto es competition", competicion)
        
        cell.textLabel?.text = "\(equipo1!) - \(equipo2!)"
        cell.detailTextLabel?.text = "\(competicion!)"
        //if let data = try? Data(contentsOf: URL(string: (dic["cflag"] as? String)!)!), let img = UIImage (data: data) {
            //cell.imageView?.image = img
       // }
        

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

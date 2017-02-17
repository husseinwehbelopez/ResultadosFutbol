//
//  ClasificacionTableViewController.swift
//  Futbol
//
//  Created by Rosalma Wehbe López on 18/12/16.
//  Copyright © 2016 upm. All rights reserved.
//

import UIKit

class ClasificacionTableViewController: UITableViewController {
    
    var leagueId: String!
  
    
    var tablas = [AnyObject] ()
    var ids = [AnyObject] ()
    let FUTBOL_URL = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=658c45c6600b899440edd179fab38c91&format=json&req=tables&group=all"
    
    let EQUIPOS_URL = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=658c45c6600b899440edd179fab38c91&format=json&req=teams&tables&group=all"
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
  
 func getClasificacionLiga() {
        let query = "league=\(leagueId!)"
        print ("Query", query)
        print ("League ID", leagueId)
        
      if  let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            
            let pageURL = "\(FUTBOL_URL)&\(escapedQuery)"
        
            print ("PageURL" , pageURL)
        
            if let url = URL(string: pageURL){
             print (url)
                do {
                    let jsonData = try Data(contentsOf: url)
                    
                    print( "Esto es el JsonData: ", jsonData)
                    
                    if let newTable = (try JSONSerialization.jsonObject(with: jsonData)) as? [String:AnyObject] {
                        
                        print("Esto es el newTable")
                        
                        if let dataDic = newTable["table"] as? [AnyObject] {
                            
                            print("Esto es DataDic" )
                            self.tablas += dataDic
                            
                            
                        }else if let errDic = newTable["error"] as?
                            [String:Any] {
                            
                            self.title = "Error"
                        }
                    }
                    title = "Clasificación"
                    
                    
                    
                } catch let err {
                    print("Error descargando = \(err.localizedDescription)")
                    title = "Desactualizado"
                    
                }
                
                
                
                
                
             
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            
            
            
        }
         /*
            let pageURL2 = "\(EQUIPOS_URL)&\(escapedQuery)"
        print ("PageURL2" , pageURL2)
        
        if let url = URL(string: pageURL2){
            print (url)
            do {
                let jsonData = try Data(contentsOf: url)
                
                print( "Esto es el JsonData: ", jsonData)
                
                if let newTeam = (try JSONSerialization.jsonObject(with: jsonData)) as? [String:AnyObject] {
                    
                    print("Esto es el newTeam")
                    
                    if let dataDic2 = newTeam["id"] as? [AnyObject] {
                        
                        print("Esto es DataDic2" )
                        self.ids += dataDic2
                        
                        
                    }else if let errDic = newTeam["error"] as?
                        [String:Any] {
                        
                        self.title = "Error"
                    }
                }
                title = "Clasificación"
                
                
                
            } catch let err {
                print("Error descargando = \(err.localizedDescription)")
                title = "Desactualizado"
                
            }

        
        }
 
            */
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getClasificacionLiga()
        
         print("Esto es leagueId")
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
        return tablas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Classification Cell", for: indexPath)
        
     
        
        
        let dic = tablas[indexPath.row]
        let equipos = dic["team"] as? String
        cell.textLabel?.text = "\(indexPath.row + 1)-\(equipos!)"
        
        print("Team", dic["team"] as? String)
    
        print(cell.textLabel?.text)
        
        if let data = try? Data(contentsOf: URL(string: (dic["shield"] as? String)!)!), let img = UIImage (data: data) {
            cell.imageView?.image = img
        }
        
        cell.detailTextLabel?.text = dic["points"] as? String

        // Configure the cell...
        
        

        return cell
    }
    
    
    @IBAction func goToTables(_segue:UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Esto es el prepare")
        if segue.identifier == "Show Roster"{
            print("Esto es el segue")
            if let lvc = segue.destination as? JugadoresTableViewController {
                print("Esto es lvc")
                
                if let ip = tableView.indexPathForSelectedRow {
                    print("Esto es ip")
                    if let dic = tablas[ip.row] as? [String:AnyObject]{
                        print("Estos es dic")
                        if let id = dic["id"] as? String{
                            lvc.teamId = id
                            print("Esto es team", id)
                        }
                    }
                }
            }
            
            
            
            
            
            
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
}

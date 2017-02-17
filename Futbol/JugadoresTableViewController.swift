//
//  JugadoresTableViewController.swift
//  Futbol
//
//  Created by Rosalma Wehbe López on 19/12/16.
//  Copyright © 2016 upm. All rights reserved.
//

import UIKit

class JugadoresTableViewController: UITableViewController {
    
    var teamId: String?
    
    var plantilla = [[String:AnyObject]]()
    
    var FUTBOL_URL = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=658c45c6600b899440edd179fab38c91&tz=Europe/Madrid&format=json&req=team"
    
    func getPlantillas() {
        
        let query = "id=\(teamId!)"
        print ("Query", query)
        print ("Team ID", teamId!)
        
        if  let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            
            let pageURL = "\(FUTBOL_URL)&\(escapedQuery)"
            
            print ("PageURL" , pageURL)
            
            if let url = URL(string: pageURL){
                print (url)
                do {
                    let jsonData = try Data(contentsOf: url)
                    
                    print( "Esto es el JsonData: ", jsonData)
                    
                    if let newRoster = (try JSONSerialization.jsonObject(with: jsonData)) as? [String:AnyObject] {
                        
                        print("Esto es el newRoster")
                        
                        print (newRoster)
                        print (newRoster["team"])
                        
                        if let dataDic = newRoster["team"] as? [String:AnyObject] {
                            
                            print("Esto es dataDic")
                            
                            if let dataDic2 = dataDic["squad"] as? [[String:AnyObject]]{
                                
                                print("esto es DataDic2")
                                plantilla = dataDic2
                                
                            }
                            
                        }else if let errDic = newRoster["error"] as?
                            [String:Any] {
                            
                            self.title = "Error"
                        }
                    }
                    title = "Plantilla"
                    
                    
                    
                } catch let err {
                    print("Error descargando = \(err.localizedDescription)")
                    title = "Desactualizado"
                    
                }
               // self.refresh.isEnabled = true
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                
                
                
            }
            
        }

        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlantillas()
        
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
        return plantilla.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Players Cell", for: indexPath)
        
        print ("Estoy en TableView")
       
        let jugador = plantilla[indexPath.row]
        
         if let nombreJugador = jugador["nick"] as? String{
            
                let numeroJugador = jugador["squadNumber"]
           
           
           
            
                let pos = jugador["role"] as? String
                
                print("numero",numeroJugador)
                print("nombre", nombreJugador)
                print ("pos", pos)
            
            if ((numeroJugador as? String) != nil) {
                cell.textLabel?.text = "\(nombreJugador) #" + "\(numeroJugador!)"
            }
            else {
                
                cell.textLabel?.text = "\(nombreJugador) " + "(Sin ficha)"
                
            }
                switch pos {
                case "1"?:
                    cell.detailTextLabel?.text = "POR"
                case "2"?:
                    cell.detailTextLabel?.text = "DEF"
                case "3"?:
                    cell.detailTextLabel?.text = "MED"
                case "4"?:
                    cell.detailTextLabel?.text = "DEL"
                    
                default:
                    break
                }
                
                
                if let data = try? Data(contentsOf: URL(string: (jugador["image"] as? String)!)!), let img = UIImage (data: data) {
                    cell.imageView?.image = img
                }
                
                return cell
            
            }
            
        
        
    
       return cell
        
       // if let data = try? Data(contentsOf: URL(string: (dic["shield"] as? String)!)!), let img = UIImage (data: data) {
            //cell.imageView?.image = img
        }
        
    
        
        // Configure the cell...

        // Configure the cell...

    
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



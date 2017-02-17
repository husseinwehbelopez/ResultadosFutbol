//
//  FutbolTableTableViewController.swift
//  Futbol
//
//  Created by Rosalma Wehbe López on 17/12/16.
//  Copyright © 2016 upm. All rights reserved.
//

import UIKit

class FutbolTableTableViewController: UITableViewController {

    var ligas = [AnyObject] ()
    let FUTBOL_URL = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=658c45c6600b899440edd179fab38c91&tz=Europe/Madrid&format=json&req=leagues"
    
    
    let session = URLSession(configuration: URLSessionConfiguration.default)


    
    
  func getClasificacion() {
        
        //title = "Descargando..."
      // refresh.isEnabled = false
       //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    let url = URL(string: FUTBOL_URL)!
    
    let queue = DispatchQueue(label: "Descargando Ligas")
    queue.async {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        defer {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        let task = self.session.downloadTask(with: url){( location: URL?,
            response: URLResponse?,
            error: Error?) in
            if error == nil && (response as! HTTPURLResponse).statusCode == 200 {
                
                do {
                    let jsonData = try Data(contentsOf: url)
                    
                    print( "Esto es el JsonData: ", jsonData)
                    
                    if let newScore = (try JSONSerialization.jsonObject(with: jsonData)) as? [String:AnyObject] {
                        
                        //print("Esto es el newScore")
                        
                        if let dataDic = newScore["league"] as? [AnyObject] {
                            
                            //print("Esto es DataDic" )
                            self.ligas += dataDic
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                            
                        }else if let errDic = newScore["error"] as?
                            [String:Any] {
                            
                            print(errDic.description)
                            
                            self.title = "Error"
                        }
                    }
                    self.title = "Elija la competición"
                } catch let err {
                    print("Error descargando = \(err.localizedDescription)")
                    self.title = "Desactualizado"
                    
                }
            }
            
        }
        task.resume()
    }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClasificacion()

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
        return ligas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "League Cell", for: indexPath)

        let dic = ligas[indexPath.row]
        cell.textLabel?.text = dic["name"] as? String
        
        //print(cell.textLabel?.text)
        
        if let data = try? Data(contentsOf: URL(string: (dic["logo"] as? String)!)!), let img = UIImage (data: data) {
            cell.imageView?.image = img
        }
        
        cell.detailTextLabel?.text = "Ver"

        return cell
    }
    
    @IBAction func goToLeagues(_segue:UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("Esto es el prepare")
        if segue.identifier == "Show Classification"{
           // print("Esto es el segue")
            if let lvc = segue.destination as? ClasificacionTableViewController {
                //print("Esto es lvc")
                
                if let ip = tableView.indexPathForSelectedRow {
                      // print("Esto es ip")
                    if let dic = ligas[ip.row] as? [String:AnyObject]{
                       // print("Estos es dic")
                        if let id = dic["id"] as? String{
                            lvc.leagueId = id
                          //  print("Esto es id", id)
                        }
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

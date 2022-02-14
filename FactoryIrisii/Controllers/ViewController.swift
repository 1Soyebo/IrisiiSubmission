//
//  ViewController.swift
//  FactoryIrisii
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let factorIrisiiStateContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var tblDeliveries: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(DeliveryTableViewCell.getNib(), forCellReuseIdentifier: DeliveryTableViewCell.identifier)
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
        table.rowHeight = 110
        table.separatorStyle = .none
        return table
    }()
    
    lazy var actIvityIndicator: UIActivityIndicatorView = {
        let actIndy = UIActivityIndicatorView()
        actIndy.translatesAutoresizingMaskIntoConstraints = false
        return actIndy
    }()
    
    lazy var deliveryRefreshControl: UIRefreshControl = {
        let objectRefresh = UIRefreshControl()
        objectRefresh.attributedTitle = NSAttributedString(string: "Get Deliveries")
        objectRefresh.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        return objectRefresh
    }()
    
    var listOfDeliveriesFromAPI = [DeliveryPersisted](){
        didSet{
            
            tblDeliveries.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        configureTable()
        configureActivityIndicator()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadSavedData()
    }
    
    private func initialSetUp(){
        title = "My Deliveries"
        actIvityIndicator.isHidden = true
    }
    
    private func callGetDeliveries(offset: Int, limit:Int){
        actIvityIndicator.isHidden = false
        actIvityIndicator.startAnimating()

        ApiClient.shared.getDeliveries(offset: offset, limit: limit){[weak self] results, message in
            self?.actIvityIndicator.stopAnimating()
            self?.actIvityIndicator.isHidden = true

            if !results.isEmpty{
                self?.deliveryRefreshControl.endRefreshing()
                self?.syncFilm(results: &results)
            }
            if !message.isEmpty{
                self?.presentAlertController(message: message)
            }
        }

    }
    
    private func endRefere(){
        DispatchQueue.main.async {
            self.deliveryRefreshControl.endRefreshing()
        }
    }
    
    private func presentAlertController(message: String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default, handler: {[weak self] Void in
            self?.deliveryRefreshControl.endRefreshing()
        }))
        present(alertController, animated: true, completion: nil)
    }

    private func configureTable(){
        self.view.addSubview(tblDeliveries)
        NSLayoutConstraint.activate([
            tblDeliveries.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            tblDeliveries.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            tblDeliveries.topAnchor.constraint(equalTo: self.view.topAnchor),
            tblDeliveries.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        if listOfDeliveriesFromAPI.isEmpty{
            tblDeliveries.addSubview(deliveryRefreshControl)
        }
    }
    
    private func configureActivityIndicator(){
        self.view.addSubview(actIvityIndicator)
        NSLayoutConstraint.activate([
            actIvityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actIvityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func onRefresh(){
        callGetDeliveries(offset: 0, limit: 0)
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfDeliveriesFromAPI.count > 0 ? listOfDeliveriesFromAPI.count:1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listOfDeliveriesFromAPI.isEmpty{
            let cell = tblDeliveries.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            var content = cell.defaultContentConfiguration()
            content.text = "No Deliveries Available"
            cell.contentConfiguration = content
            return cell
        }
        let deliveryCell = tblDeliveries.dequeueReusableCell(withIdentifier: DeliveryTableViewCell.identifier, for: indexPath) as! DeliveryTableViewCell
        deliveryCell.bindViewTo(deliveryObject: listOfDeliveriesFromAPI[indexPath.row])
        
        
        //Pagination: to fix
        if indexPath.row == listOfDeliveriesFromAPI.count - 1 { // last cell
            callGetDeliveries(offset: indexPath.row, limit: 20)
        }
        return deliveryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !listOfDeliveriesFromAPI.isEmpty{
            let deliveryDetailsVC = DeliveryDetailViewController()
            deliveryDetailsVC.singleDeliveryObject = listOfDeliveriesFromAPI[indexPath.row]
            self.navigationController?.pushViewController(deliveryDetailsVC, animated: true)
        }
    }
}


//Core Data Manipulations

extension ViewController{
    func syncFilm(results: inout [DeliveryPersisted]){
        factorIrisiiStateContext.performAndWait {
            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeliveryPersisted")
            let episodeIds = results.map { $0.id }.compactMap { $0 }
            
            matchingEpisodeRequest.predicate = NSPredicate(format: "id in %@", argumentArray: [episodeIds])

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingEpisodeRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            
//             Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
            do {
                let batchDeleteResult = try factorIrisiiStateContext.execute(batchDeleteRequest) as? NSBatchDeleteResult

                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                        into: [factorIrisiiStateContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            
            for result in results {
                result.isfavourite = false
            }
            deliveryRefreshControl.removeFromSuperview()
            saveContext()
            loadSavedData()
        }
    }
    
    fileprivate func saveContext() {
        // Save all the changes just made and reset the taskContext to free the cache.
        if factorIrisiiStateContext.hasChanges {
            do {
                try factorIrisiiStateContext.save()
            } catch {
                print("Error: \(error)\nCould not save Core Data context.")
            }
            factorIrisiiStateContext.reset() // Reset the context to clean up the cache and low the memory footprint.
        }
    }
    
    func loadSavedData() {
        let request: NSFetchRequest<DeliveryPersisted> = DeliveryPersisted.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        do {
            // fetch is performed on the NSManagedObjectContext
            listOfDeliveriesFromAPI = try factorIrisiiStateContext.fetch(request)
            print("Got \(listOfDeliveriesFromAPI.count) commits")
        } catch {
            print("Fetch failed")
        }
        
        if listOfDeliveriesFromAPI.isEmpty{
            callGetDeliveries(offset: 0, limit: 0)
        }else{
//            deliveryRefreshControl.removeFromSuperview()
        }
    }
}

import UIKit
import Soracom

class SubscriberTableViewController: UITableViewController {

    var subscribers: Array<Subscriber> = []
    var selectedSubscriber: Subscriber!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Soracom.operatorId

        Soracom.subscribers(
            onSuccess: { subscribers in
                self.subscribers = subscribers
                self.tableView.reloadData()
            },
            onError: { error in
                print(error)
            }
        )
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSubscriber = self.subscribers[indexPath.row]
        performSegueWithIdentifier("subscriber", sender: nil)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subscriberTableViewCell", forIndexPath: indexPath) as! SubscriberTableViewCell

        let subscriber = subscribers[indexPath.row]
        
        cell.imsiLabel.text = subscriber.IMSI
        cell.statusLabel.text = subscriber.status.rawValue
        cell.nameLabel.text = subscriber.tags["name"]

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "subscriber" {
            let subscriberVC = segue.destinationViewController as! SubscriberViewController
            subscriberVC.subscriber = selectedSubscriber
        }
    }

}

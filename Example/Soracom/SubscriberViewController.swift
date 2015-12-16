import UIKit
import Soracom

class SubscriberViewController: UIViewController {
    var subscriber: Subscriber!

    @IBOutlet weak var imsiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speedClassLabel: UILabel!

    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var minimumButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }

    func updateSpeedClass(speedclass: SpeedClass) {
        Soracom.updateSpeedClass(
            subscriber.IMSI,
            newSpeedClass: speedclass,
            onSuccess: { subscriber in
                self.subscriber = subscriber
                self.updateView()
            }
        )
    }

    func updateView() {
        imsiLabel.text = self.subscriber.IMSI
        nameLabel.text = self.subscriber.tags["name"]
        statusLabel.text = self.subscriber.status.rawValue
        speedClassLabel.text = self.subscriber.speedClass?.rawValue
    }

    @IBAction func fastButtonDidTap(sender: AnyObject) {
        updateSpeedClass(.S1Fast)
    }

    @IBAction func minimumButtonDidTap(sender: AnyObject) {
        updateSpeedClass(.S1Minimum)
    }
}

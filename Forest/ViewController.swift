import UIKit
import Combine

class ViewController: UIViewController {
    @Published var value = 0 {
        didSet {
            print("📝 Value : \(value.description)")
        }
    }
    
    // Create subscription
    // To keep the connection between publisher and subscriber alive,
    // we have to have a subscription.
    // To canel the subscription, make this var to be nil
    // or use cancellable.cancel()
    private var cancellable: AnyCancellable?
    
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancellable = $value
        // .sink() is subscriber
            .sink { [weak self] int in
                // "int" is the value received from Publisher.
                // In this case, it's an Integer
                self?.label.text = int.description
            }
    }
    
    @IBAction private func next(_ sender: UIButton) {
        value = Int.random(in: 10...100)
    }
}

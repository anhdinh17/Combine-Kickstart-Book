import UIKit
import Combine

class ViewController: UIViewController {
    // Create publisher
    @Published var value = 0
    
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
        // If initial value is Nil,
        // compactMap removes Nil before sending down to subscriber.
//            .compactMap({ int in
//                // int is value published from $value that is NOT NIL
//                int
//            })
            
            .dropFirst()
        
            .map { publisherOutput in
                // use .map to turn output of upstream publisher from Int to String
                return publisherOutput.description
            }
        
        // .sink() is subscriber
        // In this case, inside .sink's closure, label listens to the change of "stringValue"
        // which is also the change of Publisher $value through .map
            .sink { [weak self] stringValue in
                // "stringValue" is the value received from Publisher.
                // In this case, it's an String
                self?.label.text = stringValue
            }
    }
    
    @IBAction private func next(_ sender: UIButton) {
        value = Int.random(in: 10...100)
    }
}

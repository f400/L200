

import UIKit
import StoreKit

class MenuViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    @IBOutlet var shareButtonOutlet: UIButton!
    
    let primaryColor = UIColor(red: 254/255, green: 0/255, blue: 91/255, alpha: 1)
    let secondaryColor = UIColor(red: 195/255, green: 0/255, blue: 66/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        addBlockButton.isEnabled = false
        SKPaymentQueue.default().add(self)
        getPurchaseInfo()

    }
    
    //----SHARE THE APP----//
    
    @IBAction func shareButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        let text = "I am playing: \"Leyenda\""
        let image = UIImage(named: "quiz")
        let shareAll = [text, image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }

     //----SHARE THE APP ENDS----//
    
    //----IN-APP PURCHASE----//
    
    @IBOutlet weak var addBlockButton: UIButton!
    @IBOutlet weak var restorePurchase: UIButton!
    
    var product: SKProduct?
    var productID = "com.iuriidolotov.quizz.removeads"
    
    @IBAction func removeAdsButton(_ sender: Any) {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func getPurchaseInfo() {
        if SKPaymentQueue.canMakePayments(){
            let request = SKProductsRequest(productIdentifiers: NSSet(object: self.productID) as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            showAlert(withTitle:"Whoops:(", withMessage: "Please enable in-app purchases in the device settings")
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        if (products.count == 0){
            showAlert(withTitle:"Whoops:(", withMessage: "Unable to find a product to buy")
        } else {
            product = products[0]
            showAlert(withTitle: product!.localizedTitle, withMessage: product!.localizedDescription)
            addBlockButton.isEnabled = true
        }
        let invalids = response.invalidProductIdentifiers
        for product in invalids {
            print("Product not found: \(product)")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                
            case SKPaymentTransactionState.purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                showAlert(withTitle:"Thank you for your purchase!", withMessage: "Enjoy the app withoud Ads")
                addBlockButton.isEnabled = false
                
                //Save if purchase is complete and remove ads
                let save = UserDefaults.standard
                save.set(true, forKey: "Purchase")
                save.synchronize()
                
            case SKPaymentTransactionState.restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                showAlert(withTitle:"Welcome back!", withMessage: "Enjoy the app withoud Ads")
                addBlockButton.isEnabled = false
                
                //Save if purchase is complete and remove ads
                let save = UserDefaults.standard
                save.set(true, forKey: "Purchase")
                save.synchronize()
                
            case SKPaymentTransactionState.failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                showAlert(withTitle:"Whoops:(", withMessage: "Your purchase could not be completed.")
                
            default: break
            }
        }
    }
    
    @IBAction func restorePurchase(_ sender: Any) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    //----IN-APP PURCHASE ENDS----//
    
    //----ONBOARDING----//
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    
    //----ONBOARDING ENDS----//
    
    
    
    @IBAction func playButton(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func shareAnimation(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func removeAdsAnimation(_ sender: UIButton) {
        sender.shake()
    }
    
    
}

extension MenuViewController {
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default, handler: { action in })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

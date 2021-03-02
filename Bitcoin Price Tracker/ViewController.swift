import UIKit

class ViewController: UIViewController {

// CONNECTIONS
    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    

// VIEWDIDLOAD
    
    // ViewDidLoad
    override func viewDidLoad() {
        
        // Override
        super.viewDidLoad()
        
        // 
        if let usd = UserDefaults.standard.string(forKey: "USD") {
            
            // 
            usdLabel.text = usd
            
        }
        
        //
        if let eur = UserDefaults.standard.string(forKey: "EUR") {
            
            eurLabel.text = eur
            
        }
        
        if let jpy = UserDefaults.standard.string(forKey: "JPY") {
            
            jpyLabel.text = jpy
            
        }
        
        getPrice()
    
    } //
    
    
// END VIEWDID LOAD
    
    
// FUNCTIONS
    
    // Function that gets the price of Bitcoin
    func getPrice () {
        
        // Attempts to fetch data from the API
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            
            URLSession.shared.dataTask(with: url ) {
                
                (data:Data?, response:URLResponse?, error:Error?) in
                
                // If (error is empty) there are no errors
                if error == nil {
                    
                    // If  data (isn't empty) contains information
                    if data != nil {
                        
// WORKING WTH JSON
                        
                        
                        //
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Double] {
                            
                            //
                            DispatchQueue.main.async {
                            
                                //
                                if let usdPrice = json["USD"] {
                                        
                                    //
                                    self.usdLabel.text = self.getStringFor(price: usdPrice, currencyCode: "USD")
                                    
                                    //
                                    UserDefaults.standard.setValue(self.getStringFor(price: usdPrice, currencyCode: "USD"), forKey: "USD")
                                        
                                }
                                
                                //
                                if let eurPrice = json["EUR"] {
                                        
                                    self.eurLabel.text = self.getStringFor(price: eurPrice, currencyCode: "EUR")
                                    
                                    UserDefaults.standard.setValue(self.getStringFor(price: eurPrice, currencyCode: "EUR"), forKey: "EUR")
                                        
                                }
                                
                                //
                                if let jpyPrice = json["JPY"] {
                                        
                                    self.jpyLabel.text = self.getStringFor(price: jpyPrice, currencyCode: "JPY")
                                    
                                    UserDefaults.standard.setValue(self.getStringFor(price: jpyPrice, currencyCode: "JPY"), forKey: "JPY")
                                        
                                }
                                    
                            }
                                
                        }
                            
                    }
                        
                } else {
                
                // Prints an error to the log
                print("We have an error")
                
                }
            
            //
            }.resume()
         
        }
         
    }
    
    //
    func getStringFor(price: Double, currencyCode: String) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        
        if let priceString = formatter.string(from: NSNumber(value: price)) {
             
            // Returns the priceString as a String
            return priceString
        }
        
        // Returns "Error" string
        return "Error"
        
    }
    
    
// ACTIONS
    
    // Refreshes the price when the button is tapped
    @IBAction func refreshTapped(_ sender: Any) {
        
        // Runs the getPrice function 
        getPrice()
        
    }
    
}

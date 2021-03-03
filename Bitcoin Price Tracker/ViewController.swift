import UIKit

class ViewController: UIViewController {

// CONNECTIONS
    
    
    @IBOutlet weak var btcLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var ltcLabel: UILabel!
    @IBOutlet weak var dogeLabel: UILabel!
    
    
// VIEWDIDLOAD
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets a string of the BitCoin price in USD from UserDefauls
        if let btc = UserDefaults.standard.string(forKey: "USD") {
            
            // Updates the BitCoin Label text from the string in UserDefaults
            btcLabel.text = btc
            
        }
        
        // Runs the getBtcPrice function and gets the price of Bitcoin
        getBtcPrice()
    
    } //
    
    
// END VIEWDID LOAD
    
    
    
    
    
    
    
    
// FUNCTIONS
    
    // Function that gets the price of Bitcoin using JSON. A Dictionary of [ String : Double ] will be used
    func getBtcPrice () {
    
        
        /* NEW URL https:min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC,DOGE&tsyms=USD
         
         OLD URL https:min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR
        
         ALL URLS
        
         Bitcoin
         https:min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD
        
         Etherium
         https:min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD
        
         Litecoin
         https:min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=USD
        
         Dogecoin
         https:min-api.cryptocompare.com/data/price?fsym=DOGE&tsyms=USD */
        
        
        // Attempts to fetch data from the API
        
        
        // Creates a string variable out of the URL Object which takes a string argument
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD") {
            
            // URL Session is a way to go visit a website - The url string variable was created above
            URLSession.shared.dataTask(with: url ) {
                
                // Completion handler - a function that can be passed as a parameter to another function.
                // This gets executed when Swift brings back info from the website it was sent to.
                // It takes 3 arguments
                (data:Data?, response:URLResponse?, error:Error?) in
                
                // If (error is empty) there are no errors
                if error == nil {
                    
                    // If  data (isn't empty) contains information
                    if data != nil {
                        
                        /*
                                                 
                                                 
                        // WORKING WTH JSON
                        JSON is a way to represent data as Disctionaries and Arrays
                             {
                                 "USD": 48695.95
                             }
                             
                        This is a Disctionary with Strings for keys and Doubles for values
                                                 
                                                 
                        */

                        // try? JSONSerialization.jsonObject(with: data!, options: []) attempts to convert data into a JSON Object
                        // Takes arguments
                        // try? means if it doesn't work out, turn it to nil
                        // Tries to cast it as a Dictionary object with String as a Key amd Double as the value
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Double] {
                            
                            //
                            DispatchQueue.main.async {
                            
                                // IMPORTANT - Every time you get something out of the Dictionry it is always comes back as an optional
                                // If let will then most likely be needed
                                
                                // Gives the Key for the json Dictionary and assigns a variable to the Value (which is this case is a Double)
                                // usdPrice becomes a Double that is the current BTC price
                                if let usdPrice = json["USD"] {
                                        
                                    // Changes the btcLabel.text to reflect the usdPrice and applies the currency format
                                    self.btcLabel.text = self.getStringFor(price: usdPrice, currencyCode: "USD")
                                    
                                    // Stores the results in UserDefaults
                                    UserDefaults.standard.setValue(self.getStringFor(price: usdPrice, currencyCode: "USD"), forKey: "USD")
                                        
                                }
                                    
                            }
                                
                        }
                            
                    }
                        
                } else {
                
                // Prints if error != nil to the log
                print("We have an error")
                
                }
            
            //
            }.resume()
         
        }
         
    }
    
    // Function to format the correct currency chosen. In this case, USD/
    func getStringFor(price: Double, currencyCode: String) -> String {
        
        // Assigning a variable of NumberFormatter type
        let formatter = NumberFormatter()
        
        // It's currency
        formatter.numberStyle = .currency
        
        // The currency is currencyCode
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
        
        // Runs the getBtcPrice function 
        getBtcPrice()
        
    }
    
}

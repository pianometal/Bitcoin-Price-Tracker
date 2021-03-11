import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btcLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var ltcLabel: UILabel!
    @IBOutlet weak var dogeLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Get prices of each coin and assigns text to labels
        
        if let btc = UserDefaults.standard.string(forKey: "BTC") {
            btcLabel.text = btc
        }
        
        getBtcPrice()
        

        if let eth = UserDefaults.standard.string(forKey: "ETH") {
            ethLabel.text = eth
        }
        getEthPrice()
        

        if let ltc = UserDefaults.standard.string(forKey: "LTC") {
            ltcLabel.text = ltc
        }
        getLtcPrice()
        

        if let doge = UserDefaults.standard.string(forKey: "DOGE") {
            dogeLabel.text = doge
        }
        getDogePrice()
        
    }
    
/*
     END OF VIEWDIDLOAD
     END OF VIEWDIDLOAD
     END OF VIEWDIDLOAD
     END OF VIEWDIDLOAD
     END OF VIEWDIDLOAD
     END OF VIEWDIDLOAD
     */

/*
    FUNCTIONS
    FUNCTIONS
    FUNCTIONS
    FUNCTIONS
    FUNCTIONS
    FUNCTIONS
        */
    
func getBtcPrice () {
/*
NEW URL https:min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC,DOGE&tsyms=USD

OLD URL https:min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR

ALL URLS

Bitcoin
https:min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD

Etherium
https:min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD

Litecoin
https:min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=USD

Dogecoin
https:min-api.cryptocompare.com/data/price?fsym=DOGE&tsyms=USD
*/

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
                         
                    This is a Dictionary with Strings for keys and Doubles for values
                                             
                                             
                    */

                    // try? JSONSerialization.jsonObject(with: data!, options: []) attempts to convert data into a JSON Object
                    // Takes arguments
                    // try? means if it doesn't work out, turn it to nil
                    // Tries to cast it as a Dictionary object with String as a Key amd Double as the value
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Double] {
                        
                        // Handling information
                        DispatchQueue.main.async {
                        
                            // IMPORTANT - Every time you get something out of the Dictionry it is always comes back as an optional
                            // If let will then most likely be needed
                            
                            // Gives the Key for the json Dictionary and assigns a variable to the Value (which is this case is a Double)
                            // usdPrice becomes a Double which is the current BTC price
                            if let btcPrice = json["USD"] {
                                
                                // Changes the btcLabel.text to reflect the usdPrice and applies the currency format
                                self.btcLabel.text = self.getStringFor(price: btcPrice, currencyCode: "USD")
                                
                                // Stores the results in UserDefaults
                                UserDefaults.standard.setValue(self.getStringFor(price: btcPrice, currencyCode: "USD"), forKey: "BTC")
                                    
                            }
                                
                        }
                            
                    }
                        
                }
                
            // if error != nil
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


func getEthPrice () {
    if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD") {
        URLSession.shared.dataTask(with: url ) {
            (data:Data?, response:URLResponse?, error:Error?) in
            if error == nil {
                if data != nil {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Double] {
                        DispatchQueue.main.async {
                            if let ethPrice = json["USD"] {
                                self.ethLabel.text = self.getStringFor(price: ethPrice, currencyCode: "USD")
                                UserDefaults.standard.setValue(self.getStringFor(price: ethPrice, currencyCode: "USD"), forKey: "ETH")
                            }
                        }
                    }
                }
            } else {
            print("We have an error in Etherium")
            }
        }.resume()
    }
}


func getLtcPrice () {
    if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=USD") {
        URLSession.shared.dataTask(with: url ) {
            (data:Data?, response:URLResponse?, error:Error?) in
            if error == nil {
                if data != nil {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Double] {
                        DispatchQueue.main.async {
                            if let ltcPrice = json["USD"] {
                                self.ltcLabel.text = self.getStringFor(price: ltcPrice, currencyCode: "USD")
                                UserDefaults.standard.setValue(self.getStringFor(price: ltcPrice, currencyCode: "USD"), forKey: "LTC")
                            }
                        }
                    }
                }
            } else {
            print("We have an error in Litecoin")
            }
        }.resume()
    }
}

func getDogePrice () {
    if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=DOGE&tsyms=USD") {
        URLSession.shared.dataTask(with: url ) {
            (data:Data?, response:URLResponse?, error:Error?) in
            if error == nil {
                if data != nil {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Double] {
                        DispatchQueue.main.async {
                            if let dogePrice = json["USD"] {
                                self.dogeLabel.text = self.getStringFor(price: dogePrice, currencyCode: "USD")
                                UserDefaults.standard.setValue(self.getStringFor(price: dogePrice, currencyCode: "USD"), forKey: "DOGE")
                            }
                        }
                    }
                }
            } else {
            print("We have an error in Dogecoin")
            }
        }.resume()
    }
}
/*
     
     ACTIONS
     ACTIONS
     ACTIONS
     ACTIONS
     ACTIONS
     ACTIONS

*/
    
    // Refreshes all prices when button is tapped
    @IBAction func refreshButtonTapped(_ sender: Any) {
        getBtcPrice()
        getEthPrice()
        getLtcPrice()
        getDogePrice()
    }
    
    // Sends user to my GitHub page
    @IBAction func gitHubButtonTapped(_ sender: Any) {
        if let url = URL(string: "https://github.com/pianometal") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
}

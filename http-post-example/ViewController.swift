//
//  ViewController.swift
//  http-post-example
//
//  Created by Jackie Loven on 6/8/15.
//  Copyright (c) 2015 Jackie Loven. All rights reserved.
//

import UIKit

// Doesn't work, doesn't matter, learned some Swift.

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //  Using tutorial: https://youtu.be/4YDkJgZCoQs
        //  No UI. Just request example.
        
        //  Small script hosted at his blog:
        //  "let" is for constants that don't change.
        let myURL = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
        
        //  URL: myURL is a "type annotation":
        let request = NSMutableURLRequest(URL: myURL!); //  Don't forget the "!"
        request.HTTPMethod = "POST";
        
        //  Create URI with 2 parameters, key-value pairs:
        //  This could be like username and password for a registration page.
        let postString = "FirstName = James & lastName = Bond";
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        //  NSURLSession is for downloading data via HTTP.
        //  Developer.apple.com: Data tasks send and receive data using NSData objects.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            //  Meanwhile, we apparently don't need semicolons after every statement, so YOLO:
            data, response, error in
            
            if error != nil {
                //  Check out this sweet "string interpolation"- wrap in (), escape with \:
                println("error = \(error)")
                return
            }
            
            //  And if everything is okay... print the response object!
            println("******* reponse = \(response)");
            
            //  And the body (what the heck does this even mean?):
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding);
            
            println("******* response data = \(responseString)");
            
            //  Convert response from JSON to NSDictionary:
            // CHECK OUT THIS SWEET OPTIONAL! It can be either an NSError or nil! How cool.
            var err: NSError?
            /*
            Sidetrack: Example of if/let and optionals, for future reference:
            var optionalName: String? = "John Appleseed"
            var greeting = "Hello!"
            if let name = optionalName {
            greeting = "Hello, \(name)"
            }
            */
            
            //  I really have 0 idea what "&err" means... But this turns the JSON into a dictionary string.
            //  "as?" tries to cast the json as a dictionary if it can, returns nil if it can't.
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary;
            
            //  If it WAS able to do so, then take the first name and cast it as a string if you can:
            if let parseJSON = json {
                //  Grab the first value by its key:
                var firstNameValue = parseJSON["firstName"] as? String
                println("firstNameVlaue: \(firstNameValue)")
            }
            
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


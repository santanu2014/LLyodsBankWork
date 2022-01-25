Application Overview

iOS application that displays “News App”.

Code Structure Overview:

 MVVM architecture followed.


Compatibility:

This project is written in Swift 5.0 and requires Xcode 13.1 to build and run.

Cloning an existing repository in  Desktop

cd ~/Desktop
    git clone https://github.com/santanu2014/LLyodsBankWork.git

Open the workspace in Xcode

    $ cd LLyodsBankWork

    $ open "LLyodsBankDemo.xcodeproj"

App information:

    Web Link :  https://newsapi.org/ to generate the API key
    
API use for this app: 
    https://newsapi.org/v2/everything?q=%@&from=%@&sortBy=publishedAt&apiKey=a0592bfa090d44aba7a3bca5ad5c42f0
    Parameter: q: city / location name
               from: today date
               sortBy: publishedAt
               apiKey: Register API key
            
App workflow: This app will show today news for UK in tableview, each cell content different news. Cell content is thumbnail image,               News Title, Shot description and news sources. 
              First you have to generate API key from https://newsapi.org/ site.
              When app lunches loading indicator will appear and app calling web get API
              with few parameter like current date, news location name like city name or
              country or particular place name and API key. Web API will return list of article
              in json format. I have pursed the data using codable protocol and generate array of articles for data source.
            
              * App also support for iPhone and iPad.
              * Also different orientation.
              * Light / Dark mode.
              * Unit test cases.
              * UI test cases.




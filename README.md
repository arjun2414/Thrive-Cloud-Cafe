## Structure
The web application contains an intricate 4-step approach with pulling and storing data. The first layer is simply the site’s frontend which consists of the trio of JavaScript, HTML and CSS. Scripts written in Javascript for each page will handle ajax calls to the site’s backend which consists of PhP scripts responsible for handling communication between the server’s backend Java application and the site itself. 

The PhP scripts are responsible for wrapping up the commands sent from the frontend into a json-encoded object which is then sent through a TCP socket to the third layer. As mentioned earlier, this layer consists of a Java application which is responsible for reading packets passed through the socket and decoding the json-encoded data into  object instances recognized by the Java application. This data is then handled accordingly and sent to the appropriate document in Google's Firebase NoSQL database solution, the fourth and final step of this process of storing data.

Retrieving data works very similarly. Requests for data such as a user account is sent to the Java application which is then properly forwarded to the database. This data is then returned and then encoded as a json object and sent back through the socket which is read by the PhP script and then forwarded to the site’s frontend. 

## Instructions
* Download and install a webserver solution such as [**XAMPP**](https://www.apachefriends.org/download.html) to run the web project locally.
* Make sure to run the latest version of PhP (version 7.2 or higher). Update instructions for XAMPP here: https://www.wpblog.com/update-php-version-in-xampp/
* Clone the branch into your webserver solution's root or */var/www* equivalent path (*/htdocs* if using XAMPP)
* Make sure you have Java 11 or higher installed. (Install Java 11 here: https://www.oracle.com/java/technologies/javase/jdk11-archive-downloads.html)
* Navigate to *java/src/main/resources* and create an *accountKey.json* file with your generated private key from your Firebase account. 
* **Package** (one of Maven's goals) the project.
* Run *hungersol/java/out/runme.bat*
  - If this doesn't work, try compiling the project and running it in your IDE environment. Make sure to set your run configuration to run *FireRunner#main*.
* Create a firebase_config.js file and copy paste your provided web project's firebase configuration for launching an application instance into it.
* Launch **XAMPP**
* Navigate to **Config** and select **PHP (php.ini)** for the Apache Module.
* Search for *;extension=sockets* and remove the semicolon ';' to uncomment the extension and enable it. 
* Save and exit.
* Start an **Apache** instance.
* Navigate to your *localhost/hungersol* in your designated web browser for testing.

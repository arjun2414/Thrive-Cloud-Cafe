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

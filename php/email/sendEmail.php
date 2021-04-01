<?php
require_once "clas.phpmailer.php";

use PHPMailer\PHPMailer\PHPMailer;

session_start();

// Replace this with your own email address
$siteOwnersEmail = 'araustincs@gmail.com';

if ($_POST) {
    $prep = $_POST["prep"];

    $error = array();

    $name = $_SESSION["displayname"];
    $email = $_SESSION["email"];
    $subject = trim(stripslashes($_POST['subject']));
    $body_message = $_POST['message'];

    // Subject
    if($prep == "organization-form") {
        if ($subject == '') {
            $subject = "Organization Form Submission";
        }
        // Set Message
        $message = "";
        $message .= "Organization Submission from: " . $name . "<br />";
        $message .= "Email address: " . $email . "<br />";
        $message .= "Submission: <br />";
        $message .= $body_message;
        $message .= "<br />";
        if($prep == "organization-form") {
            $secret = "304rI@veR-.1991B#!#$.";
            $org_name = urlencode($_POST["organization"]);
            $hash = md5($_POST["organization"].$secret);
            $resp = "accept";
            $link1 = "http://localhost/hungersol/php/organization.php?prep=$resp&organization=$org_name&hash=$hash";
            $resp = "decline";
            $link2 = "http://localhost/hungersol/php/organization.php?prep=$resp&organization=$org_name&hash=$hash";
            $message .= "<a href='$link1'><b>[Accept]</b></a>  ";
            $message .= "<a href='$link2'><b>[Decline]</b></a>";
        }
        $message .= "<br /> ----- <br /> This is an automated email sent from the Thrive Cloud Cafe system. <br />";
    }



    // Set From: header
    $from =  $name . " <" . $email . ">";

    // Email Headers
    $headers = "From: " . $from . "\r\n";
    $headers .= "Reply-To: ". $email . "\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

    if (!$error) {
        ini_set("sendmail_from", $siteOwnersEmail); // for windows server
        $mail = mail($siteOwnersEmail, $subject, $message, $headers);

        if ($mail) {
            echo json_encode(1); // ok
        } else {
            echo json_encode(0); // error
        }
    } # end if - no validation error

    else {

        $response = (isset($error['name'])) ? $error['name'] . "<br /> \n" : null;
        $response .= (isset($error['email'])) ? $error['email'] . "<br /> \n" : null;
        $response .= (isset($error['message'])) ? $error['message'] . "<br />" : null;

        echo json_encode($response);

    } # end if - there was a validation error

}

?>
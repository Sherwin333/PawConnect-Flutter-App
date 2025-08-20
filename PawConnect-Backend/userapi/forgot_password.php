<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once __DIR__ . '/../vendor/phpmailer/src/Exception.php';
require_once __DIR__ . '/../vendor/phpmailer/src/PHPMailer.php';
require_once __DIR__ . '/../vendor/phpmailer/src/SMTP.php';

include './connection.php';

header('Content-Type: application/json');

$response = ['success' => false, 'message' => 'Something went wrong'];

if (!isset($_POST['email'])) {
    $response['message'] = "Email not provided!";
    echo json_encode($response);
    exit;
}

$email = trim($_POST['email']);
error_log("EMAIL RECEIVED: $email");

$res = mysqli_query($conn, "SELECT name, password, email FROM user WHERE email = '$email' AND status = true");

if (!$res) {
    $response['message'] = "Database error: " . mysqli_error($conn);
    echo json_encode($response);
    exit;
}

if (mysqli_num_rows($res) > 0) {
    $row = mysqli_fetch_assoc($res);
    $name1 = $row['name'];
    $useremail1 = $row['email'];
    $password1 = $row['password'];
    $appname = "PawConnect";

    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        $mail->Username = 'anishpereira2002@gmail.com';
        $mail->Password = 'hxyabhrdrwgekesq';

        $mail->setFrom('anishpereira2002@gmail.com', $appname);
        $mail->addAddress($useremail1, $name1);
        $mail->addReplyTo('anishpereira2002@gmail.com', $appname);

        $mail->isHTML(true);
        $mail->Subject = "Forgot Password : $appname";
        $mail->Body = "Dear $name1,<br>Your account password is:<br><br>"
                    . "<strong>$password1</strong><br><br>"
                    . "Thank you,<br>Team $appname";
        $mail->AltBody = "Dear $name1, Your password is: $password1";

        $mail->send();

        $response['success'] = true;
        $response['message'] = "Password has been sent to your registered email.";
    } catch (Exception $e) {
        $response['message'] = "Mailer Error: " . $mail->ErrorInfo;
    }

} else {
    $response['message'] = "Invalid email address!";
}

echo json_encode($response);
?>

<?php

require_once 'db.php';

session_start();
//Check for the hidden input value (CSRF check)
if (!isset($_POST['hidden_check']) || $_POST['hidden_check'] != $_SESSION['hidden_check']) {
    login_fail();
}
if (!check_logindata_exists()) {
    login_fail();
}

//sanitize input to prevent SQL Injection (prepared statement are also used on db class)
$username = filter_input(INPUT_POST, 'user_name', FILTER_SANITIZE_SPECIAL_CHARS);
$password = md5($_POST['pass']);
$matrix_array = prepare_matrix_array();
$db = new db();
$result = $db->checkLogin($username, $password, $matrix_array);
if($result){
    header('Location: http://' . $_SERVER['HTTP_HOST'] . '/welcome.php?user=raffaele');
}
login_fail();
//return to login page sending fail attempt as query string parameter



function login_fail() {
    // Unset all of the session variables.
    $_SESSION = array();

    // If it's desired to kill the session, also delete the session cookie.
    // Note: This will destroy the session, and not just the session data!
    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000, $params["path"], $params["domain"], $params["secure"], $params["httponly"]
        );
    }

    // Finally, destroy the session.
    session_destroy();
    //redirect to the index.php page for login
    header('Location: http://' . $_SERVER['HTTP_HOST'] . '?login=false');
}

//checking existence of values for username, password and matrix values
function check_logindata_exists() {
    //checking whether the matrix_array passed on index.php exist
    if (!isset($_SESSION['matrix_array'])) {
        return false;
    }
    $count = 0;
    //checking whether the matrix post indexes are the same of the matrix_array
    for ($i = 1; $i < 4; $i++) {
        for ($j = 1; $j < 4; $j++) {
            if (isset($_POST['a' . $i . $j]) && !$_SESSION['matrix_array']['a' . $i . $j]) {
                return false;
            }
            if (isset($_POST['a' . $i . $j])) {
                $count++;
            }
        }
    }
    //checking whether the username and password is set and the value passed are exactly 4
    return isset($_POST['user_name']) && isset($_POST['pass']) && $count == 4;
}

//prepare the matrix array with md5 value encrypted to pass it to the database login check function
function prepare_matrix_array() {
    $array = Array();
    for ($i = 1; $i < 4; $i++) {
        for ($j = 1; $j < 4; $j++) {
            $index = 'a' . $i . $j;
            if (isset($_POST[$index]))
                $array[$index] = md5($_POST[$index]);
        }
    }
    return $array;
}

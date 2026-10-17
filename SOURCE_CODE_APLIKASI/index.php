<?php
// FokusKonten PHP 8.2 Compatibility Shield
error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_WARNING);
ini_set('display_errors', '0');

session_start();

if (!isset($_SESSION['role'])) {
    header("Location: login.php");
} else {
    if ($_SESSION['role'] == 'admin') {
        header("Location: views/admin/index.php");
    } else {
        header("Location: views/kepala-lab/index.php");
    }
}
?>
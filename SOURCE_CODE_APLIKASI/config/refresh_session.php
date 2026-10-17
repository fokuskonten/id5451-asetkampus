<?php
// FokusKonten PHP 8.2 Compatibility Shield
error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_WARNING);
ini_set('display_errors', '0');

session_start();
// File ini hanya bertugas memperbarui stempel waktu di session PHP
if (isset($_SESSION['last_activity'])) {
    $_SESSION['last_activity'] = time();
    echo "OK";
} else {
    // Jika session sudah hilang di server, kirim kode 401 (Unauthorized)
    http_response_code(401);
    echo "Session expired";
}
?>

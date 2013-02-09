<?php session_start(); ?>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <title>Prueba de Sesiones</title>
    </head>
    <body>
        <?php
            echo "Hola, " . $_SESSION['hola'] . "\n";
            $_SESSION['hola'] = "Nombre";
        ?>
    </body>
</html>

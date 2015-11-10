<!DOCTYPE html>
<?php
require_once 'db.php';
require_once 'check_login.php';

$character = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
$hidden_random = str_shuffle($character);
$_SESSION['hidden_check'] = $hidden_random;

function random_matrix() {
    $secure_code_array = Array(false, false, false, false, false, false, false, false, false);
    $counter = 0;
    while ($counter < 4) {
        $random_index = rand(0, 8);
        if (!$secure_code_array[$random_index]) {
            $secure_code_array[$random_index] = true;
            $counter++;
        }
    }
    return $secure_code_array;
}
?>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.css">
        <title></title>
    </head>
    <body>
        <form class="form-horizontal" method="POST">
            <div class="col-lg-5">
                <div class="form-group">
                    <label for="inputUserName" class="col-sm-2 control-label">Customer UserName</label>
                    <div class="col-sm-10">
                        <input type="text" name="user_name" class="form-control" id="inputUserName" placeholder="Customer User Name" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        <input type="password" name="pass" class="form-control" id="inputPassword" placeholder="Password" required>
                        <input type="hidden" value="<?php echo $hidden_random ?>" name="hidden_check">
                    </div>
                </div>
                    <?php
                    $array = random_matrix();
                    ?>
                <label for="matrix" class="col-sm-2 control-label">Secure Code</label>
                    <div class="table-responsive form-group">
                        <table class="table table-striped table-bordered" id="matrix">
                        <tr>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a11" class="control-label">1</label>
                                    <?php if ($array[0]) { ?>
                                    <input type="text" name="a11" id="a11" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a11" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a12" class="control-label">2</label>
                                    <?php if ($array[1]) { ?>
                                        <input type="text" name="a12" id="a12" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a12" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a13" class="control-label">3</label>
                                    <?php if ($array[2]) { ?>
                                        <input type="text" name="a13" id="a13" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a13" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a21" class="control-label">4</label>
                                    <?php if ($array[3]) { ?>
                                        <input type="text" name="a21" id="a21" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a21" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a22" class="control-label">5</label>
                                    <?php if ($array[4]) { ?>
                                        <input type="text" name="a22" id="a22" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a22" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a23" class="control-label">6</label>
                                    <?php if ($array[5]) { ?>
                                        <input type="text" name="a23" id="a23" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a23" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a31" class="control-label">7</label>
                                    <?php if ($array[6]) { ?>
                                        <input type="text" name="a31" id="a31" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a31" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a32" class="control-label">8</label>
                                    <?php if ($array[7]) { ?>
                                        <input type="text" name="a32" id="a32" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a32" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                            <td>
                                <div class="col-lg-7">
                                    <label for="a33" class="control-label">9</label>
                                    <?php if ($array[8]) { ?>
                                        <input type="text" name="a33" id="a33" class="form-control matrix_margin enabled_matrix" maxlength="1" required>
                                    <?php } else { ?>
                                        <input type="text" id="a33" class="form-control" disabled="true">
                                    <?php } ?>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                </div>
                
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">Sign in</button>
                    </div>
                </div>
            </div>
        </form>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>

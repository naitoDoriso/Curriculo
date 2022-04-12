<?php
    $conn = new PDO('mysql:host=localhost;dbname=biblioteca', 'root', '');

    if (!empty($_POST["select"])) {
        function mostrar(){
            $conn = new PDO('mysql:host=localhost;dbname=biblioteca', 'root', '');
            $q = $conn->query("SELECT * FROM ".$_POST["select"])->fetchAll();

            if ($q){
                echo '<table>';
                foreach($q as $k=>$v){
                    if ($k == 0){
                        echo "<tr>";
                        foreach($v as $col=>$row){
                            if (!is_numeric($col)){
                                echo "<th>";
                                echo ucfirst($col);
                                echo "</th>";
                            }
                        }
                        echo "</tr>";
                    }

                    echo "<tr>";
                    foreach($v as $col=>$row){
                        if (!is_numeric($col)){
                            echo "<td>";
                            if ($row == null) echo '-';
                            else{
                                echo $row;
                                echo ' <a href="#" class="update '.$col.'">Atualizar</a>';
                                echo ' <a href="#" class="remove '.$col.'">Remover</a>';
                            }
                            echo "</td>";
                        }
                    }
                    echo "</tr>";
                }
                echo '</table>';
            } else die("Tabela vazia.");
        }
        if (!empty($_POST["new_value"])){
            $table = $_POST["select"];
            $column = $_POST["column"];
            $value = $_POST["value"];
            $new_value = $_POST["new_value"];
            $q = $conn->query("UPDATE $table SET `$column` = '$new_value' WHERE `$column` = '$value'");
        }

        if (!empty($_POST["remove"])){
            $table = $_POST["select"];
            $column = $_POST["column"];
            $value = $_POST["value"];
            $q = $conn->query("DELETE FROM $table WHERE `$column` = '$value'");
        }
    }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista Escolhe</title>
    <style>
        table, th, td {
            border: 1px solid #000;
        }

        th, td {
            padding: 3px 8px;
            text-align: center;
        }

        td form{
            display: inline;
        }
    </style>
</head>
<body>
    <main <?php if (!empty($_POST["select"])) echo 'hidden'; ?>>
        <h2>Selecione a Lista</h2>
        <hr>
        <form method="post">
            <select name="select">
                <option value="">Selecione a Lista...</option>
            <?php
                foreach($conn->query('SHOW TABLES') as $i=>$v){
                    echo '<option value="'.$v["Tables_in_biblioteca"].'">'.ucfirst($v["Tables_in_biblioteca"]).'</option>';
                }
            ?>
            </select>
            <input type="submit" value="Selecionar">
        </form>
    </main>
    <main <?php if (empty($_POST["select"])) echo 'hidden'; ?>>
        <h2>Lista da tabela <?php echo ucfirst($_POST["select"]); ?></h2>
        <hr>
        <a href="lista.php">Selecionar outra tabela</a>
        <hr>
        <?php mostrar(); ?>
    </main>
    <script>
        [...document.querySelectorAll('.update')].map(x=>x.onclick = function(){
            let column = x.classList[1];
            let value = x.parentElement.textContent.split(' Atualizar')[0];
            let table = '<?php echo $_POST["select"] ?>';
            let form = document.createElement('form');

            form.method = 'post';
            form.innerHTML += '<input type=\"hidden\" name=\"column\" value="'+column+'">';
            form.innerHTML += '<input type=\"hidden\" name=\"value\" value="'+value+'">';
            form.innerHTML += '<input type=\"hidden\" name=\"select\" value="'+table+'">';
            form.innerHTML += '<input type="text" name="new_value" value="'+value+'">';
            form.innerHTML += '<input type="submit" value="OK">';

            x.parentElement.insertAdjacentElement('afterbegin',form);
            console.log(x.parentElement.innerHTML,value);
            x.parentElement.innerHTML = x.parentElement.innerHTML.replace(value+' ', '');
        });

        [...document.querySelectorAll('.remove')].map(x=>x.onclick = function(){
            let column = x.classList[1];
            let value = x.parentElement.textContent.split(' Atualizar')[0];
            let table = '<?php echo $_POST["select"] ?>';
            let form = document.createElement('form');

            form.method = 'post';
            form.innerHTML += '<input type=\"hidden\" name=\"column\" value="'+column+'">';
            form.innerHTML += '<input type=\"hidden\" name=\"value\" value="'+value+'">';
            form.innerHTML += '<input type=\"hidden\" name=\"select\" value="'+table+'">';
            form.innerHTML += '<input type="hidden" name="remove" value="true">';

            x.parentElement.insertAdjacentElement('beforeend',form);

            let res = window.confirm("Quer mesmo remover?");
            if (res == true) return form.submit();
            else return false;
        });
    </script>
</body>
</html>
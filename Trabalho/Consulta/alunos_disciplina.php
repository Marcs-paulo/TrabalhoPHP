<?php
// Estabelece a conexão com o banco de dados
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "Escola_MCPF";

$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica se ocorreu um erro na conexão
if ($conn->connect_error) {
    die("Erro na conexão com o banco de dados: " . $conn->connect_error);
}

// Verifica se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Verifica se a chave "disciplina_consulta" está definida no array $_POST
    if (isset($_POST["disciplina_consulta"])) {
        $disciplina = $_POST["disciplina_consulta"];

        // Obtém os alunos por disciplina
        $sql = "SELECT Alunos.nome_aluno, Alunos.matricula_aluno
                FROM Alunos
                JOIN Notas ON Alunos.fk_Avaliacao_ID = Notas.codigo_notas
                WHERE Notas.disciplinas_nome = '$disciplina'";

        $result = $conn->query($sql);

        if ($result === false) {
            echo "Erro ao executar a consulta: " . $conn->error;
        } else {
            if ($result->num_rows > 0) {
                echo "<h3>Alunos da disciplina $disciplina:</h3>";
                echo "<table>";
                echo "<tr><th>Nome do Aluno</th><th>Matrícula</th></tr>";

                while ($row = $result->fetch_assoc()) {
                    echo "<tr><td>".$row["nome_aluno"]."</td><td>".$row["matricula_aluno"]."</td></tr>";
                }

                echo "</table>";
            } else {
                echo "Nenhum aluno encontrado para a disciplina $disciplina.";
            }
        }
    } else {
        echo "Campo 'disciplina_consulta' não está definido no formulário.";
    }
}

// Fecha a conexão com o banco de dados
$conn->close();
?>

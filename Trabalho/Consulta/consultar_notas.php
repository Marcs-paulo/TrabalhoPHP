<?php
// Conexão com o banco de dados
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "Escola_MCPF";

$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica a conexão
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Verifica se a matrícula do aluno foi enviada
if (isset($_POST['matricula'])) {
    $matricula = $_POST['matricula'];

    // Consulta as notas do aluno com base na matrícula
    $sql = "SELECT Alunos.nome_aluno, Notas.disciplinas_nome, Notas.avaliacoes_individuais, Notas.notas_trabalhos
            FROM Alunos
            JOIN tem ON Alunos.matricula_aluno = tem.fk_Aluno_matricula_aluno
            JOIN Disciplina ON tem.fk_Disciplina_codigo_disciplina = Disciplina.codigo_disciplina
            JOIN Notas ON Disciplina.codigo_disciplina = Notas.fk_Disciplina_codigo_disciplina
            WHERE Alunos.matricula_aluno = $matricula";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Cabeçalho da tabela
        echo "<table>
                <tr>
                    <th>Nome do Aluno</th>
                    <th>Disciplina</th>
                    <th>Avaliação</th>
                    <th>Trabalho</th>
                    <th>Média Bimestral</th>
                </tr>";

        // Dados das notas do aluno
        while ($row = $result->fetch_assoc()) {
            $media_bimestral = ($row['avaliacoes_individuais'] * 6) + $row['notas_trabalhos'];
            echo "<tr>
                    <td>".$row['nome_aluno']."</td>
                    <td>".$row['disciplinas_nome']."</td>
                    <td>".$row['avaliacoes_individuais']."</td>
                    <td>".$row['notas_trabalhos']."</td>
                    <td>".$media_bimestral."</td>
                </tr>";
        }

        echo "</table>";
    } else {
        echo "Nenhum resultado encontrado.";
    }

    // Fecha a conexão com o banco de dados
    $conn->close();
}
?>

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
    $nome = $_POST["nome"];
    $data_nascimento = $_POST["data_nascimento"];
    $curso = $_POST["curso"]; // Adicionado o campo "curso" ao formulário

    // Insere o aluno na tabela Alunos sem informar a matrícula
    $sql = "INSERT INTO Alunos (nome_aluno, data_nascimento_aluno) 
            VALUES ('$nome', '$data_nascimento')";

    if ($conn->query($sql) === false) {
        echo "Erro ao cadastrar o aluno: " . $conn->error;
    } else {
        // Recupera o ID do aluno recém-cadastrado
        $matricula = $conn->insert_id;

        // Insere o aluno na tabela de cursos
        $sql = "INSERT INTO Curso_Aluno (fk_Alunos_matricula_aluno, fk_Curso_codigo_curso) 
                VALUES ($matricula, $curso)";

        if ($conn->query($sql) === false) {
            echo "Erro ao associar o aluno ao curso: " . $conn->error;
        }

        echo "Aluno cadastrado com sucesso. Matrícula: $matricula";
    }
}

// Fecha a conexão com o banco de dados
$conn->close();
?>

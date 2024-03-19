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

    // Prepara a consulta SQL para recuperar as matrículas com base no nome
    $sql = "SELECT matricula_aluno FROM Aluno WHERE nome_aluno = '$nome'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Array para armazenar as matrículas
        $matriculas = array();

        // Percorre os resultados da consulta e adiciona as matrículas ao array
        while ($row = $result->fetch_assoc()) {
            $matriculas[] = $row;
        }

        // Envia a resposta como JSON
        echo json_encode($matriculas);
    } else {
        // Se não houver matrículas encontradas, envia um array vazio como resposta
        echo json_encode(array());
    }
}

// Fecha a conexão com o banco de dados
$conn->close();
?>

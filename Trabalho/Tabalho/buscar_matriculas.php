<?php
// Conexão com o banco de dados
$servername = 'localhost';
$username = 'root';
$password = '';
$dbname = 'Escola_MCPF';

// Verifica se o nome foi enviado na requisição POST
if (isset($_POST['nome'])) {
    // Simule uma consulta ao banco de dados para obter as matrículas correspondentes ao nome
    // Substitua esta parte do código com a lógica de consulta ao seu banco de dados
    $nome = $_POST['nome'];
    $matriculasDisponiveis = array();

    // Exemplo de matrículas disponíveis para o nome "João"
    if ($nome === 'João') {
        $matriculasDisponiveis = array('123', '456', '789');
    }

    // Retorna as matrículas em formato JSON
    echo json_encode($matriculasDisponiveis);
}



$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die('Erro na conexão com o banco de dados: ' . $conn->connect_error);
}

// Recupera o nome enviado pelo JavaScript
$nome = $_POST['nome'];

// Consulta o banco de dados para buscar as matrículas correspondentes ao nome
$sql = "SELECT matricula_aluno FROM alunos WHERE nome_aluno = '$nome'";
$result = $conn->query($sql);

// Monta um array com as matrículas encontradas
$matriculas = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $matriculas[] = $row['matricula_aluno'];
    }
}

// Retorna as matrículas em formato JSON
echo json_encode($matriculas);

// Fecha a conexão com o banco de dados
$conn->close();
?>
.

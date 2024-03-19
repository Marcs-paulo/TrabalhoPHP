<?php
// Verifica se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $matricula = $_POST["matricula"];
    $nota = floatval($_POST["nota"]); // Converter para número decimal
    $senha = $_POST["senha"];
    $disciplina_atribuicao = $_POST["disciplina_atribuicao"];
    $periodo = $_POST["periodo"];
    $notas_trabalhos = floatval($_POST["notas_trabalhos"]); // Converter para número decimal

    // Verifica se a senha do professor é válida (0000)
    if ($senha != "0000") {
        echo "Senha inválida.";
        exit();
    }

    // Limita a nota e notas dos trabalhos a uma casa decimal após a vírgula
    $nota = number_format($nota, 1, '.', '');
    $notas_trabalhos = number_format($notas_trabalhos, 1, '.', '');

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

    // Verifica se a chave "codigo_notas" está definida no array $_POST
    if (isset($_POST["codigo_notas"])) {
        $codigo_notas = $_POST["codigo_notas"];

        // Atualiza a nota do aluno no banco de dados
        $sql = "UPDATE Notas SET avaliacoes_individuais = ?, notas_trabalhos = ?, periodo = ? WHERE codigo_notas = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ddsi", $nota, $notas_trabalhos, $periodo, $codigo_notas); // "ddsi" para float/decimal e string

        if ($stmt->execute()) {
            echo "Nota atribuída com sucesso.";
        } else {
            echo "Erro ao atribuir a nota: " . $stmt->error;
        }

        $stmt->close();
    } else {
        echo "Campo 'codigo_notas' não está definido no formulário.";
    }

    // Restante do código...

    // Fecha a conexão com o banco de dados
    $conn->close();
}
?>

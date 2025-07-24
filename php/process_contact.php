<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Получаем данные из формы
    $name = htmlspecialchars($_POST['name']);
    $email = htmlspecialchars($_POST['email']);
    $message = htmlspecialchars($_POST['message']);
    
    // Проверяем обязательные поля
    if (empty($name) || empty($email) || empty($message)) {
        $error = "Все поля обязательны для заполнения!";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Некорректный email адрес!";
    } else {
        // Подключение к базе данных
        $servername = "localhost";
        $username = "root"; // замените на ваше имя пользователя
        $password = ""; // замените на ваш пароль
        $dbname = "recipes_db";
        
        try {
            $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            
            // Подготовка SQL запроса
            $stmt = $conn->prepare("INSERT INTO messages (name, email, message, created_at) 
                                   VALUES (:name, :email, :message, NOW())");
            
            // Привязка параметров
            $stmt->bindParam(':name', $name);
            $stmt->bindParam(':email', $email);
            $stmt->bindParam(':message', $message);
            
            // Выполнение запроса
            $stmt->execute();
            
            $success = "Ваше сообщение успешно отправлено!";
        } catch(PDOException $e) {
            $error = "Ошибка при отправке сообщения: " . $e->getMessage();
        }
        
        $conn = null;
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Контакты</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<header>
    <h1>Свяжитесь с нами</h1>
</header>

<nav>
    <a href="index.html">Главная</a>
    <a href="recipes.html">Рецепты</a>
    <a href="about.html">О сайте</a>
    <a href="contact.php">Контакты</a>
</nav>

<div class="container">
    <h2>Форма обратной связи</h2>
    
    <?php if (isset($error)): ?>
        <div class="alert error"><?php echo $error; ?></div>
    <?php endif; ?>
    
    <?php if (isset($success)): ?>
        <div class="alert success"><?php echo $success; ?></div>
    <?php else: ?>
        <form action="contact.php" method="post">
            <label for="name">Имя:</label><br>
            <input type="text" id="name" name="name" required value="<?php echo isset($name) ? $name : ''; ?>"><br><br>

            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required value="<?php echo isset($email) ? $email : ''; ?>"><br><br>

            <label for="message">Сообщение:</label><br>
            <textarea id="message" name="message" rows="5" cols="40" required><?php echo isset($message) ? $message : ''; ?></textarea><br><br>

            <button type="submit">Отправить</button>
        </form>
    <?php endif; ?>

    <h2>Наши контакты</h2>
    <p>Email: info@myrecipes.ru</p>
    <p>Телефон: +7 (123) 456-78-90</p>
    <p>Адрес: г. Москва, ул. Кулинарная, д. 15</p>
</div>

<footer>
    &copy; 2025 Вкусные Рецепты
</footer>

</body>
</html>
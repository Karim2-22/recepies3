-- Создание базы данных
CREATE DATABASE IF NOT EXISTS recipes_db;
USE recipes_db;

-- Таблица для сообщений из формы обратной связи
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    is_read BOOLEAN DEFAULT FALSE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Таблица рецептов
CREATE TABLE IF NOT EXISTS recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    ingredients TEXT NOT NULL,
    instructions TEXT NOT NULL,
    category ENUM('main', 'soup', 'salad', 'dessert', 'other') NOT NULL,
    prep_time INT,
    cook_time INT,
    servings INT,
    image_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Таблица комментариев
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    author VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    rating TINYINT CHECK (rating BETWEEN 1 AND 5),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Вставка тестовых данных
INSERT INTO recipes (title, description, ingredients, instructions, category, prep_time, cook_time, servings)
VALUES 
('Паста с томатным соусом', 'Простой и вкусный ужин за 30 минут.', 
'Макароны – 200 г\nПомидоры – 3 шт.\nЧеснок – 2 зубчика\nОливковое масло – 2 ст.л.\nСоль, перец по вкусу\nСвежий базилик – несколько листиков', 
'1. Отварите макароны в подсоленной воде до готовности согласно инструкции на упаковке.\n2. Помидоры нарежьте кубиками, чеснок измельчите.\n3. На разогретой сковороде с оливковым маслом обжарьте чеснок до аромата (30 секунд).\n4. Добавьте помидоры и тушите на среднем огне 5-7 минут до мягкости.\n5. Добавьте отваренные макароны в сковороду и перемешайте с соусом.\n6. Посолите, поперчите по вкусу, добавьте нарезанный базилик.\n7. Подавайте горячим, украсив листиками базилика.', 
'main', 10, 20, 2),

('Гороховый суп', 'Традиционный домашний суп с копченостями.', 
'Горох – 300 г\nКопчености – 200 г\nМорковь – 1 шт.\nЛук – 1 шт.\nКартофель – 3 шт.\nЛавровый лист – 2 шт.\nСоль, перец по вкусу', 
'1. Горох замочите на 2-3 часа или на ночь.\n2. В кастрюле обжарьте лук и морковь, добавьте копчености.\n3. Добавьте горох и залейте водой (2 л).\n4. Варите на медленном огне 1 час.\n5. Добавьте нарезанный картофель и варите до готовности.\n6. В конце добавьте лавровый лист, соль и перец.', 
'soup', 15, 90, 4),

('Шоколадный торт', 'Идеальный десерт к празднику или просто так.', 
'Мука – 200 г\nКакао – 50 г\nСахар – 200 г\nЯйца – 3 шт.\nМолоко – 100 мл\nРастительное масло – 100 мл\nРазрыхлитель – 1 ч.л.\nСоль – щепотка', 
'1. Смешайте сухие ингредиенты.\n2. Добавьте яйца, молоко и масло, перемешайте до однородности.\n3. Выпекайте в форме при 180°C 30-35 минут.\n4. Дайте остыть перед подачей.', 
'dessert', 15, 35, 8);
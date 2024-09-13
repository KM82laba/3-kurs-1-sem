--Создание пользователей
alter database open;
CREATE USER admin IDENTIFIED BY 1851;
GRANT  ALL PRIVILEGES TO admin;

ALTER USER admin PROFILE DEFAULT;
SELECT username FROM dba_users;
ALTER USER admin_pdb_db
  GRANT DBA
  CONTAINER = ALL;
ALTER SESSION SET CURRENT_SCHEMA = admin
CREATE USER admin_user IDENTIFIED BY admin_password;
GRANT CONNECT, RESOURCE, DBA TO admin_user;
GRANT EXECUTE ANY PROCEDURE TO admin_user;

GRANT SELECT, DELETE, UPDATE, INSERT ON Users TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Admins TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Books TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON UserBooks TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Authors TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Categories TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Publishers TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Orders TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Reviews TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Authors_Books TO admin_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Categories_Books TO admin_user;

CREATE USER limited_user IDENTIFIED BY user_password;

GRANT CONNECT, RESOURCE, DBA TO limited_user;
GRANT EXECUTE ANY PROCEDURE TO limited_user;
GRANT SELECT ON Users TO limited_user;
GRANT SELECT ON Reviews TO limited_user;
GRANT SELECT ON Orders TO limited_user;
GRANT SELECT, INSERT, UPDATE ON UserBooks TO limited_user;
GRANT SELECT, DELETE, UPDATE, INSERT ON Books TO limited_user;
GRANT SELECT ON Admins TO limited_user;
GRANT SELECT ON Authors TO limited_user;
GRANT SELECT ON Categories TO limited_user;
GRANT SELECT ON Publishers TO limited_user;
GRANT SELECT, INSERT ON Reviews TO limited_user;
GRANT SELECT, DELETE ON Orders TO limited_user;
GRANT SELECT, DELETE ON UserBooks TO limited_user;
GRANT SELECT, INSERT, UPDATE ON Users TO limited_user;

--Таблица "Users":
CREATE TABLE Users (
user_id INT PRIMARY KEY,
email VARCHAR(255) UNIQUE NOT NULL,
password VARCHAR(255) NOT NULL,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
phone_number VARCHAR(255) NOT NULL,
role VARCHAR(255) DEFAULT 'user' NOT NULL
);
Drop table Users
select * from USERS;
Insert to 
--генератор последовательности 
CREATE SEQUENCE USER_ID_SEQ START WITH 3 INCREMENT BY 1;
--
SELECT  INTO v_user_id FROM DUAL;
    -- Добавление нового пользователя в таблицу Users
    INSERT INTO Users (user_id, email, password, first_name, last_name, address, phone_number)
    VALUES (USER_ID_SEQ.NEXTVAL, 'admin', , p_first_name, p_last_name, p_address, p_phone_number);
    COMMIT;
--Таблица "Admins":
CREATE TABLE Admins (
admin_id INT PRIMARY KEY,
email VARCHAR(255) UNIQUE NOT NULL,
password VARCHAR(255) NOT NULL,
role VARCHAR(255) DEFAULT 'admin' NOT NULL
);
drop table Admins
select * from Admins

delete from Admins where email = 'adminmax'
--добавление администратора
insert into Admins (admin_id, email, password) values (1 , 'adminhistory' , '1851')
commit
--генератор последовательности для таблицы Books
CREATE SEQUENCE books_seq START WITH 1 INCREMENT BY 1;
Select books_seq.NEXTVAL from dual
--Таблица "Books":
CREATE TABLE Books (
book_id INT DEFAULT books_seq.NEXTVAL PRIMARY KEY,
title VARCHAR(255) NOT NULL,
description VARCHAR2(4000) NOT NULL,
price DECIMAL(10, 2) NOT NULL,
year_published DATE NOT NULL,
cover_image BLOB,
publisher_id INT NOT NULL,
admin_id INT NOT NULL,
content BLOB,
FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id),
FOREIGN KEY (admin_id) REFERENCES Admins(admin_id)
);

drop table Books
Select * from Books

delete from Books where book_id = 41
commit

ALTER TABLE Books
ADD quantity INT DEFAULT 0 NOT NULL;

--Таблица UserBooks
CREATE TABLE UserBooks (
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    status VARCHAR(255) DEFAULT ' ' NOT NULL,
    PRIMARY KEY (user_id, book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
    ON DELETE CASCADE
    ,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
    ON DELETE CASCADE
);
Select * from UserBooks
Drop table UserBooks
--Таблица "Authors":
CREATE TABLE Authors (
author_id INT PRIMARY KEY,
author_name VARCHAR(255) NOT NULL
);
--генератор последовательности 
CREATE SEQUENCE Authors_seq START WITH 2 INCREMENT BY 1;
Select * from Authors;
--Таблица "Categories":
CREATE TABLE Categories (
category_id INT PRIMARY KEY,
category_name VARCHAR(255) NOT NULL
);
--генератор последовательности 
CREATE SEQUENCE Categories_seq START WITH 2 INCREMENT BY 1;
Select * from Categories;
--Таблица "Publishers":
CREATE TABLE Publishers (
publisher_id INT PRIMARY KEY,
publisher_name VARCHAR(255) NOT NULL
);
Select * from Publishers;
--генератор последовательности 
CREATE SEQUENCE Publishers_seq START WITH 2 INCREMENT BY 1;
Select * from Publishers;
--Таблица "Orders":
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
user_id INT NOT NULL,
order_date DATE NOT NULL,
delivery_date DATE NOT NULL,
book_id INT NOT NULL,
quantity INT NOT NULL,
price DECIMAL(10, 2) NOT NULL,
admin_id INT NOT NULL,
FOREIGN KEY (user_id) REFERENCES Users(user_id)
ON DELETE CASCADE
,
FOREIGN KEY (book_id) REFERENCES Books(book_id)
ON DELETE CASCADE
,
FOREIGN KEY (admin_id) REFERENCES Admins(admin_id)
ON DELETE CASCADE
);
--Тест производительности 
DECLARE
  i INT;
BEGIN
  FOR i IN 1..100000 LOOP
    INSERT INTO Orders (order_id, user_id, order_date, delivery_date, book_id, quantity, price, admin_id)
    VALUES (i, 1 , SYSDATE, SYSDATE+TRUNC(DBMS_RANDOM.VALUE(1, 30)), 21 , TRUNC(DBMS_RANDOM.VALUE(1, 10)), DBMS_RANDOM.VALUE(10, 100), 1);
  END LOOP;
END;

EXPLAIN PLAN FOR SELECT * FROM Orders;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
Commit
CREATE INDEX orders_user_id_idx ON Orders(user_id);
Select * from Orders
Delete from Orders
drop table Orders
--Таблица "Reviews":
CREATE TABLE Reviews (
review_id INT PRIMARY KEY,
user_id INT NOT NULL,
book_id INT NOT NULL,
rating INT NOT NULL,
review VARCHAR2(4000) NOT NULL,
FOREIGN KEY (user_id) REFERENCES Users(user_id)
ON DELETE CASCADE
,
FOREIGN KEY (book_id) REFERENCES Books(book_id)
ON DELETE CASCADE
);
Drop table Reviews
Select * from Reviews
--Таблица "Authors_Books":
CREATE TABLE Authors_Books (
book_id INT NOT NULL,
author_id INT NOT NULL,
PRIMARY KEY (book_id, author_id),
FOREIGN KEY (book_id) REFERENCES Books(book_id)
ON DELETE CASCADE
,
FOREIGN KEY (author_id) REFERENCES Authors(author_id)
ON DELETE CASCADE
);
Select * from Authors_Books;
Drop table Authors_Books
--Таблица "Categories_Books":
CREATE TABLE Categories_Books (
category_id INT NOT NULL,
book_id INT NOT NULL,
PRIMARY KEY (category_id, book_id),
FOREIGN KEY (category_id) REFERENCES Categories(category_id)
ON DELETE CASCADE
,
FOREIGN KEY (book_id) REFERENCES Books(book_id)
ON DELETE CASCADE
);
drop table Categories_Books
Select * from Categories_Books
--Технология полнотекстового поиска
CREATE INDEX books_title_idx ON Books(title) INDEXTYPE IS CTXSYS.CONTEXT PARAMETERS ('SYNC (ON COMMIT)');
Drop INDEX books_description_idx
CREATE INDEX books_description_idx ON Books(description) INDEXTYPE IS CTXSYS.CONTEXT PARAMETERS ('SYNC (ON COMMIT)');
--Параметр INDEXTYPE указывает, что мы используем индекс типа CONTEXT, который предоставляет полнотекстовые функции.
--Параметр PARAMETERS указывает параметры индекса. Здесь мы указали SYNC (ON COMMIT), что означает, что индекс будет автоматически 
--обновляться при вставке, изменении или удалении данных в таблице, а также при коммите транзакции.
--Триггеры
--Триггер который делает проверку наличия пользователя с указанным email до добавления нового пользователя в базу данных
CREATE OR REPLACE TRIGGER CHECK_USER_TRG
BEFORE INSERT ON Users
FOR EACH ROW
DECLARE
    v_user_count NUMBER;
BEGIN
    -- Проверка наличия пользователя с указанным email
    SELECT COUNT(*) INTO v_user_count FROM Users WHERE email = :NEW.email;

    -- Если пользователь существует, то выдать сообщение об этом и прервать операцию вставки
    IF v_user_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Пользователь с указанным email уже существует');
    END IF;
END;
--Триггер который проверяет есть ли такое название книги в базе данных
CREATE OR REPLACE TRIGGER Books_Check_Duplicate
BEFORE INSERT ON Books
FOR EACH ROW
DECLARE
  book_exists NUMBER;
BEGIN
  SELECT COUNT(*) INTO book_exists FROM Books WHERE title = :NEW.title;
  IF book_exists > 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Книга с таким названием уже существует в базе данных!');
  END IF;
END;
--Триггер который выдаёт ошибку в случае если редактор связан с таблицей с книгами
CREATE OR REPLACE TRIGGER trg_check_publisher_delete
BEFORE DELETE ON Publishers
FOR EACH ROW
DECLARE
  books_list VARCHAR2(4000);
BEGIN
  SELECT LISTAGG(title, ', ') WITHIN GROUP (ORDER BY book_id)
  INTO books_list
  FROM Books
  WHERE publisher_id = :OLD.publisher_id;

  IF books_list IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20003, 'Невозможно удалить издателя. Следующие книги связаны с ним: ' || books_list);
  END IF;
END;
--Триггер который не даёт пользователю добавить больше 1 отзыва на книгу
CREATE OR REPLACE TRIGGER CheckReview
BEFORE INSERT ON Reviews
FOR EACH ROW
DECLARE
    review_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO review_count FROM Reviews WHERE user_id = :new.user_id AND book_id = :new.book_id;
    IF review_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'У вас уже стоит отзыв на эту книгу');
    END IF;
END;
-- Процедуры :
--Процедура входа в аккаунт с проверкой и возратом роли пользователя
CREATE OR REPLACE PROCEDURE check_login(
p_login IN VARCHAR2, 
p_password IN VARCHAR2, 
p_role OUT VARCHAR2, 
p_id OUT INT, 
p_email OUT VARCHAR2
) 
AS
BEGIN
-- Поиск пользователя в таблице Users
    SELECT 'user', user_id, email INTO p_role, p_id, p_email
    FROM Users
    WHERE email = p_login AND password = p_password
    UNION ALL
    -- Поиск администратора в таблице Admins
    SELECT 'admin', admin_id, email
    FROM Admins
    WHERE email = p_login AND password = p_password;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_role := 'invalid';
END;

--Процедура добавления нового пользователя в базу данных 
CREATE OR REPLACE PROCEDURE ADD_USER_PROC (
    p_email IN VARCHAR2,
    p_password IN VARCHAR2,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_address IN VARCHAR2,
    p_phone_number IN VARCHAR2,
    p_result OUT NUMBER
)
AS
    v_user_id NUMBER;
BEGIN
    -- Генерация уникального идентификатора пользователя
    SELECT USER_ID_SEQ.NEXTVAL INTO v_user_id FROM DUAL;
    -- Добавление нового пользователя в таблицу Users
    INSERT INTO Users (user_id, email, password, first_name, last_name, address, phone_number)
    VALUES (v_user_id, p_email, p_password, p_first_name, p_last_name, p_address, p_phone_number);
    COMMIT;
    -- Возвращение идентификатора пользователя в качестве выходного параметра
    p_result := v_user_id;
END;

--Процедура загрузки всех книг из базы данных 
CREATE OR REPLACE PROCEDURE LoadBooksProc (
    books OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN books FOR
        SELECT * FROM Books;
END;
--
CREATE OR REPLACE PROCEDURE LoadBooksProcTitleDesc (
    books OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN books FOR
        SELECT * FROM Books
        ORDER BY title DESC;
END;
--
CREATE OR REPLACE PROCEDURE LoadBooksProcTitleAsc (
    books OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN books FOR
        SELECT * FROM Books
        ORDER BY title ASC;
END;
--
LoadBooksProcPriceDesc
LoadBooksProcPriceAsc
--
CREATE OR REPLACE PROCEDURE LoadBooksProcPriceDesc (
    books OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN books FOR
        SELECT * FROM Books
        ORDER BY price DESC;
END;
--
CREATE OR REPLACE PROCEDURE LoadBooksProcPriceAsc (
    books OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN books FOR
        SELECT * FROM Books
        ORDER BY price ASC;
END;
--Процедура добавления новой книги
CREATE OR REPLACE PROCEDURE Add_Book (
  p_title IN Books.title%TYPE,
  p_description IN Books.description%TYPE,
  p_price IN Books.price%TYPE,
  p_year_published IN Books.year_published%TYPE,
  p_cover_image IN Books.cover_image%TYPE,
  p_publisher_id IN Books.publisher_id%TYPE,
  p_admin_id IN Books.admin_id%TYPE,
  p_content IN Books.content%TYPE,
  p_quantity IN Books.quantity%TYPE DEFAULT 0, -- Добавлен новый параметр для quantity
  p_book_id OUT NUMBER
) AS
BEGIN
  INSERT INTO Books (title, description, price, year_published, cover_image, publisher_id, admin_id, content, quantity)
  VALUES (p_title, p_description, p_price, p_year_published, p_cover_image, p_publisher_id, p_admin_id, p_content, p_quantity)
  RETURNING book_id INTO p_book_id;
  COMMIT;
END;

--Процедура обновления данных книги 
CREATE OR REPLACE PROCEDURE Update_Book (
  p_book_id IN Books.book_id%TYPE,
  p_title IN Books.title%TYPE,
  p_description IN Books.description%TYPE,
  p_price IN Books.price%TYPE,
  p_year_published IN Books.year_published%TYPE,
  p_cover_image IN Books.cover_image%TYPE,
  p_publisher_id IN Books.publisher_id%TYPE,
  p_admin_id IN Books.admin_id%TYPE,
  p_content IN Books.content%TYPE,
  p_quantity IN Books.quantity%TYPE DEFAULT 0 -- Добавлен новый параметр для quantity
) AS
BEGIN
  UPDATE Books
  SET title = p_title,
      description = p_description,
      price = p_price,
      year_published = p_year_published,
      cover_image = p_cover_image,
      publisher_id = p_publisher_id,
      admin_id = p_admin_id,
      content = p_content,
      quantity = p_quantity
  WHERE book_id = p_book_id;
  COMMIT;
END;

--Процедура получения book_id для добавления авторов и категорий
Select * from Books
commit
--TODO
CREATE OR REPLACE PROCEDURE GET_BOOK_ID (p_book_id OUT NUMBER)
IS
BEGIN
  SELECT LAST_INSERT_ID() INTO p_book_id FROM dual;
END;
--Процедура добалвения автора к книге
CREATE OR REPLACE PROCEDURE Add_Author_Book (
  p_book_id IN Books.book_id%TYPE,
  p_author_id IN Authors.author_id%TYPE
) AS
BEGIN
  INSERT INTO Authors_Books (book_id, author_id)
  VALUES (p_book_id, p_author_id);
  COMMIT;
END;
--Процедура удаления всех авторов, связанных с книгой
CREATE OR REPLACE PROCEDURE DeleteAuthorsForBook(p_bookId IN NUMBER)
IS
BEGIN
  DELETE FROM Authors_Books WHERE book_id = p_bookId;
  COMMIT;
END;
--Процедура добавления категории к книге
CREATE OR REPLACE PROCEDURE Add_Category_Book (
  p_book_id       IN  NUMBER,
  p_category_id   IN  NUMBER
)
AS
BEGIN
  INSERT INTO Categories_Books (book_id, category_id)
  VALUES (p_book_id, p_category_id);
  COMMIT;
END;
--Процедура удаления категорий для книги
CREATE OR REPLACE PROCEDURE DeleteCategoriesForBook(p_book_id IN NUMBER) AS
BEGIN
  DELETE FROM Categories_Books WHERE book_id = p_book_id;
  COMMIT;
END;
--Процедура удаления книги 
CREATE OR REPLACE PROCEDURE Delete_Book(p_book_id IN NUMBER) AS
BEGIN
  DELETE FROM Books WHERE book_id = p_book_id;
  COMMIT;
END;
--Процедура поиска книги
CREATE OR REPLACE PROCEDURE Search_Books(
    p_search_text IN VARCHAR2,
    p_books OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN p_books FOR
        SELECT b.*
        FROM Books b
        LEFT JOIN Authors_Books ab ON b.book_id = ab.book_id
        LEFT JOIN Authors a ON ab.author_id = a.author_id
        LEFT JOIN Publishers p ON b.publisher_id = p.publisher_id
        WHERE LOWER(b.title) LIKE LOWER('%' || p_search_text || '%')
           OR LOWER(b.description) LIKE LOWER('%' || p_search_text || '%')
           OR LOWER(a.author_name) LIKE LOWER('%' || p_search_text || '%')
           OR LOWER(p.publisher_name) LIKE LOWER('%' || p_search_text || '%');
END;
--Процедура получения всех авторов
CREATE OR REPLACE PROCEDURE GET_ALL_AUTHORS(p_cursor OUT SYS_REFCURSOR) AS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Authors ORDER BY author_name ASC;
END;
--Получение авторов связанных с книгами
CREATE OR REPLACE PROCEDURE Get_Authors_For_Book (
    p_bookId IN Books.book_id%TYPE,
    p_authors OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_authors FOR
        SELECT Authors.author_id, Authors.author_name 
        FROM Authors_Books 
        INNER JOIN Authors ON Authors_Books.author_id = Authors.author_id 
        WHERE Authors_Books.book_id = p_bookId;
END;
--Процедура добавления авторов в таблицу
CREATE OR REPLACE PROCEDURE ADD_AUTHOR (
    p_author_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO Authors (author_id, author_name)
    VALUES (Authors_seq.NEXTVAL, p_author_name);
END;
--Процедура получения следующего значения id автор
CREATE OR REPLACE PROCEDURE Get_Next_Author_Id (p_author_id OUT NUMBER)
IS
BEGIN
SELECT Authors_seq.NEXTVAL INTO p_author_id FROM dual;
END;
--Процедура обновления имени автора
CREATE OR REPLACE PROCEDURE UPDATE_AUTHOR_PROCEDURE (
  p_author_name IN Authors.author_name%TYPE,
  p_author_id IN Authors.author_id%TYPE
)
IS
BEGIN
  UPDATE Authors
  SET author_name = p_author_name
  WHERE author_id = p_author_id;
  COMMIT;
END;
--Процедура удаления автора из таблицы
CREATE OR REPLACE PROCEDURE DELETE_AUTHOR(p_author_id IN NUMBER)
IS
BEGIN
    DELETE FROM Authors WHERE author_id = p_author_id;
END;
--Процедура получения всех категорий
CREATE OR REPLACE PROCEDURE GET_ALL_CATEGORIES (p_categories OUT SYS_REFCURSOR)
IS
BEGIN
OPEN p_categories FOR SELECT * FROM Categories ORDER BY category_name ASC;
END;
--Получение категорий для книги
CREATE OR REPLACE PROCEDURE Get_Category_For_Book(p_book_id IN NUMBER, p_categories OUT SYS_REFCURSOR)
AS
BEGIN
  OPEN p_categories FOR
    SELECT Categories.category_id, Categories.category_name
    FROM Categories_Books
    INNER JOIN Categories ON Categories_Books.category_id = Categories.category_id
    WHERE Categories_Books.book_id = p_book_id;
END;
--Процедура добавления новой категории
CREATE OR REPLACE PROCEDURE ADD_CATEGORY (
p_category_name IN VARCHAR2
)
IS
BEGIN
INSERT INTO Categories (category_id, category_name)
VALUES (Categories_seq.NEXTVAL, p_category_name);
COMMIT;
END;
--Процедура получения следующего id категории
CREATE OR REPLACE PROCEDURE GET_NEXT_CATEGORY_ID (p_category_id OUT NUMBER)
IS
BEGIN
  SELECT Categories_seq.NEXTVAL INTO p_category_id FROM dual;
END;
--Процедура обновления категории
CREATE OR REPLACE PROCEDURE Update_Category (
    p_category_id IN NUMBER,
    p_category_name IN VARCHAR2
)
IS
BEGIN
    UPDATE Categories
    SET category_name = p_category_name
    WHERE category_id = p_category_id;
END;
--Процедура удаления категории
CREATE OR REPLACE PROCEDURE Delete_Category (p_category_id IN NUMBER)
IS
BEGIN
  DELETE FROM Categories WHERE category_id = p_category_id;
  COMMIT;
END;
--Процедура получения всех редакторов 
CREATE OR REPLACE PROCEDURE GET_ALL_PUBLISHERS(p_cursor OUT SYS_REFCURSOR)
IS
BEGIN
  OPEN p_cursor FOR
    SELECT * FROM Publishers ORDER BY publisher_name ASC;
END;
--Процедура добавления редакторов
CREATE OR REPLACE PROCEDURE ADD_PUBLISHER (
    p_publisher_name IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Publishers (publisher_id, publisher_name)
    VALUES (Publishers_seq.NEXTVAL, p_publisher_name);
    COMMIT;
END;
--Процедура получения следующего id редакторов 
CREATE OR REPLACE PROCEDURE GET_NEXT_PUBLISHER_ID (p_next_id OUT NUMBER)
IS
BEGIN
SELECT publishers_seq.NEXTVAL INTO p_next_id FROM dual;
END;
--Процедура обновления редакторов
CREATE OR REPLACE PROCEDURE Update_Publisher(
    p_publisher_id IN Publishers.publisher_id%TYPE,
    p_publisher_name IN Publishers.publisher_name%TYPE
)
IS
BEGIN
    UPDATE Publishers SET publisher_name = p_publisher_name WHERE publisher_id = p_publisher_id;
    COMMIT;
END;
--Процедура удаления редактора 
CREATE OR REPLACE PROCEDURE DELETE_PUBLISHER(p_publisher_id IN Publishers.publisher_id%TYPE)
IS
BEGIN
  DELETE FROM Publishers WHERE publisher_id = p_publisher_id;
  COMMIT;
END;

--LISTAGG, которая объединяет названия книг в одну строку, разделяя их запятой и пробелом. Результирующая строка помещается в переменную books_list. 
--Если она не равна NULL, значит, есть книги, связанные с удаляемым издателем, и мы вызываем функцию RAISE_APPLICATION_ERROR, 
--чтобы сгенерировать ошибку с сообщением, включающим список названий книг.
--Этот индекс создает структуру данных, которая ускоряет выполнение запросов, которые используют столбец user_id в таблице Orders.
CREATE INDEX orders_user_id_idx ON Orders(user_id);
--Процедуры получение всех заказо и данных пользователей
CREATE OR REPLACE PROCEDURE GetOrdersAndUserData(
orders_and_user_data OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN orders_and_user_data FOR
    SELECT o.order_id, o.user_id, o.order_date, o.delivery_date, o.book_id, o.quantity, o.price, o.admin_id, 
           u.first_name, u.last_name, u.address, u.phone_number
    FROM Orders o
    INNER JOIN Users u ON o.user_id = u.user_id;
END;
--Процедура получения заказов пользователя и получения названия книги по индификатору
CREATE OR REPLACE PROCEDURE GetOrdersAndBookTitlesByUserId(
  p_user_id IN NUMBER,
  p_orders OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN p_orders FOR 
    SELECT o.*, b.title 
    FROM Orders o 
    JOIN Books b ON o.book_id = b.book_id 
    WHERE o.user_id = p_user_id;
END;
--Процедура удаления заказ
CREATE OR REPLACE PROCEDURE DeleteOrderById(p_order_id IN NUMBER) AS
BEGIN
  UPDATE Orders SET admin_id = 1 WHERE order_id = p_order_id;
  COMMIT;
END;
--Процедура изменения админимстратора для заказа
CREATE OR REPLACE PROCEDURE EditAdminId(
    p_order_id IN NUMBER,
    p_admin_id IN NUMBER
)
AS
BEGIN
    UPDATE Orders SET admin_id = p_admin_id WHERE order_id = p_order_id;
    COMMIT;
END;
--Процедура добавления заказа
--TODO
CREATE OR REPLACE PROCEDURE AddOrder(
    p_user_id IN ORDERS.USER_ID%TYPE,
    p_order_date IN ORDERS.ORDER_DATE%TYPE,
    p_delivery_date IN ORDERS.DELIVERY_DATE%TYPE,
    p_book_id IN ORDERS.BOOK_ID%TYPE,
    p_quantity IN ORDERS.QUANTITY%TYPE,
    p_price IN ORDERS.PRICE%TYPE,
    p_admin_id IN ORDERS.ADMIN_ID%TYPE)
IS
    v_available_quantity ORDERS.QUANTITY%TYPE;
BEGIN
    -- Проверяем, есть ли достаточное количество книг для заказа
    SELECT quantity INTO v_available_quantity
    FROM Books
    WHERE book_id = p_book_id;

    IF v_available_quantity >= p_quantity THEN
        -- Если есть достаточное количество книг, отнимаем их количество
        UPDATE Books
        SET quantity = quantity - p_quantity
        WHERE book_id = p_book_id;

        -- Выполняем вставку в таблицу Orders
        INSERT INTO Orders (order_id, user_id, order_date, delivery_date, book_id, quantity, price, admin_id)
        VALUES (Orders_seq.NEXTVAL, p_user_id, p_order_date, p_delivery_date, p_book_id, p_quantity, p_price, p_admin_id);
        COMMIT;
    ELSE
        -- Если не хватает книг, генерируем исключение или возвращаем код ошибки
        RAISE_APPLICATION_ERROR(-20001, 'Недостаточное количество книг для заказа');
    END IF;
END;


AddOrder
CREATE SEQUENCE Orders_seq START WITH 2 INCREMENT BY 1;
--Процедура получения отзывов
CREATE OR REPLACE PROCEDURE GetReviewsByBookId (
    p_book_id IN NUMBER,
    p_reviews OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_reviews FOR
        SELECT r.review_id, r.user_id, r.book_id, r.rating, r.review, u.email
        FROM Reviews r
        JOIN Users u ON r.user_id = u.user_id
        WHERE r.book_id = p_book_id;
END;
--Процедура удаления отзыв
CREATE OR REPLACE PROCEDURE DeleteReviewById(p_review_id IN NUMBER) IS
BEGIN
  DELETE FROM Reviews WHERE review_id = p_review_id;
END;
--Процедура добавления отзыва на книгу
--TODO
CREATE OR REPLACE PROCEDURE AddReview (
    p_user_id IN NUMBER,
    p_book_id IN NUMBER,
    p_rating IN NUMBER,
    p_review IN VARCHAR2
) AS
BEGIN
    INSERT INTO Reviews (review_id, user_id, book_id, rating, review)
    VALUES (Reviews_seq.NEXTVAL, p_user_id, p_book_id, p_rating, p_review);
END;
CREATE SEQUENCE Reviews_seq START WITH 2 INCREMENT BY 1;
--Процедура получения информации о пользователе
CREATE OR REPLACE PROCEDURE GetUser(
    p_user_id IN Users.user_id%TYPE,
    o_first_name OUT Users.first_name%TYPE,
    o_last_name OUT Users.last_name%TYPE,
    o_address OUT Users.address%TYPE,
    o_phone_number OUT Users.phone_number%TYPE
)
AS
BEGIN
    SELECT first_name, last_name, address, phone_number
    INTO o_first_name, o_last_name, o_address, o_phone_number
    FROM Users
    WHERE user_id = p_user_id;
END;
--Процедура обновления данных пользователя
CREATE OR REPLACE PROCEDURE UpdateUser(
    p_user_id IN INT,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_address IN VARCHAR2,
    p_phone_number IN VARCHAR2)
AS
BEGIN
    UPDATE Users
    SET first_name = p_first_name,
        last_name = p_last_name,
        address = p_address,
        phone_number = p_phone_number
    WHERE user_id = p_user_id;
END;
--Создание директории для xml файла
CREATE DIRECTORY xml_dir AS 'C:\app\xmldir';
--Процедура экспорта в xml 
CREATE OR REPLACE PROCEDURE export_books_to_xml AS
  xmltype_data XMLTYPE;
  xml_data CLOB;
BEGIN
  SELECT XMLELEMENT("Books",
           XMLAGG(
             XMLELEMENT("Book",
               XMLFOREST(
                 book_id AS "BookId",
                 title AS "Title",
                 description AS "Description",
                 price AS "Price",
                 year_published AS "YearPublished",
                 publisher_id AS "PublisherId",
                 admin_id AS "AdminId",
                 cover_image AS "CoverImage",
                 content AS "Content"
               )
             )
           )
         )
  INTO xmltype_data
  FROM Books;
  
  xml_data := xmltype_data.getClobVal();
  
  DBMS_XSLPROCESSOR.CLOB2FILE(xml_data, 'XML_DIR', 'books.xml');
  
  DBMS_OUTPUT.PUT_LINE('Exported data to XML file.');
END;
--Процедура импортда данных из xml файла в таблицу Books
CREATE OR REPLACE PROCEDURE import_books_from_xml AS
  xml_data CLOB;
BEGIN
  SELECT XMLTYPE(BFILENAME('XML_DIR', 'books.xml'), NLS_CHARSET_ID('AL32UTF8')).getClobVal()
  INTO xml_data
  FROM DUAL;
  
  INSERT INTO Books (book_id, title, description, price, year_published, cover_image, publisher_id, admin_id, content)
  SELECT t.book_id, t.title, t.description, t.price, t.year_published, t.cover_image, t.publisher_id, t.admin_id, t.content
  FROM XMLTABLE('/Books/Book' PASSING XMLTYPE(xml_data) 
                COLUMNS book_id INT PATH 'BookId', 
                        title VARCHAR2(255) PATH 'Title', 
                        description VARCHAR2(4000) PATH 'Description', 
                        price DECIMAL(10,2) PATH 'Price', 
                        year_published DATE PATH 'YearPublished', 
                        cover_image BLOB PATH 'CoverImage',
                        publisher_id INT PATH 'PublisherId', 
                        admin_id INT PATH 'AdminId',
                        content BLOB PATH 'Content') t;
  
  DBMS_OUTPUT.PUT_LINE('Imported data from XML file.');
END;
--Вызов процедур экспорта и импорта
BEGIN
  export_books_to_xml;
END;
BEGIN
  import_books_from_xml;
END;
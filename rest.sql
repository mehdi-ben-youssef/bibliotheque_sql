USE library;

-- =====================================================
-- 1. BASIC CHECKS: is the data there?
-- =====================================================
SELECT * FROM categories;
SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM loans;

-- =====================================================
-- 2. JOINS
-- =====================================================

-- Books with their author and category
SELECT b.title,
       CONCAT(a.first_name, ' ', a.last_name) AS author,
       c.name AS category,
       b.publication_year
FROM books b
JOIN authors a ON b.author_id = a.id
JOIN categories c ON b.category_id = c.id;

-- All loans: who borrowed what, and when
SELECT CONCAT(m.first_name, ' ', m.last_name) AS member,
       b.title,
       l.loan_date,
       l.return_date
FROM loans l
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id
ORDER BY l.loan_date;

-- =====================================================
-- 3. FILTERING
-- =====================================================

-- Books not yet returned (currently on loan)
SELECT CONCAT(m.first_name, ' ', m.last_name) AS member,
       b.title,
       l.loan_date
FROM loans l
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id
WHERE l.return_date IS NULL;

-- Books published after 2000
SELECT title, publication_year
FROM books
WHERE publication_year > 2000;

-- British authors
SELECT * FROM authors WHERE nationality = 'British';

-- =====================================================
-- 4. AGGREGATES (COUNT, GROUP BY)
-- =====================================================

-- Number of books per category (including empty categories)
SELECT c.name, COUNT(b.id) AS total_books
FROM categories c
LEFT JOIN books b ON b.category_id = c.id
GROUP BY c.id, c.name;

-- Number of loans per member
SELECT CONCAT(m.first_name, ' ', m.last_name) AS member,
       COUNT(l.id) AS total_loans
FROM members m
LEFT JOIN loans l ON l.member_id = m.id
GROUP BY m.id, m.first_name, m.last_name;

-- Number of days each returned book was kept
SELECT b.title,
       DATEDIFF(l.return_date, l.loan_date) AS days_kept
FROM loans l
JOIN books b ON l.book_id = b.id
WHERE l.return_date IS NOT NULL;

-- =====================================================
-- 5. DATA MODIFICATION (INSERT / UPDATE / DELETE)
-- =====================================================

-- New loan: Ahmed borrows Sapiens
INSERT INTO loans (member_id, book_id, loan_date)
VALUES (1, 4, CURDATE());

-- Mark that book as unavailable
UPDATE books SET available = FALSE WHERE id = 4;

-- Fix the category of "1984" (Science Fiction instead of History)
UPDATE books SET category_id = 1 WHERE id = 1;

-- Mark the loan of "Clean Code" as returned today
UPDATE loans SET return_date = CURDATE()
WHERE book_id = 2 AND return_date IS NULL;

-- Delete a test member (only works if they have no loans)
-- DELETE FROM members WHERE id = 3;

-- =====================================================
-- 6. TEST THAT CONSTRAINTS WORK (these should FAIL)
-- =====================================================
-- Duplicate ISBN:
-- INSERT INTO books (title, isbn, category_id, author_id)
-- VALUES ('Fake', '9780451524935', 1, 1);

-- Duplicate email:
-- INSERT INTO members (first_name, last_name, email)
-- VALUES ('Test', 'User', 'ahmed@example.com');

-- Foreign key violation (author 999 doesn't exist):
-- INSERT INTO books (title, category_id, author_id)
-- VALUES ('Ghost Book', 1, 999);

USE library;

-- Categories
INSERT INTO categories (name, description) VALUES
('Science Fiction', 'Books about futuristic science and technology'),
('Programming', 'Books about software development and programming'),
('History', 'Books about historical events and civilizations'),
('Fantasy', 'Books about magic and imaginary worlds');

-- Authors
INSERT INTO authors (first_name, last_name, nationality) VALUES
('George', 'Orwell', 'British'),
('Robert', 'Martin', 'American'),
('J.K.', 'Rowling', 'British'),
('Yuval Noah', 'Harari', 'Israeli');

-- Books
INSERT INTO books 
(title, isbn, publication_year, available, category_id, author_id) VALUES
('1984', '9780451524935', 1949, TRUE, 3, 1),
('Clean Code', '9780132350884', 2008, TRUE, 2, 2),
('Harry Potter and the Philosopher''s Stone', '9780747532699', 1997, TRUE, 4, 3),
('Sapiens', '9780062316097', 2011, TRUE, 3, 4);

-- Members
INSERT INTO members 
(first_name, last_name, email, registration_date) VALUES
('Ahmed', 'Ben Ali', 'ahmed@example.com', '2026-01-15'),
('Sara', 'Trabelsi', 'sara@example.com', '2026-02-10'),
('Youssef', 'Mansour', 'youssef@example.com', '2026-03-05');

-- Loans
INSERT INTO loans 
(member_id, book_id, loan_date, return_date) VALUES
(1, 1, '2026-09-01', '2026-09-10'),
(2, 2, '2026-09-05', NULL),
(3, 3, '2026-09-10', '2026-09-18');
--  q1
SELECT distinct
    s.name,
    x.book,
FROM loan x, student s,
WHERE x.borrower = s.email and x.borrowed < s.year;

-- q2
SELECT 
    s.name,
    AVG(DATEDIFF(l.returned, l.burrowed)) as avg_duration
FROM student s, loan l
WHERE
    s.email = l.borrower
    AND l.returned IS NOT NULL
    GROUP BY s.name
    ORDER BY avg_duration ASC
    LIMIT 5;

-- q3

SELECT DISTINCT l.borrower
FROM loan l, copy c, student s_owner
WHERE l.owner = c.owner
AND l.book = c.book
AND l.copy = c.copy
AND c.owner = s_owner.email
AND s_owner.department = 'CS'

EXCEPT

SELECT DISTINCT l.owner
FROM loan l, student s_borrower
WHERE l.borrower = s_borrower.email
AND s_borrower.department = 'Math'

-- q4
SELECT DISTINCT b.authors
FROM book b
WHERE b.ISBN13 NOT IN (
    SELECT x.book
    FROM loan x, student s
    WHERE x.borrower = s.email and s.department = 'CS'
)

-- q5
SELECT
    s.name, s.department,
    COUNT(x.book) AS num_burrowed
    FROM
        student s LEFT JOIN loan x ON s.email = x.borrower
    GROUP BY
    s.name, s.department;


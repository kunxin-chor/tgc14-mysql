/* q1 */
select FirstName, LastName, Title from Employee
where Title = "Sales Support Agent";

/* q2 */
SELECT LastName, FirstName, HireDate FROM
 Employee
WHERE YEAR(HireDate) BETWEEN 2002 AND 2003;

/* q3 */
SELECT * from Artist WHERE
Name LIKE "%metal%";

/* q4 */
SELECT * FROM Employee WHERE Title LIKE "%sales%";

/* q5 */
SELECT Track.Name, Genre.Name FROM Track
    JOIN Genre ON Track.GenreId = Genre.GenreId
    WHERE Genre.Name = "Easy Listening";

/* q6 */
SELECT Track.Name, Album.Title, Genre.Name FROM
    Track JOIN Album ON Track.AlbumId = Album.AlbumId
          JOIN Genre ON Track.GenreId = Genre.GenreId
          LIMIT 10 OFFSET 10;

/* q7 */
SELECT BillingCountry, AVG(Total) FROM Invoice
GROUP BY BillingCountry;

/* q8 */
SELECT BillingCountry, AVG(Total) as "AverageTotal" FROM Invoice
GROUP BY BillingCountry
HAVING AverageTotal > 5.5;

/* q9 */
SELECT AVG(Total), CustomerId FROM Invoice WHERE
    CustomerId IN (SELECT CustomerId FROM Invoice  
                   GROUP BY CustomerId
                   HAVING SUM(Total) > 10) AND
    BillingCountry LIKE "%Germany%"
    GROUP BY CustomerId;

SELECT CustomerId, BillingCountry, AVG(Total)
FROM Invoice
WHERE BillingCountry = "Germany"
GROUP BY CustomerId
HAVING SUM(Total) > 10;

/* Q10 */
SELECT Album.AlbumId, Album.Title, AVG(Track.MilliSeconds), Genre.Name
FROM Track JOIN Album ON Track.AlbumId = Album.AlbumId
           JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = "Jazz"
GROUP BY Album.AlbumId, Album.Title, Genre.Name;

/* FYI, only_full_group_by */
/* https://stackoverflow.com/questions/41887460/select-list-is-not-in-group-by-clause-and-contains-nonaggregated-column-inc */

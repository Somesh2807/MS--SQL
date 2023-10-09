Part 1: The TPC--‐H database 

Q-1 What are the names of the customers who have a balance that is greater than $9000 and are in the“HOUSEHOLD” market segment? 

ANS:  

SELECT CustomerName 

FROM Customer 

WHERE Balance > 9000 AND MarketSegment = 'HOUSEHOLD'; 

 

Q-2 Which parts are supplied by at least 1 supplier from the region “MIDDLE EAST”? Include the part 

name in your answer along with the part key. Eliminate any duplicates and sort your answer based on the part key. 

ANS: 

SELECT DISTINCT P.PartKey, P.PartName 

FROM Part P 

INNER JOIN Partsupp SP ON P.PartKey = SP.PartKey 

INNER JOIN Supplier S ON SP.SupplierKey = S.SupplierKey 

WHERE S.Region = 'MIDDLE EAST' 

ORDER BY P.PartKey; 

Q-3 How many distinct parts are supplied by European suppliers? 

ANS: 

SELECT COUNT(DISTINCT P.PartKey) AS TotalDistinctParts 

FROM Part P 

INNER JOIN Partsupp SP ON P.PartKey = SP.PartKey 

INNER JOIN Supplier S ON SP.SupplierKey = S.SupplierKey 

WHERE S.Region = 'Europe'; 

Q-4 Which parts are not supplied by any supplier from EUROPE? Include the part name in your answer. 

ANS: 

SELECT P.PartName 

FROM Part P 

WHERE P.PartKey NOT IN ( 

    SELECT DISTINCT SP.PartKey 

    FROM Partsupp SP 

    INNER JOIN Supplier S ON SP.SupplierKey = S.SupplierKey 

    WHERE S.Region = 'Europe' 

); 

 

Q-5 Which customers ordered parts ONLY from suppliers in the same region? Include the customer name, phone and region in your answer, and remove any duplicates. 

ANS: 

SELECT DISTINCT C.CustomerName, C.CustomerPhone, C.CustomerRegion 

FROM Customers C 

WHERE NOT EXISTS ( 

    SELECT O.CustomerID 

    FROM Orders O 

    JOIN Region R ON O.Region = R. Region 

    WHERE O.CustomerID = C.CustomerID 

    GROUP BY O.CustomerID 

    HAVING COUNT(DISTINCT R.SupplierRegion) > 1 

) 

Q-6 What is the highest extended price for parts that had a discount larger than the tax when ordered? 

ANS: 

SELECT MAX(TotalPrice) AS HighestExtendedPrice 

FROM Orders 

WHERE Discount > Tax; 

Q-7 The number of orders that had all of their items received in at most 2 weeks of shipment. 

HINT1: avoid counting duplicates. 

HINT2: In SQL Server, you can compute the date difference with the DATEDIFF() function. It takes 3 

parameters: unit, start date, end date. For example, SELECT DATEDIFF(day, '2013--‐09--‐16', '2013--‐09--‐23') returns 7 as the answer. You can put fields in the 2 nd and 3rd argument. 

ANS: 

SELECT COUNT(DISTINCT o.OrderID) AS NumberOfOrders 

FROM Orders o 

JOIN OrderItems oi ON o.OrderID = oi.OrderID 

WHERE DATEDIFF(day, o.ShipmentDate, oi.ReceivedDate) <= 14; 

 

Q-8 The number of (distinct) customers who did not order any part that has some American supplier. 

ANS: 

SELECT COUNT(DISTINCT c.CustomerID) AS NumberOfCustomers 

FROM Customers c 

WHERE c.CustomerID NOT IN ( 

    SELECT DISTINCT c.CustomerID 

    FROM Customers c 

    JOIN Orders o ON c.CustomerID = o.CustomerID 

    JOIN Parts p ON oi.PartID = p.PartID 

    JOIN Supplier s ON p.SupplierID = s.SupplierID 

    WHERE s.Country = 'USA' 

); 

Q-9 Which nation doesthe customer with the highest balance come from? HINT: you can find the 

maximum value with a simple nested select query.	 

ANS: 

SELECT Nationkey 

FROM Customers 

WHERE Balance = ( 

    SELECT MAX(Balance) 

    FROM Customers 

); 

Q-10 List the names of the countries where some parts took more than 29 days to ship, despite being supplied from a supplier to a customer in this same country. 

ANS: 

SELECT DISTINCT c.Country 

FROM Customers c 

JOIN Orders o ON c.CustomerID = o.CustomerID 

JOIN LineItems oi ON o.OrderID = oi.OrderID 

JOIN Parts p ON oi.PartID = p.PartID 

JOIN Suppliers s ON p.SupplierID = s.SupplierID 

WHERE c.Country = s.Country 

AND DATEDIFF(day, o.ShipmentDate, oi.ReceivedDate) > 29; 

 

 

PART II: The CHINOOK database: 

Q-1 Which artists did not make any albums at all? Include their names in your answer. 

ANS: 

SELECT Name 

FROM Artist 

WHERE ArtistId NOT IN (SELECT DISTINCT ArtistId FROM Album); 

 

Q-2 Which artists did not record any tracks of the Latin genre? 

ANS: 

SELECT Artist.Name 

FROM Artist 

LEFT JOIN Album ON Artist.ArtistId = Album.ArtistId 

LEFT JOIN Track ON Album.AlbumId = Track.AlbumId 

LEFT JOIN Genre ON Track.GenreId = Genre.GenreId 

WHERE Genre.Name IS NULL OR Genre.Name <> 'Latin'; 

 

Q-3 Which video track has the longest length? 

ANS: 

SELECT Track.Name, Track.Milliseconds 

FROM Track 

WHERE Track.MediaTypeId = <YourMediaTypeIdForVideo> 

ORDER BY Track.Milliseconds DESC 

Q-4 Find the names of customers who live in the same city as the top employee (The one not managed 

by anyone). 

ANS: 

SELECT DISTINCT Customer.FirstName, Customer.LastName 

FROM Customer 

INNER JOIN Employee ON Customer.City = Employee.City 

WHERE Employee.ReportsTo IS NULL; 

 

Q-5 ‐Find the managers of employees supporting Brazilian customers. 

ANS: SELECT DISTINCT Manager.FirstName AS ManagerFirstName, Manager.LastName AS ManagerLastName 

FROM Employee AS Manager 

JOIN Employee AS SupportEmployee ON Manager.EmployeeId = SupportEmployee.ReportsTo 

JOIN Customer ON Customer.SupportRepId = SupportEmployee.EmployeeId 

WHERE Customer.Country = 'Brazil'; 

 

Q-6 How many audio tracks in total were bought by German customers? And what was the total price paid for them? 

ANS:	 

SELECT 

    COUNT(*) AS TotalAudioTracks, 

    SUM(InvoiceLine.UnitPrice) AS TotalPrice 

FROM 

    Invoice 

JOIN 

    InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId 

JOIN 

    Track ON InvoiceLine.TrackId = Track.TrackId 

JOIN 

    MediaType ON Track.MediaTypeId = MediaType.MediaTypeId 

JOIN 

    Customer ON Invoice.CustomerId = Customer.CustomerId 

WHERE 

    Customer.Country = 'Germany' 

    AND MediaType.Name LIKE 'audio%'; 

 

Q-7 Which playlists have no Latin tracks? 

ANS: 	 

SELECT Playlist.Name 

FROM Playlist 

LEFT JOIN PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId 

LEFT JOIN Track ON PlaylistTrack.TrackId = Track.TrackId 

LEFT JOIN Genre ON Track.GenreId = Genre.GenreId 

WHERE Genre.GenreId IS NULL OR Genre.Name <> 'Latin' 

GROUP BY Playlist.Name; 

 

Q-8 ‐‐ What is the space, in bytes, occupied by the playlist “Grunge”, and how much would it cost? 

(Assume that the cost of a playlist is the sum of the price of its constituent tracks). 

ANS: 

SELECT 

    Playlist.Name AS PlaylistName, 

    SUM(Track.Bytes) AS TotalBytes, 

    SUM(Track.UnitPrice) AS TotalCost 

FROM 

    Playlist 

JOIN 

    PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId 

JOIN 

    Track ON PlaylistTrack.TrackId = Track.TrackId 

WHERE 

    Playlist.Name = 'Grunge'; 

 

Q-9 Which playlists do not contain any tracks for the artists “Black Sabbath” nor “Chico Buarque” ? 

ANS: 

SELECT DISTINCT Playlist.Name 

FROM Playlist 

LEFT JOIN PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId 

LEFT JOIN Track ON PlaylistTrack.TrackId = Track.TrackId 

LEFT JOIN Album ON Track.AlbumId = Album.AlbumId 

LEFT JOIN Artist ON Album.ArtistId = Artist.ArtistId 

WHERE Artist.Name NOT IN ('Black Sabbath', 'Chico Buarque') 

OR Artist.Name IS NULL; 

 

Q-10 List the names and the countries of those customers who are supported by an employee who was younger than 35 when hired. HINT: use year as the first parameter in DATEDIFF(). 

ANS: 

SELECT DISTINCT Customer.FirstName, Customer.LastName, Customer.Country 

FROM Customer 

JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId 

WHERE DATEDIFF(YEAR, Employee.HireDate, GETDATE()) < 35; 

 

 

 
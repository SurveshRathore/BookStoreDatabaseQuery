select * from BookTable

create index ix_bookName
ON BookTable (BookName)

select * from BookTable where  BookName = 'book1'

--With the index in place, the database will be able to quickly find all the rows in the "BookTable" table that match the BookName

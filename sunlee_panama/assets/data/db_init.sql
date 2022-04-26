    DROP TABLE IF EXISTS order_document;
    CREATE TABLE order_document (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    idClient TEXT, 
    clientName TEXT,
    dateOrder TEXT, 
    idSeller TEXT, 
    sellerName TEXT,
    totalDocument REAL
    );
    DROP TABLE IF EXISTS order_item;
    CREATE TABLE order_item (
     id INTEGER PRIMARY KEY AUTOINCREMENT, 
    idOrder INTEGER, 
    productId TEXT, 
    productName TEXT, 
    productQuantity INTEGER, 
    productSalePrice REAL
    );
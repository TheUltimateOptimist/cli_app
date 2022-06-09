import pyodbc

conn = pyodbc.connect('DSN=TestConnection')
cursor = conn.cursor()
cursor.execute("Select * from scraped_companys LIMIT 30")
for row in cursor.fetchall():
    print(row)

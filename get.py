import pyodbc

conn = pyodbc.connect('DSN=Stieber')
cursor = conn.cursor()
cursor.execute("Select * from beleg LIMIT 20")
for row in cursor.fetchall():
    print(row)

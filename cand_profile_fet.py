import sqlite3

# Replace 'Candidate.db' with the path to your SQLite database file
db_file = 'Candidate.db'

# Create a connection to the database
conn = sqlite3.connect(db_file)

# Create a cursor object to execute SQL commands
cursor = conn.cursor()

user_input = {
    'Candidate_ID' : ''
}

# Define the email you want to search for (replace with the actual email)
id_to_search = user_input['Candidate_ID']

# Execute a SELECT query to fetch all rows from the 'UserTable' table where the email matches
cursor.execute("SELECT * FROM CandidateProfile WHERE Candidate_ID = ?", (id_to_search,))

# Fetch all rows and print them
rows = cursor.fetchall()

# Print the column names
column_names = [description[0] for description in cursor.description]
print(column_names)

# Print the data
for row in rows:
    print(row)

# Close the database connection when you're done
conn.close()
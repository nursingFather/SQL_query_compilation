import sqlite3

conn = sqlite3.connect('Candidate.db')
c = conn.cursor()

# Create UserTable
c.execute("""CREATE TABLE UserTable (
        CandidateID INTEGER PRIMARY KEY AUTOINCREMENT,
        picture BLOB,
        First_Name TEXT,
        Last_Name TEXT,
        Dob DATE,
        Email TEXT,
        Created_time TIMESTAMP,
        Last_update_time TIMESTAMP,
        Deleted_time TIMESTAMP,
        Nationality TEXT,
        City TEXT,
        Subscription_ID INTEGER,
        Salary_Expectation REAL,
        FOREIGN KEY (Subscription_ID) REFERENCES Subscription(SubscriptionID) 
)""")

# Create CandidateProfile
c.execute("""CREATE TABLE CandidateProfile (
        ProfileID INTEGER PRIMARY KEY AUTOINCREMENT,  
        Candidate_ID INTEGER,
        Institution_attended TEXT,
        Graduation_year REAL,
        Grade REAL,
        Relevant_competency TEXT,
        Competency_rating REAL,
        Linkedin_profile TEXT,
        Certification TEXT,
        Extra_interview_stage TEXT,
        willing_to_relocate TEXT,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID) 
)""")

# Create Experience
c.execute("""CREATE TABLE Experience (
        Number_of_firms_worked REAL,
        Years_of_experience REAL,
        Hard_skills TEXT,
        Soft_skills TEXT,
        Competency_rating REAL,
        Current_place_of_work TEXT,
        Candidate_ID INTEGER,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID) 
)""")

# Create Education
c.execute("""CREATE TABLE Education (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,  -- Added AUTOINCREMENT
        Name_of_institution TEXT,
        Degree_level TEXT,
        Institution_Type TEXT,  
        Grade REAL,
        Qualification TEXT,
        Candidate_ID INTEGER, 
        Institution_Category TEXT,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID)
)""")

# Create WorkPlace
c.execute("""CREATE TABLE WorkPlace (
        ID INTEGER PRIMARY KEY AUTOINCREMENT, 
        Name_of_company TEXT,
        Start_date DATE,  
        End_date DATE,
        Candidate_ID INTEGER,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID)
)""")

# Create GoalSetting
c.execute("""CREATE TABLE GoalSetting (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,  
        Candidate_ID INTEGER
        Goal_Type TEXT,  
        Created_time TIMESTAMP,
        Last_Updated_Time TIMESTAMP,
        Set_Date DATE,
        Status TEXT,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID)
)""")

# Create Goal
c.execute("""CREATE TABLE Goal (
        GoalID INTEGER PRIMARY KEY AUTOINCREMENT,  
        GoalType TEXT
)""")

# Create Test
c.execute("""CREATE TABLE Test (
        TestID INTEGER PRIMARY KEY AUTOINCREMENT, 
        Test_Type TEXT,
        Test_Name TEXT,
        Test_Role TEXT,
        Candidate_ID INTEGER,  
        Scheduled TEXT,
        Trial_counter REAL,
        Score REAL,
        Created_Time TIMESTAMP,
        Duration REAL,
        Start_Time TIMESTAMP,
        End_Time TIMESTAMP,
        Updated_Time TIMESTAMP,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID)
)""")

# Create Subscriptions
c.execute("""CREATE TABLE Subscription (
        SubscriptionID INTEGER PRIMARY KEY AUTOINCREMENT,  
        Subscription_Type TEXT,
        Fee REAL,
        Frequency INTEGER
)""")

# Create ProfileSettings
c.execute("""CREATE TABLE ProfileSettings (
        Profile_ID INTEGER PRIMARY KEY AUTOINCREMENT,  
        Candidate_ID INTEGER,  
        Market_Status TEXT,
        Cycle_Settings TEXT,
        Extra_Stages TEXT,
        Created_Date DATE,
        Deleted_Date DATE,
        Updated_Date DATE,
        Minimum_Negotiation REAL,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID)
)""")

# Create SalaryInfo
c.execute("""CREATE TABLE SalaryInfo (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,  
        Salary REAL,
        Upper_Market_Value_Local REAL,
        Lower_Market_Value_Local REAL,
        Upper_Market_Value_International REAL,
        Lower_Market_Value_International REAL,
        Minimum_Acceptable_Offer REAL,
        Title TEXT,
        Rank TEXT,
        Score_Role_1 REAL,  
        Score_1 REAL,
        Score_Role_2 REAL,  
        Score_2 REAL,
        Candidate_ID INTEGER,
        FOREIGN KEY (Candidate_ID) REFERENCES UserTable(CandidateID)
)""")

conn.commit()
conn.close()




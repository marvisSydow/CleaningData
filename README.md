ReadMe
=========================================================================

For Execution of code
As a first step update the variable called 'folderpath' by entering the path where your "UCI HAR Dataset" material is located on your computer.
The code is then setting your current environment to that path.

Generally lines of code fulfilling certain steps from the assignment are commented with the respective number of the step, 
like that: #3


Reading in Data
=========================================================================

We are not including any of the data coming from the Inertial Folder 
since such data is not expected to be used or even kept in this assignment

Extra Steps not expected in Assignment
=========================================================================
For the 'adset_raw' we keep the original coded numbers for activities (1-6) and we also add a 
variable to distinguish test from train rows 'tr_tst'. This would be used in later steps of the data science pipeline

Result Dataset from Step 5
=========================================================================
For the tidied output dataset called "tidy_dataset" the wide format was chosen.
Variables are:
- SubectID : The subject identifier number, ranges from 1 - 30
- Activity: Activity type of the record
- 79 Variables with Mean or Standard Deviations of measured activity data

Use this code to load the result dataset provided with the assignment into your R session:
data <- read.table("tidy_dataset.txt", header = TRUE)




EMPLOYEE ATTENDANCE ANALYSIS

Project Overview and Purpose

The purpose of the Employee Attendance Analysis project is to develop a PL/SQL procedure to analyze employee attendance over a specified month and year. The company needs this procedure to calculate attendance statistics, including the number of days each employee was present and absent, along with the attendance percentage for the specified month. This procedure provides insights into employee attendance behavior, helping management understand patterns and identify any attendance issues.

Explanation of Each Component

This PL/SQL procedure, analyze_employee_attendance, calculates and displays monthly attendance statistics for each employee in a company.

Procedure Definition
![image](https://github.com/user-attachments/assets/12aa282b-01e1-4185-8a8b-222bc6ba851c)

The procedure is named analyze_employee_attendance.

It takes two input parameters:

p_month: The month for which attendance is being analyzed.

p_year: The year for which attendance is being analyzed.

Variable Declarations

![image](https://github.com/user-attachments/assets/f433b804-49a0-4651-bc2f-c05951d8a72b)

v_employee_id, v_first_name, and v_last_name: Variables to store each employee's ID, first name, and last name.

v_total_present and v_total_absent: Counters to track the total number of days the employee was marked as 'Present' and 'Absent' for the specified month.

v_attendance_percent: Stores the calculated attendance percentage.

v_days_in_month: Holds the total number of days in the specified month.

Cursors

emp_cursor - Fetches Employees

![image](https://github.com/user-attachments/assets/ddea0668-85ee-4e35-b97e-0b1f7b4f0147)

This cursor selects all employees from the employees table. The FOR loop will later use this cursor to process each employee.

attendance_cursor - Fetches Attendance Records

![image](https://github.com/user-attachments/assets/9d0d65d9-d2b3-496a-98b2-c21284de770e)

This cursor fetches attendance records for a specific employee (emp_id) for the given p_month and p_year.

EXTRACT functions filter records based on the specified month and year.

Main Procedure Logic

Calculate Days in Month

![image](https://github.com/user-attachments/assets/581294d1-c0c9-4dea-89f2-330fd02e4ef2)

This query calculates the total number of days in the specified month by finding the last day and extracting the day number. The result is stored in v_days_in_month.

Loop Through Employees

![image](https://github.com/user-attachments/assets/be1b6377-5362-4304-a4f3-21041cb58b85)

The FOR loop iterates over each employee in emp_cursor. For each employee, it initializes the attendance counters (v_total_present and v_total_absent) to zero.

Loop Through Attendance Records for Each Employee

![image](https://github.com/user-attachments/assets/9e042a75-3a86-4b3e-9dd4-c552652d76af)

This inner loop iterates over the attendance records of each employee in the specified month and year.

If the attendance status is 'Present', it increments v_total_present.

If the status is 'Absent', it increments v_total_absent.

Calculate Attendance Percentage and Display Results

![image](https://github.com/user-attachments/assets/c6d9b434-dfa4-4adf-bdaf-7c965d88cb26)

If there are attendance records for the employee (v_total_present + v_total_absent > 0), it calculates the attendance percentage and displays it along with the employee's name, total presents, and absents.

If no attendance records are found for that month, it displays a message indicating no records for the employee.

Exception Handling

![image](https://github.com/user-attachments/assets/40814434-e20b-44cd-8938-ab6e71122f69)

NO_DATA_FOUND: Catches cases where no data matches the query.

OTHERS: Catches any other errors, displaying the error message (SQLERRM).

This procedure analyzes employee attendance for a specified month and year, using a combination of loops, conditions, and cursors to process each employee's data and handle any exceptions.











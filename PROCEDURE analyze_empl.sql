CREATE OR REPLACE PROCEDURE analyze_employee_attendance (
    p_month IN NUMBER,
    p_year IN NUMBER
) IS
    -- Variables for storing employee details and attendance counts
    v_employee_id        employees.employee_id%TYPE;
    v_first_name         employees.first_name%TYPE;
    v_last_name          employees.last_name%TYPE;
    v_total_present      NUMBER := 0;
    v_total_absent       NUMBER := 0;
    v_attendance_percent NUMBER := 0;
    v_days_in_month      NUMBER;
    
    -- Cursor to select employees
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, last_name
        FROM employees;

    -- Cursor for attendance records for each employee in the specified month
    CURSOR attendance_cursor (emp_id NUMBER) IS
        SELECT status
        FROM attendance
        WHERE employee_id = emp_id
          AND EXTRACT(MONTH FROM attendance_date) = p_month
          AND EXTRACT(YEAR FROM attendance_date) = p_year;

BEGIN
    -- Calculate the number of days in the specified month
    SELECT TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(p_year || '-' || p_month || '-01', 'YYYY-MM-DD')), 'DD'))
    INTO v_days_in_month
    FROM dual;
    
    -- Loop through all employees
    FOR emp_record IN emp_cursor LOOP
        -- Reset attendance counters for each employee
        v_employee_id := emp_record.employee_id;
        v_first_name := emp_record.first_name;
        v_last_name := emp_record.last_name;
        v_total_present := 0;
        v_total_absent := 0;
        
        -- Loop through attendance records for the specified month and year
        FOR att_record IN attendance_cursor(v_employee_id) LOOP
            IF att_record.status = 'Present' THEN
                v_total_present := v_total_present + 1;
            ELSIF att_record.status = 'Absent' THEN
                v_total_absent := v_total_absent + 1;
            END IF;
        END LOOP;

        -- Calculate attendance percentage if there are attendance records
        IF v_total_present + v_total_absent > 0 THEN
            v_attendance_percent := (v_total_present / v_days_in_month) * 100;
            DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name);
            DBMS_OUTPUT.PUT_LINE('Total Presents: ' || v_total_present);
            DBMS_OUTPUT.PUT_LINE('Total Absents: ' || v_total_absent);
            DBMS_OUTPUT.PUT_LINE('Attendance Percentage: ' || ROUND(v_attendance_percent, 2) || '%');
            DBMS_OUTPUT.PUT_LINE('----------------------------');
        ELSE
            -- No attendance records found for the month
            DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name);
            DBMS_OUTPUT.PUT_LINE('No attendance records for the specified month.');
            DBMS_OUTPUT.PUT_LINE('----------------------------');
        END IF;
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No records found for the specified month and year.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END analyze_employee_attendance;
-- Here, Call the procedure
/
BEGIN
    analyze_employee_attendance(10, 2024);
END;
/

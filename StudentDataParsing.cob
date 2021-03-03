       IDENTIFICATION DIVISION. 
       PROGRAM-ID. SAMPLE.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.   
           SELECT EMPLOYEE-DATA   ASSIGN TO 
         "C:\USERS\Desktop\COBOL\opencobol11\LABDATA.DAT"
                 ORGANIZATION IS LINE SEQUENTIAL.
           SELECT PAYROLL-LISTING  ASSIGN TO 
         "C:\USERS\Desktop\COBOL\opencobol11\RD.DAT"
                 ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD EMPLOYEE-DATA.
       01 EMPLOYEE-RECORD.
           05  SSNO-IN               PICTURE X(12).
           05  STUDENT-NAME-IN       PICTURE X(18).
           05  CLASS-IN              PICTURE X(1).
           05  SCHOOL-IN             PICTURE X(1).
           05  GPA-IN                PICTURE 9(3).  
           05  CREDITS-IN            PICTURE X(3).


           05  HOURLY-RATE-IN        PICTURE 9V99.
       FD  PAYROLL-LISTING.
       01  PRINT-REC.
           05  SSNO-OUT              PICTURE X(12).
           05                        PICTURE x(2).
           05  STUDENT-NAME-OUT      PICTURE X(18).
           05                        PICTURE x(2).
           05  CLASS-OUT             PICTURE X(10).
           05                        PICTURE x(2).
           05  SCHOOL-OUT            PICTURE X(10).
           05                        PICTURE x(2).
           05  GPA-OUT               PICTURE 9.99.  
           05                        PICTURE x(5).
           05  CREDITS-OUT           PICTURE X(3).
       WORKING-STORAGE SECTION.
       01  ARE-THERE-MORE-RECORDS    PICTURE XXX VALUE  'YES'.
       01  LINE-CT                             PIC 99     VALUE 0.
       01  WS-DATE.
           05 WS-YEAR                          PIC 9999.
           05 WS-MONTH                         PIC 99.
           05 WS-DAY                           PIC 99.
       01  HDR-1.
           05                                  PIC X(15)  VALUE SPACES.
           05                                  PIC X(5)   VALUE 'PAGE'.
           05  PAGE-NO                         PIC 99     VALUE ZERO.
           05                                  PIC X(22)  VALUE SPACES.
           05  DATE-OUT.
               10 MONTH-OUT                    PIC XX.
               10                              PIC X      VALUE '/'.
               10 DAY-OUT                      PIC XX.
               10                              PIC X      VALUE '/'.
               10 YEAR-OUT                     PIC XXXX.
       01  HDR-2.
           05                                  PIC X(2)   VALUE SPACES.
           05                                  PIC X(20)
                VALUE 'SSNO . NO.'.
           05                                  PIC X(58)
           VALUE 'NAME         CLASS      SCHOOL       GPA   CREDITS'.
       PROCEDURE DIVISION.
       100-MAIN-MODULE.
           OPEN INPUT EMPLOYEE-DATA
           OUTPUT PAYROLL-LISTING
           MOVE FUNCTION CURRENT-DATE TO WS-DATE
           MOVE WS-MONTH TO MONTH-OUT
           MOVE WS-DAY TO DAY-OUT
           MOVE WS-YEAR TO YEAR-OUT
           ADD 1 TO PAGE-NO
           WRITE PRINT-REC FROM HDR-1
           WRITE PRINT-REC FROM HDR-2
           PERFORM UNTIL ARE-THERE-MORE-RECORDS = 'NO'
               READ EMPLOYEE-DATA
                    AT END
                         MOVE 'NO'  TO ARE-THERE-MORE-RECORDS
                    NOT AT END
                         PERFORM 300-WAGE-ROUTINE
               END-READ
           END-PERFORM
           CLOSE EMPLOYEE-DATA
                 PAYROLL-LISTING
                 STOP RUN.
       300-WAGE-ROUTINE.
           MOVE SPACES TO PRINT-REC
           MOVE SSNO-IN TO SSNO-OUT
           MOVE STUDENT-NAME-IN TO STUDENT-NAME-OUT
           MULTIPLY GPA-IN BY .01 GIVING GPA-OUT
           MOVE CREDITS-IN TO CREDITS-OUT
           EVALUATE CLASS-IN
                   WHEN 1
                           MOVE 'FRESHMAN' TO CLASS-OUT
                   WHEN 2
                           MOVE 'SOPHOMORE' TO CLASS-OUT
                   WHEN 3
                           MOVE 'JUNIOR' TO CLASS-OUT
                   WHEN 4
                           MOVE 'SENIOR' TO CLASS-OUT
           END-EVALUATE.
            EVALUATE SCHOOL-IN
                   WHEN 1
                           MOVE 'BUSINESS' TO SCHOOL-OUT
                   WHEN 2
                           MOVE 'LIBERAL ARTS' TO SCHOOL-OUT
                   WHEN 3
                           MOVE 'ENGINEERING' TO SCHOOL-OUT
           END-EVALUATE.

           WRITE PRINT-REC.




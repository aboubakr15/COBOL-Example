       IDENTIFICATION DIVISION.
       PROGRAM-ID. File-READER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO "input.dat"
               ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD INPUT-FILE.
       01 FILE-RECORD.
           02 EMP-ID           PIC 9(5).
           02 EMP-NAME         PIC X(20).
           02 EMP-SALARY       PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 VARIABLES.
           02 START-LINE     PIC 9(5).
           02 END-LINE       PIC 9(5).
           02 CURRENT-LINE   PIC 9(5) VALUE 0.
           02 EOF            PIC X VALUE 'N'.
               88 END-OF-FILE   VALUE 'Y'.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM GET-LINE-RANGE.

           OPEN INPUT INPUT-FILE.

           PERFORM READ-AND-PRINT-LINES.

           CLOSE INPUT-FILE.

           STOP RUN.


       GET-LINE-RANGE.
           DISPLAY "Please enter the starting line number: ".
           ACCEPT START-LINE.

           DISPLAY "Please nter the ending line number: ".
           ACCEPT END-LINE.

           IF START-LINE > END-LINE
               DISPLAY "ERROR: Starting line must be <= ending line."
               GO TO GET-LINE-RANGE.

           COMPUTE CURRENT-LINE = START-LINE - 1.
           


       READ-AND-PRINT-LINES.
           PERFORM UNTIL END-OF-FILE
               READ INPUT-FILE
                   AT END
                       MOVE 'Y' TO EOF
                   NOT AT END
                       PERFORM PRINT-LINE
               END-READ
           END-PERFORM.


       PRINT-LINE.
           ADD 1 TO CURRENT-LINE

           IF CURRENT-LINE >= START-LINE AND 
              CURRENT-LINE <= END-LINE
               DISPLAY "Line " CURRENT-LINE ": "
                       EMP-ID " " EMP-NAME " " EMP-SALARY
           END-IF.

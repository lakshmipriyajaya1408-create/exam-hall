Imports System
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient
Imports System.Web.UI.WebControls

Partial Class Admin_AllocateHalls
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Session("Role").ToString() <> "Admin" Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then

            LoadExams()

            lblStudentCount.Text = "0"
            lblHallCount.Text = "0"
            lblCapacity.Text = "0"

        End If

    End Sub


    ' ==========================================
    ' LOAD EXAMINATIONS
    ' ==========================================

    Private Sub LoadExams()

        Try

            Dim query As String =
                "SELECT ExamID, ExamName, Subject, Department, `Year`, ExamDate " &
                "FROM Exams " &
                "ORDER BY ExamDate ASC, StartTime ASC"

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)

            ddlExam.Items.Clear()

            ddlExam.Items.Add(
                New ListItem("-- Select Examination --", "")
            )

            For Each row As DataRow In dt.Rows

                Dim examText As String =
                    row("ExamName").ToString() &
                    " - " &
                    row("Subject").ToString() &
                    " (" &
                    row("Department").ToString() &
                    ", Year " &
                    row("Year").ToString() &
                    ")"

                ddlExam.Items.Add(
                    New ListItem(
                        examText,
                        row("ExamID").ToString()
                    )
                )

            Next

        Catch ex As Exception

            ShowMessage(
                "Error loading examinations: " &
                ex.Message,
                False
            )

        End Try

    End Sub


    ' ==========================================
    ' EXAMINATION SELECTION
    ' ==========================================

    Protected Sub ddlExam_SelectedIndexChanged(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles ddlExam.SelectedIndexChanged

        LoadAllocationInformation()

    End Sub


    ' ==========================================
    ' LOAD STUDENT AND HALL INFORMATION
    ' ==========================================

    Private Sub LoadAllocationInformation()

        Try

            lblStudentCount.Text = "0"
            lblHallCount.Text = "0"
            lblCapacity.Text = "0"

            If ddlExam.SelectedValue = "" Then
                Return
            End If


            Dim examID As Integer =
                Convert.ToInt32(ddlExam.SelectedValue)


            ' ------------------------------------------
            ' GET EXAM DEPARTMENT AND YEAR
            ' ------------------------------------------

            Dim examQuery As String =
                "SELECT Department, `Year` " &
                "FROM Exams " &
                "WHERE ExamID = @ExamID"

            Dim examParameters As New List(Of MySqlParameter)

            examParameters.Add(
                New MySqlParameter("@ExamID", examID)
            )

            Dim examTable As DataTable =
                DatabaseHelper.GetDataTable(
                    examQuery,
                    examParameters
                )

            If examTable.Rows.Count = 0 Then
                Return
            End If


            Dim department As String =
                examTable.Rows(0)("Department").ToString()

            Dim year As Integer =
                Convert.ToInt32(examTable.Rows(0)("Year"))


            ' ------------------------------------------
            ' COUNT ACTIVE STUDENTS
            ' ------------------------------------------

            Dim studentQuery As String =
                "SELECT COUNT(*) " &
                "FROM Students " &
                "WHERE Department = @Department " &
                "AND `Year` = @Year " &
                "AND Status = 'Active'"

            Dim studentParameters As New List(Of MySqlParameter)

            studentParameters.Add(
                New MySqlParameter(
                    "@Department",
                    department
                )
            )

            studentParameters.Add(
                New MySqlParameter(
                    "@Year",
                    year
                )
            )

            Dim studentCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        studentQuery,
                        studentParameters
                    )
                )


            ' ------------------------------------------
            ' AVAILABLE HALL COUNT
            ' ------------------------------------------

            Dim hallCountQuery As String =
                "SELECT COUNT(*) " &
                "FROM Halls " &
                "WHERE Status = 'Available'"

            Dim hallCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        hallCountQuery
                    )
                )


            ' ------------------------------------------
            ' TOTAL AVAILABLE CAPACITY
            ' ------------------------------------------

            Dim capacityQuery As String =
                "SELECT IFNULL(SUM(Capacity), 0) " &
                "FROM Halls " &
                "WHERE Status = 'Available'"

            Dim totalCapacity As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        capacityQuery
                    )
                )


            lblStudentCount.Text =
                studentCount.ToString()

            lblHallCount.Text =
                hallCount.ToString()

            lblCapacity.Text =
                totalCapacity.ToString()


        Catch ex As Exception

            ShowMessage(
                "Error loading allocation information: " &
                ex.Message,
                False
            )

        End Try

    End Sub


    ' ==========================================
    ' ALLOCATE HALLS
    ' ==========================================

    Protected Sub btnAllocate_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnAllocate.Click

        Try

            If ddlExam.SelectedValue = "" Then

                ShowMessage(
                    "Please select an examination.",
                    False
                )

                Return

            End If


            Dim examID As Integer =
                Convert.ToInt32(ddlExam.SelectedValue)


            ' ------------------------------------------
            ' CHECK WHETHER ALLOCATION ALREADY EXISTS
            ' ------------------------------------------

            Dim existingQuery As String =
                "SELECT COUNT(*) " &
                "FROM Allocations " &
                "WHERE ExamID = @ExamID " &
                "AND Status = 'Active'"

            Dim existingParameters As New List(Of MySqlParameter)

            existingParameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )

            Dim existingCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        existingQuery,
                        existingParameters
                    )
                )


            If existingCount > 0 Then

                ShowMessage(
                    "Halls have already been allocated for this examination.",
                    False
                )

                Return

            End If


            ' ------------------------------------------
            ' GET EXAM DETAILS
            ' ------------------------------------------

            Dim examQuery As String =
                "SELECT Department, `Year` " &
                "FROM Exams " &
                "WHERE ExamID = @ExamID"

            Dim examParameters As New List(Of MySqlParameter)

            examParameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )

            Dim examTable As DataTable =
                DatabaseHelper.GetDataTable(
                    examQuery,
                    examParameters
                )


            If examTable.Rows.Count = 0 Then

                ShowMessage(
                    "Selected examination was not found.",
                    False
                )

                Return

            End If


            Dim department As String =
                examTable.Rows(0)("Department").ToString()

            Dim year As Integer =
                Convert.ToInt32(
                    examTable.Rows(0)("Year")
                )


            ' ------------------------------------------
            ' GET STUDENTS
            ' ------------------------------------------

            Dim studentQuery As String =
                "SELECT StudentID " &
                "FROM Students " &
                "WHERE Department = @Department " &
                "AND `Year` = @Year " &
                "AND Status = 'Active' " &
                "ORDER BY StudentID ASC"

            Dim studentParameters As New List(Of MySqlParameter)

            studentParameters.Add(
                New MySqlParameter(
                    "@Department",
                    department
                )
            )

            studentParameters.Add(
                New MySqlParameter(
                    "@Year",
                    year
                )
            )

            Dim students As DataTable =
                DatabaseHelper.GetDataTable(
                    studentQuery,
                    studentParameters
                )


            If students.Rows.Count = 0 Then

                ShowMessage(
                    "No active students were found for this examination's department and year.",
                    False
                )

                Return

            End If


            ' ------------------------------------------
            ' GET AVAILABLE HALLS
            ' ------------------------------------------

            Dim hallQuery As String =
                "SELECT HallID, HallName, Capacity " &
                "FROM Halls " &
                "WHERE Status = 'Available' " &
                "ORDER BY HallID ASC"

            Dim halls As DataTable =
                DatabaseHelper.GetDataTable(
                    hallQuery
                )


            If halls.Rows.Count = 0 Then

                ShowMessage(
                    "No available halls were found.",
                    False
                )

                Return

            End If


            ' ------------------------------------------
            ' CALCULATE TOTAL CAPACITY
            ' ------------------------------------------

            Dim totalCapacity As Integer = 0

            For Each hallRow As DataRow In halls.Rows

                totalCapacity +=
                    Convert.ToInt32(
                        hallRow("Capacity")
                    )

            Next


            If totalCapacity < students.Rows.Count Then

                ShowMessage(
                    "Insufficient hall capacity. Students: " &
                    students.Rows.Count.ToString() &
                    ", Available capacity: " &
                    totalCapacity.ToString(),
                    False
                )

                Return

            End If


            ' ------------------------------------------
            ' DATABASE TRANSACTION
            ' ------------------------------------------

            Using connection As MySqlConnection =
                DatabaseHelper.GetConnection()

                connection.Open()

                Dim transaction As MySqlTransaction =
                    connection.BeginTransaction()

                Try

                    Dim studentIndex As Integer = 0


                    For Each hallRow As DataRow In halls.Rows

                        If studentIndex >= students.Rows.Count Then
                            Exit For
                        End If


                        Dim hallID As Integer =
                            Convert.ToInt32(
                                hallRow("HallID")
                            )

                        Dim hallCapacity As Integer =
                            Convert.ToInt32(
                                hallRow("Capacity")
                            )

                        Dim seatNumber As Integer = 1


                        While seatNumber <= hallCapacity _
                            AndAlso studentIndex < students.Rows.Count


                            Dim studentID As Integer =
                                Convert.ToInt32(
                                    students.Rows(studentIndex)(
                                        "StudentID"
                                    )
                                )


                            Dim insertQuery As String =
                                "INSERT INTO Allocations " &
                                "(ExamID, StudentID, HallID, SeatNumber, Status) " &
                                "VALUES " &
                                "(@ExamID, @StudentID, @HallID, @SeatNumber, 'Active')"


                            Using command As New MySqlCommand(
                                insertQuery,
                                connection,
                                transaction
                            )

                                command.Parameters.AddWithValue(
                                    "@ExamID",
                                    examID
                                )

                                command.Parameters.AddWithValue(
                                    "@StudentID",
                                    studentID
                                )

                                command.Parameters.AddWithValue(
                                    "@HallID",
                                    hallID
                                )

                                command.Parameters.AddWithValue(
                                    "@SeatNumber",
                                    seatNumber.ToString()
                                )

                                command.ExecuteNonQuery()

                            End Using


                            studentIndex += 1
                            seatNumber += 1

                        End While

                    Next


                    transaction.Commit()


                    ShowMessage(
                        students.Rows.Count.ToString() &
                        " students allocated successfully across available examination halls.",
                        True
                    )


                    LoadAllocationInformation()


                Catch ex As Exception

                    transaction.Rollback()

                    Throw

                End Try

            End Using


        Catch ex As Exception

            ShowMessage(
                "Error allocating halls: " &
                ex.Message,
                False
            )

        End Try

    End Sub


    ' ==========================================
    ' DISPLAY MESSAGE
    ' ==========================================

    Private Sub ShowMessage(
        ByVal message As String,
        ByVal success As Boolean
    )

        lblMessage.Text = message
        lblMessage.Visible = True

        If success Then

            lblMessage.CssClass =
                "message success-message"

        Else

            lblMessage.CssClass =
                "message danger-message"

        End If

    End Sub

End Class
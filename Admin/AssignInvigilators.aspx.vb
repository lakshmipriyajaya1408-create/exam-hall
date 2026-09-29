
Imports System
Imports System.Data
Imports System.Collections.Generic
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class Admin_AssignInvigilators

    Inherits System.Web.UI.Page


    '==========================================================
    ' PAGE LOAD
    '==========================================================

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        'Check login
        If Session("UserID") Is Nothing OrElse
           Session("Role") Is Nothing Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        'Only Admin can access this page
        If Session("Role").ToString() <> "Admin" Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        If Not IsPostBack Then

            LoadExams()
            LoadHalls()
            LoadInvigilators()
            LoadAssignments()
            LoadStatistics()

        End If

    End Sub


    '==========================================================
    ' LOAD EXAMS
    '==========================================================

    Private Sub LoadExams()

        Try

            Dim query As String =
                "SELECT ExamID, ExamName, Subject, Department, `Year` " &
                "FROM Exams " &
                "ORDER BY ExamDate ASC, StartTime ASC"


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)


            ddlExam.Items.Clear()


            ddlExam.Items.Add(
                New ListItem(
                    "-- Select Examination --",
                    ""
                )
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
                "Error loading examinations: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' LOAD HALLS
    '==========================================================

    Private Sub LoadHalls()

        Try

            Dim query As String =
                "SELECT HallID, HallName, Building, Floor, Capacity " &
                "FROM Halls " &
                "WHERE Status = 'Available' " &
                "ORDER BY HallName ASC"


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)


            ddlHall.Items.Clear()


            ddlHall.Items.Add(
                New ListItem(
                    "-- Select Hall --",
                    ""
                )
            )


            For Each row As DataRow In dt.Rows

                Dim hallText As String =
                    row("HallName").ToString() &
                    " - Capacity " &
                    row("Capacity").ToString()


                ddlHall.Items.Add(
                    New ListItem(
                        hallText,
                        row("HallID").ToString()
                    )
                )

            Next


        Catch ex As Exception

            ShowMessage(
                "Error loading halls: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' LOAD INVIGILATORS
    '==========================================================

    Private Sub LoadInvigilators()

        Try

            Dim query As String =
                "SELECT " &
                "i.InvigilatorID, " &
                "u.Name, " &
                "u.Email, " &
                "i.Department " &
                "FROM Invigilators i " &
                "INNER JOIN Users u " &
                "ON i.UserID = u.UserID " &
                "WHERE i.Availability = 'Available' " &
                "AND i.Status = 'Active' " &
                "AND u.Status = 'Active' " &
                "ORDER BY u.Name ASC"


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)


            ddlInvigilator.Items.Clear()


            ddlInvigilator.Items.Add(
                New ListItem(
                    "-- Select Invigilator --",
                    ""
                )
            )


            For Each row As DataRow In dt.Rows

                Dim invigilatorText As String =
                    row("Name").ToString() &
                    " - " &
                    row("Department").ToString() &
                    " (" &
                    row("Email").ToString() &
                    ")"


                ddlInvigilator.Items.Add(
                    New ListItem(
                        invigilatorText,
                        row("InvigilatorID").ToString()
                    )
                )

            Next


        Catch ex As Exception

            ShowMessage(
                "Error loading invigilators: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' ASSIGN INVIGILATOR
    '==========================================================

    Protected Sub btnAssign_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnAssign.Click

        lblMessage.Visible = False


        Try

            'Validate exam
            If ddlExam.SelectedValue = "" Then

                ShowMessage(
                    "Please select an examination.",
                    False
                )

                Return

            End If


            'Validate hall
            If ddlHall.SelectedValue = "" Then

                ShowMessage(
                    "Please select an examination hall.",
                    False
                )

                Return

            End If


            'Validate invigilator
            If ddlInvigilator.SelectedValue = "" Then

                ShowMessage(
                    "Please select an invigilator.",
                    False
                )

                Return

            End If


            Dim examID As Integer =
                Convert.ToInt32(
                    ddlExam.SelectedValue
                )


            Dim hallID As Integer =
                Convert.ToInt32(
                    ddlHall.SelectedValue
                )


            Dim invigilatorID As Integer =
                Convert.ToInt32(
                    ddlInvigilator.SelectedValue
                )


            '==================================================
            ' CHECK 1
            ' Same hall cannot have two invigilators
            ' for the same examination.
            '==================================================

            Dim hallDuplicateQuery As String =
                "SELECT COUNT(*) " &
                "FROM ExamInvigilators " &
                "WHERE ExamID = @ExamID " &
                "AND HallID = @HallID " &
                "AND Status = 'Assigned'"


            Dim hallParameters As New List(Of MySqlParameter)


            hallParameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )


            hallParameters.Add(
                New MySqlParameter(
                    "@HallID",
                    hallID
                )
            )


            Dim hallDuplicateCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        hallDuplicateQuery,
                        hallParameters
                    )
                )


            If hallDuplicateCount > 0 Then

                ShowMessage(
                    "An invigilator is already assigned to this hall for the selected examination.",
                    False
                )

                Return

            End If


            '==================================================
            ' CHECK 2
            ' Same invigilator cannot be assigned twice
            ' to the same examination.
            '==================================================

            Dim invigilatorDuplicateQuery As String =
                "SELECT COUNT(*) " &
                "FROM ExamInvigilators " &
                "WHERE ExamID = @ExamID " &
                "AND InvigilatorID = @InvigilatorID " &
                "AND Status = 'Assigned'"


            Dim invigilatorParameters As New List(Of MySqlParameter)


            invigilatorParameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )


            invigilatorParameters.Add(
                New MySqlParameter(
                    "@InvigilatorID",
                    invigilatorID
                )
            )


            Dim invigilatorDuplicateCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        invigilatorDuplicateQuery,
                        invigilatorParameters
                    )
                )


            If invigilatorDuplicateCount > 0 Then

                ShowMessage(
                    "This invigilator is already assigned to the selected examination.",
                    False
                )

                Return

            End If


            '==================================================
            ' INSERT ASSIGNMENT
            '==================================================

            Dim insertQuery As String =
                "INSERT INTO ExamInvigilators " &
                "(ExamID, HallID, InvigilatorID, Status) " &
                "VALUES " &
                "(@ExamID, @HallID, @InvigilatorID, @Status)"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )


            parameters.Add(
                New MySqlParameter(
                    "@HallID",
                    hallID
                )
            )


            parameters.Add(
                New MySqlParameter(
                    "@InvigilatorID",
                    invigilatorID
                )
            )


            parameters.Add(
                New MySqlParameter(
                    "@Status",
                    ddlStatus.SelectedValue
                )
            )


            DatabaseHelper.ExecuteNonQuery(
                insertQuery,
                parameters
            )


            ShowMessage(
                "Invigilator assigned successfully.",
                True
            )


            LoadAssignments()
            LoadStatistics()


            'Reset selection
            ddlExam.SelectedIndex = 0
            ddlHall.SelectedIndex = 0
            ddlInvigilator.SelectedIndex = 0


        Catch ex As Exception

            ShowMessage(
                "Error assigning invigilator: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' LOAD ASSIGNMENTS
    '==========================================================

    Private Sub LoadAssignments()

        Try

            Dim query As String =
                "SELECT " &
                "a.AssignmentID, " &
                "e.ExamName, " &
                "e.Subject, " &
                "h.HallName, " &
                "u.Name AS InvigilatorName, " &
                "u.Email, " &
                "i.Department, " &
                "a.AssignmentDate, " &
                "a.Status " &
                "FROM ExamInvigilators a " &
                "INNER JOIN Exams e " &
                "ON a.ExamID = e.ExamID " &
                "INNER JOIN Halls h " &
                "ON a.HallID = h.HallID " &
                "INNER JOIN Invigilators i " &
                "ON a.InvigilatorID = i.InvigilatorID " &
                "INNER JOIN Users u " &
                "ON i.UserID = u.UserID " &
                "ORDER BY a.AssignmentID DESC"


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)


            gvAssignments.DataSource = dt
            gvAssignments.DataBind()


        Catch ex As Exception

            ShowMessage(
                "Error loading assignments: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' LOAD STATISTICS
    '==========================================================

    Private Sub LoadStatistics()

        Try

            Dim totalQuery As String =
                "SELECT COUNT(*) FROM ExamInvigilators"


            Dim assignedQuery As String =
                "SELECT COUNT(*) " &
                "FROM ExamInvigilators " &
                "WHERE Status = 'Assigned'"


            Dim hallsQuery As String =
                "SELECT COUNT(DISTINCT HallID) " &
                "FROM ExamInvigilators " &
                "WHERE Status = 'Assigned'"


            Dim total As Object =
                DatabaseHelper.ExecuteScalar(
                    totalQuery
                )


            Dim assigned As Object =
                DatabaseHelper.ExecuteScalar(
                    assignedQuery
                )


            Dim halls As Object =
                DatabaseHelper.ExecuteScalar(
                    hallsQuery
                )


            lblTotalAssignments.Text =
                Convert.ToString(total)


            lblAssigned.Text =
                Convert.ToString(assigned)


            lblHallsCovered.Text =
                Convert.ToString(halls)


        Catch ex As Exception

            ShowMessage(
                "Error loading statistics: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' DELETE ASSIGNMENT
    '==========================================================

    Protected Sub gvAssignments_RowCommand(
        ByVal sender As Object,
        ByVal e As GridViewCommandEventArgs
    ) Handles gvAssignments.RowCommand


        Try

            If e.CommandName = "DeleteAssignment" Then

                Dim assignmentID As Integer =
                    Convert.ToInt32(
                        e.CommandArgument
                    )


                DeleteAssignment(
                    assignmentID
                )

            End If


        Catch ex As Exception

            ShowMessage(
                "Error: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' DELETE FROM DATABASE
    '==========================================================

    Private Sub DeleteAssignment(
        ByVal assignmentID As Integer
    )

        Try

            Dim query As String =
                "DELETE FROM ExamInvigilators " &
                "WHERE AssignmentID = @AssignmentID"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@AssignmentID",
                    assignmentID
                )
            )


            DatabaseHelper.ExecuteNonQuery(
                query,
                parameters
            )


            ShowMessage(
                "Invigilator assignment deleted successfully.",
                True
            )


            LoadAssignments()
            LoadStatistics()


        Catch ex As Exception

            ShowMessage(
                "Error deleting assignment: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' BACK BUTTON
    '==========================================================

    Protected Sub btnBack_Click(ByVal sender As Object,
                                ByVal e As System.EventArgs) _
                                Handles btnBack.Click

        Response.Redirect(
            "ViewAllocations.aspx"
        )

    End Sub


    '==========================================================
    ' MESSAGE
    '==========================================================

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

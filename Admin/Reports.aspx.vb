
Imports System
Imports System.Data
Imports System.Collections.Generic
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class Admin_Reports

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


        'Only Admin
        If Session("Role").ToString() <> "Admin" Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        If Not IsPostBack Then

            LoadExams()
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
                "ORDER BY ExamDate DESC, StartTime DESC"


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
    ' LOAD STATISTICS
    '==========================================================

    Private Sub LoadStatistics()

        Try

            Dim studentsQuery As String =
                "SELECT COUNT(*) FROM Students"


            Dim examsQuery As String =
                "SELECT COUNT(*) FROM Exams"


            Dim hallsQuery As String =
                "SELECT COUNT(*) FROM Halls"


            Dim allocationsQuery As String =
                "SELECT COUNT(*) FROM Allocations"


            Dim assignmentsQuery As String =
                "SELECT COUNT(*) FROM ExamInvigilators"


            lblStudents.Text =
                Convert.ToString(
                    DatabaseHelper.ExecuteScalar(
                        studentsQuery
                    )
                )


            lblExams.Text =
                Convert.ToString(
                    DatabaseHelper.ExecuteScalar(
                        examsQuery
                    )
                )


            lblHalls.Text =
                Convert.ToString(
                    DatabaseHelper.ExecuteScalar(
                        hallsQuery
                    )
                )


            lblAllocations.Text =
                Convert.ToString(
                    DatabaseHelper.ExecuteScalar(
                        allocationsQuery
                    )
                )


            lblAssignments.Text =
                Convert.ToString(
                    DatabaseHelper.ExecuteScalar(
                        assignmentsQuery
                    )
                )


        Catch ex As Exception

            ShowMessage(
                "Error loading statistics: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' GENERATE REPORT
    '==========================================================

    Protected Sub btnGenerate_Click(ByVal sender As Object,
                                    ByVal e As System.EventArgs) _
                                    Handles btnGenerate.Click

        lblMessage.Visible = False


        Try

            If ddlExam.SelectedValue = "" Then

                ShowMessage(
                    "Please select an examination.",
                    False
                )

                Return

            End If


            Dim examID As Integer =
                Convert.ToInt32(
                    ddlExam.SelectedValue
                )


            LoadAllocationReport(examID)

            LoadInvigilatorReport(examID)


            ShowMessage(
                "Report generated successfully.",
                True
            )


        Catch ex As Exception

            ShowMessage(
                "Error generating report: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' ALLOCATION REPORT
    '==========================================================

    Private Sub LoadAllocationReport(
        ByVal examID As Integer
    )

        Try

            Dim query As String =
                "SELECT " &
                "e.ExamName, " &
                "e.Subject, " &
                "u.Name AS StudentName, " &
                "s.RegisterNumber, " &
                "s.Department, " &
                "s.`Year`, " &
                "h.HallName, " &
                "a.SeatNumber, " &
                "COALESCE(iu.Name, 'Not Assigned') AS InvigilatorName, " &
                "a.Status " &
                "FROM Allocations a " &
                "INNER JOIN Exams e " &
                "ON a.ExamID = e.ExamID " &
                "INNER JOIN Students s " &
                "ON a.StudentID = s.StudentID " &
                "INNER JOIN Users u " &
                "ON s.UserID = u.UserID " &
                "INNER JOIN Halls h " &
                "ON a.HallID = h.HallID " &
                "LEFT JOIN ExamInvigilators ei " &
                "ON a.ExamID = ei.ExamID " &
                "AND a.HallID = ei.HallID " &
                "AND ei.Status = 'Assigned' " &
                "LEFT JOIN Invigilators i " &
                "ON ei.InvigilatorID = i.InvigilatorID " &
                "LEFT JOIN Users iu " &
                "ON i.UserID = iu.UserID " &
                "WHERE a.ExamID = @ExamID " &
                "ORDER BY h.HallName ASC, a.SeatNumber ASC"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            gvReport.DataSource = dt
            gvReport.DataBind()


        Catch ex As Exception

            ShowMessage(
                "Error loading allocation report: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' INVIGILATOR REPORT
    '==========================================================

    Private Sub LoadInvigilatorReport(
        ByVal examID As Integer
    )

        Try

            Dim query As String =
                "SELECT " &
                "e.ExamName, " &
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
                "WHERE a.ExamID = @ExamID " &
                "ORDER BY h.HallName ASC"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            gvInvigilators.DataSource = dt
            gvInvigilators.DataBind()


        Catch ex As Exception

            ShowMessage(
                "Error loading invigilator report: " & ex.Message,
                False
            )

        End Try

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

Imports System
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Partial Class Student_StudentDashboard

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


        'Only Student can access this page
        If Session("Role").ToString() <> "Student" Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        If Not IsPostBack Then

            LoadStudentInformation()
            LoadUpcomingExams()
            LoadAllocationCount()
            LoadLatestAllocation()

        End If

    End Sub


    '==========================================================
    ' LOAD STUDENT INFORMATION
    '==========================================================

    Private Sub LoadStudentInformation()

        Try

            Dim userID As Integer =
                Convert.ToInt32(Session("UserID"))


            Dim query As String =
                "SELECT " &
                "u.Name, " &
                "u.Email, " &
                "u.Phone, " &
                "s.RegisterNumber, " &
                "s.Department, " &
                "s.`Year`, " &
                "s.Section, " &
                "s.Status " &
                "FROM Students s " &
                "INNER JOIN Users u " &
                "ON s.UserID = u.UserID " &
                "WHERE s.UserID = @UserID"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@UserID",
                    userID
                )
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            If dt.Rows.Count = 0 Then

                Response.Redirect("~/Account/Login.aspx")
                Return

            End If


            Dim row As DataRow = dt.Rows(0)


            lblStudentName.Text =
                row("Name").ToString()


            lblName.Text =
                row("Name").ToString()


            lblRegisterNumber.Text =
                row("RegisterNumber").ToString()


            lblDepartment.Text =
                row("Department").ToString()


            lblStudentDepartment.Text =
                row("Department").ToString()


            lblYear.Text =
                row("Year").ToString()


            lblSection.Text =
                row("Section").ToString()


            lblStatus.Text =
                row("Status").ToString()


        Catch ex As Exception

            'Do not expose database error to student

            lblStudentName.Text = "Student"
            lblName.Text = "Unable to load information"

        End Try

    End Sub


    '==========================================================
    ' LOAD UPCOMING EXAMS
    '==========================================================

    Private Sub LoadUpcomingExams()

        Try

            Dim userID As Integer =
                Convert.ToInt32(Session("UserID"))


            Dim query As String =
                "SELECT COUNT(*) " &
                "FROM Exams e " &
                "INNER JOIN Students s " &
                "ON e.Department = s.Department " &
                "AND e.`Year` = s.`Year` " &
                "WHERE s.UserID = @UserID " &
                "AND e.ExamDate >= CURDATE() " &
                "AND e.Status <> 'Cancelled'"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@UserID",
                    userID
                )
            )


            Dim count As Object =
                DatabaseHelper.ExecuteScalar(
                    query,
                    parameters
                )


            lblUpcomingExams.Text =
                Convert.ToString(count)


        Catch ex As Exception

            lblUpcomingExams.Text = "0"

        End Try

    End Sub


    '==========================================================
    ' LOAD ALLOCATION COUNT
    '==========================================================

    Private Sub LoadAllocationCount()

        Try

            Dim userID As Integer =
                Convert.ToInt32(Session("UserID"))


            Dim query As String =
                "SELECT COUNT(*) " &
                "FROM Allocations a " &
                "INNER JOIN Students s " &
                "ON a.StudentID = s.StudentID " &
                "WHERE s.UserID = @UserID " &
                "AND a.Status = 'Active'"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@UserID",
                    userID
                )
            )


            Dim count As Object =
                DatabaseHelper.ExecuteScalar(
                    query,
                    parameters
                )


            lblAllocationCount.Text =
                Convert.ToString(count)


        Catch ex As Exception

            lblAllocationCount.Text = "0"

        End Try

    End Sub


    '==========================================================
    ' LOAD LATEST ALLOCATION
    '==========================================================

    Private Sub LoadLatestAllocation()

        Try

            Dim userID As Integer =
                Convert.ToInt32(Session("UserID"))


            Dim query As String =
                "SELECT " &
                "e.ExamName, " &
                "e.Subject, " &
                "e.ExamDate, " &
                "e.StartTime, " &
                "e.EndTime, " &
                "h.HallName, " &
                "h.Building, " &
                "h.Floor, " &
                "a.SeatNumber " &
                "FROM Allocations a " &
                "INNER JOIN Students s " &
                "ON a.StudentID = s.StudentID " &
                "INNER JOIN Exams e " &
                "ON a.ExamID = e.ExamID " &
                "INNER JOIN Halls h " &
                "ON a.HallID = h.HallID " &
                "WHERE s.UserID = @UserID " &
                "AND a.Status = 'Active' " &
                "ORDER BY a.AllocationID DESC " &
                "LIMIT 1"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@UserID",
                    userID
                )
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            If dt.Rows.Count = 0 Then

                pnlAllocation.Visible = False
                lblNoAllocation.Visible = True

                Return

            End If


            Dim row As DataRow =
                dt.Rows(0)


            pnlAllocation.Visible = True
            lblNoAllocation.Visible = False


            lblAllocationExam.Text =
                row("ExamName").ToString()


            lblAllocationSubject.Text =
                row("Subject").ToString()


            lblAllocationDate.Text =
                Convert.ToDateTime(
                    row("ExamDate")
                ).ToString("dd-MM-yyyy")


            lblAllocationTime.Text =
                Convert.ToString(
                    row("StartTime")
                ) &
                " - " &
                Convert.ToString(
                    row("EndTime")
                )


            lblHallName.Text =
                row("HallName").ToString()


            lblBuilding.Text =
                If(
                    row("Building") Is DBNull.Value,
                    "-",
                    row("Building").ToString()
                )


            lblFloor.Text =
                If(
                    row("Floor") Is DBNull.Value,
                    "-",
                    row("Floor").ToString()
                )


            lblSeatNumber.Text =
                row("SeatNumber").ToString()


        Catch ex As Exception

            pnlAllocation.Visible = False
            lblNoAllocation.Visible = True

        End Try

    End Sub

End Class

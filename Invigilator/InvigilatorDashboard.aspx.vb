Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Invigilator_InvigilatorDashboard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Check login
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        ' Only invigilators can access this page
        If Session("Role").ToString() <> "Invigilator" Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then

            LoadInvigilatorInformation()
            LoadStatistics()
            LoadUpcomingDuties()

        End If

    End Sub


    '====================================================
    ' LOAD INVIGILATOR INFORMATION
    '====================================================

    Private Sub LoadInvigilatorInformation()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            Dim query As String = ""

            query &= "SELECT "
            query &= "u.Name AS Name, "
            query &= "u.Email AS Email, "
            query &= "i.Department AS Department, "
            query &= "i.Availability AS Availability "
            query &= "FROM Users u "
            query &= "INNER JOIN Invigilators i ON u.UserID = i.UserID "
            query &= "WHERE u.UserID = @UserID"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@UserID", userID))

            Dim dt As DataTable = DatabaseHelper.GetDataTable(query, parameters)

            If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then

                Dim row As DataRow = dt.Rows(0)

                lblName.Text = Convert.ToString(row("Name"))
                lblInvigilatorName.Text = Convert.ToString(row("Name"))
                lblEmail.Text = Convert.ToString(row("Email"))
                lblDepartment.Text = Convert.ToString(row("Department"))
                lblAvailability.Text = Convert.ToString(row("Availability"))

            End If

        Catch ex As Exception

            lblName.Text = "-"
            lblInvigilatorName.Text = "Invigilator"
            lblEmail.Text = "-"
            lblDepartment.Text = "-"
            lblAvailability.Text = "-"

        End Try

    End Sub


    '====================================================
    ' LOAD DASHBOARD STATISTICS
    '====================================================

    Private Sub LoadStatistics()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            '---------------------------------------------
            ' Assigned Exams
            '---------------------------------------------

            Dim examQuery As String = ""

            examQuery &= "SELECT COUNT(DISTINCT ei.ExamID) "
            examQuery &= "FROM ExamInvigilators ei "
            examQuery &= "INNER JOIN Invigilators i "
            examQuery &= "ON ei.InvigilatorID = i.InvigilatorID "
            examQuery &= "WHERE i.UserID = @UserID "
            examQuery &= "AND ei.Status = 'Assigned'"

            Dim examParameters As New List(Of MySqlParameter)

            examParameters.Add(New MySqlParameter("@UserID", userID))

            Dim examCount As Object =
                DatabaseHelper.ExecuteScalar(examQuery, examParameters)

            If examCount IsNot Nothing AndAlso Not IsDBNull(examCount) Then
                lblAssignedExams.Text = Convert.ToString(examCount)
            Else
                lblAssignedExams.Text = "0"
            End If


            '---------------------------------------------
            ' Assigned Halls
            '---------------------------------------------

            Dim hallQuery As String = ""

            hallQuery &= "SELECT COUNT(DISTINCT ei.HallID) "
            hallQuery &= "FROM ExamInvigilators ei "
            hallQuery &= "INNER JOIN Invigilators i "
            hallQuery &= "ON ei.InvigilatorID = i.InvigilatorID "
            hallQuery &= "WHERE i.UserID = @UserID "
            hallQuery &= "AND ei.Status = 'Assigned'"

            Dim hallParameters As New List(Of MySqlParameter)

            hallParameters.Add(New MySqlParameter("@UserID", userID))

            Dim hallCount As Object =
                DatabaseHelper.ExecuteScalar(hallQuery, hallParameters)

            If hallCount IsNot Nothing AndAlso Not IsDBNull(hallCount) Then
                lblAssignedHalls.Text = Convert.ToString(hallCount)
            Else
                lblAssignedHalls.Text = "0"
            End If


            '---------------------------------------------
            ' Students in Assigned Halls
            '---------------------------------------------

            Dim studentQuery As String = ""

            studentQuery &= "SELECT COUNT(DISTINCT a.StudentID) "
            studentQuery &= "FROM Allocations a "
            studentQuery &= "INNER JOIN ExamInvigilators ei "
            studentQuery &= "ON a.ExamID = ei.ExamID "
            studentQuery &= "AND a.HallID = ei.HallID "
            studentQuery &= "INNER JOIN Invigilators i "
            studentQuery &= "ON ei.InvigilatorID = i.InvigilatorID "
            studentQuery &= "WHERE i.UserID = @UserID "
            studentQuery &= "AND ei.Status = 'Assigned' "
            studentQuery &= "AND a.Status = 'Active'"

            Dim studentParameters As New List(Of MySqlParameter)

            studentParameters.Add(New MySqlParameter("@UserID", userID))

            Dim studentCount As Object =
                DatabaseHelper.ExecuteScalar(studentQuery, studentParameters)

            If studentCount IsNot Nothing AndAlso Not IsDBNull(studentCount) Then
                lblStudentCount.Text = Convert.ToString(studentCount)
            Else
                lblStudentCount.Text = "0"
            End If

        Catch ex As Exception

            lblAssignedExams.Text = "0"
            lblAssignedHalls.Text = "0"
            lblStudentCount.Text = "0"

        End Try

    End Sub


    '====================================================
    ' LOAD UPCOMING DUTIES
    '====================================================

    Private Sub LoadUpcomingDuties()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            Dim query As String = ""

            query &= "SELECT "
            query &= "e.ExamName AS ExamName, "
            query &= "e.Subject AS Subject, "
            query &= "e.ExamDate AS ExamDate, "
            query &= "e.StartTime AS StartTime, "
            query &= "e.EndTime AS EndTime, "
            query &= "h.HallName AS HallName, "
            query &= "COUNT(DISTINCT a.StudentID) AS StudentCount, "
            query &= "ei.Status AS AssignmentStatus "
            query &= "FROM ExamInvigilators ei "
            query &= "INNER JOIN Invigilators i "
            query &= "ON ei.InvigilatorID = i.InvigilatorID "
            query &= "INNER JOIN Exams e "
            query &= "ON ei.ExamID = e.ExamID "
            query &= "INNER JOIN Halls h "
            query &= "ON ei.HallID = h.HallID "
            query &= "LEFT JOIN Allocations a "
            query &= "ON a.ExamID = ei.ExamID "
            query &= "AND a.HallID = ei.HallID "
            query &= "AND a.Status = 'Active' "
            query &= "WHERE i.UserID = @UserID "
            query &= "AND ei.Status = 'Assigned' "
            query &= "AND e.Status <> 'Cancelled' "
            query &= "AND e.ExamDate >= CURDATE() "
            query &= "GROUP BY "
            query &= "ei.AssignmentID, "
            query &= "e.ExamName, "
            query &= "e.Subject, "
            query &= "e.ExamDate, "
            query &= "e.StartTime, "
            query &= "e.EndTime, "
            query &= "h.HallName, "
            query &= "ei.Status "
            query &= "ORDER BY e.ExamDate ASC, e.StartTime ASC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@UserID", userID))

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query, parameters)

            gvDuties.DataSource = dt
            gvDuties.DataBind()

        Catch ex As Exception

            gvDuties.DataSource = Nothing
            gvDuties.DataBind()

        End Try

    End Sub

End Class


Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Student_ExamHistory
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Check student login
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        ' Only students can access this page
        If Session("Role").ToString() <> "Student" Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadExamHistory()
        End If

    End Sub


    Private Sub LoadExamHistory()

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
            query &= "a.SeatNumber AS SeatNumber, "
            query &= "a.Status AS AllocationStatus "
            query &= "FROM Allocations a "
            query &= "INNER JOIN Students s ON a.StudentID = s.StudentID "
            query &= "INNER JOIN Exams e ON a.ExamID = e.ExamID "
            query &= "INNER JOIN Halls h ON a.HallID = h.HallID "
            query &= "WHERE s.UserID = @UserID "
            query &= "ORDER BY e.ExamDate DESC, e.StartTime DESC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@UserID", userID))

            Dim dt As DataTable = DatabaseHelper.GetDataTable(query, parameters)

            gvExamHistory.DataSource = dt
            gvExamHistory.DataBind()

        Catch ex As Exception

            gvExamHistory.DataSource = Nothing
            gvExamHistory.DataBind()

        End Try

    End Sub

End Class

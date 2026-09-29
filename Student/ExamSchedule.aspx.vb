Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Student_ExamSchedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Check student login
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        'Only students can access this page
        If Session("Role").ToString() <> "Student" Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadExamSchedule()
        End If

    End Sub


    Private Sub LoadExamSchedule()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            Dim query As String = ""
            query &= "SELECT e.ExamName, "
            query &= "e.Subject, "
            query &= "e.ExamDate, "
            query &= "e.StartTime, "
            query &= "e.EndTime, "
            query &= "e.Status "
            query &= "FROM Exams e "
            query &= "INNER JOIN Students s ON "
            query &= "e.Department = s.Department "
            query &= "AND e.Year = s.Year "
            query &= "WHERE s.UserID = @UserID "
            query &= "AND e.ExamDate >= CURDATE() "
            query &= "AND e.Status <> 'Cancelled' "
            query &= "ORDER BY e.ExamDate ASC, e.StartTime ASC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@UserID", userID))

            Dim dt As DataTable = DatabaseHelper.GetDataTable(query, parameters)

            gvExamSchedule.DataSource = dt
            gvExamSchedule.DataBind()

        Catch ex As Exception

            Response.Write("<script>alert('Unable to load examination schedule.');</script>")

        End Try

    End Sub

End Class

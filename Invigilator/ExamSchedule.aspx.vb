
Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Invigilator_ExamSchedule
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
            LoadExamSchedule()
        End If

    End Sub


    Private Sub LoadExamSchedule()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            Dim query As String = ""

            query &= "SELECT "
            query &= "e.ExamName AS ExamName, "
            query &= "e.Subject AS Subject, "
            query &= "DATE_FORMAT(e.ExamDate, '%d-%m-%Y') AS ExamDate, "
            query &= "TIME_FORMAT(e.StartTime, '%H:%i') AS StartTime, "
            query &= "TIME_FORMAT(e.EndTime, '%H:%i') AS EndTime, "
            query &= "h.HallName AS HallName, "
            query &= "h.Building AS Building, "
            query &= "h.Floor AS Floor, "
            query &= "ei.Status AS AssignmentStatus "
            query &= "FROM ExamInvigilators ei "
            query &= "INNER JOIN Invigilators i "
            query &= "ON ei.InvigilatorID = i.InvigilatorID "
            query &= "INNER JOIN Exams e "
            query &= "ON ei.ExamID = e.ExamID "
            query &= "INNER JOIN Halls h "
            query &= "ON ei.HallID = h.HallID "
            query &= "WHERE i.UserID = @UserID "
            query &= "AND ei.Status = 'Assigned' "
            query &= "AND e.Status <> 'Cancelled' "
            query &= "ORDER BY e.ExamDate ASC, e.StartTime ASC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@UserID", userID))

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query, parameters)

            gvSchedule.DataSource = dt
            gvSchedule.DataBind()

        Catch ex As Exception

            gvSchedule.DataSource = Nothing
            gvSchedule.DataBind()

        End Try

    End Sub

End Class
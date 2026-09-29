
Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Invigilator_AssignedHalls
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Check login
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        ' Check invigilator role
        If Session("Role").ToString() <> "Invigilator" Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadAssignedHalls()
        End If

    End Sub

    Private Sub LoadAssignedHalls()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            Dim query As String = ""

            query &= "SELECT "
            query &= "e.ExamName AS ExamName, "
            query &= "e.Subject AS SubjectName, "
            query &= "DATE_FORMAT(e.ExamDate, '%d-%m-%Y') AS ExamDate, "
            query &= "TIME_FORMAT(e.StartTime, '%H:%i') AS StartTime, "
            query &= "TIME_FORMAT(e.EndTime, '%H:%i') AS EndTime, "
            query &= "h.HallName AS HallName, "
            query &= "h.Building AS Building, "
            query &= "h.Floor AS Floor, "
            query &= "h.Capacity AS Capacity, "
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
            query &= "ON ei.ExamID = a.ExamID "
            query &= "AND ei.HallID = a.HallID "
            query &= "AND a.Status = 'Active' "

            query &= "WHERE i.UserID = @UserID "
            query &= "AND ei.Status = 'Assigned' "
            query &= "AND e.Status <> 'Cancelled' "

            query &= "GROUP BY "
            query &= "e.ExamName, "
            query &= "e.Subject, "
            query &= "e.ExamDate, "
            query &= "e.StartTime, "
            query &= "e.EndTime, "
            query &= "h.HallName, "
            query &= "h.Building, "
            query &= "h.Floor, "
            query &= "h.Capacity, "
            query &= "ei.Status "

            query &= "ORDER BY e.ExamDate ASC, e.StartTime ASC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@UserID", userID)
            )

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query, parameters)

            If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then

                rptHalls.DataSource = dt
                rptHalls.DataBind()

                pnlNoHalls.Visible = False

            Else

                rptHalls.DataSource = Nothing
                rptHalls.DataBind()

                pnlNoHalls.Visible = True

            End If

        Catch ex As Exception

            rptHalls.DataSource = Nothing
            rptHalls.DataBind()

            pnlNoHalls.Visible = True

        End Try

    End Sub

End Class

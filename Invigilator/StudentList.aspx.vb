Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Invigilator_StudentList
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
            LoadStudentList()
        End If

    End Sub

    Private Sub LoadStudentList()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            Dim query As String = ""

            query &= "SELECT "
            query &= "s.RegisterNumber AS RegisterNumber, "
            query &= "u.Name AS StudentName, "
            query &= "s.Department AS Department, "
            query &= "s.Year AS Year, "
            query &= "s.Section AS Section, "
            query &= "e.ExamName AS ExamName, "
            query &= "h.HallName AS HallName, "
            query &= "a.SeatNumber AS SeatNumber, "
            query &= "a.Status AS AllocationStatus "

            query &= "FROM ExamInvigilators ei "

            query &= "INNER JOIN Invigilators i "
            query &= "ON ei.InvigilatorID = i.InvigilatorID "

            query &= "INNER JOIN Allocations a "
            query &= "ON ei.ExamID = a.ExamID "
            query &= "AND ei.HallID = a.HallID "

            query &= "INNER JOIN Students s "
            query &= "ON a.StudentID = s.StudentID "

            query &= "INNER JOIN Users u "
            query &= "ON s.UserID = u.UserID "

            query &= "INNER JOIN Exams e "
            query &= "ON a.ExamID = e.ExamID "

            query &= "INNER JOIN Halls h "
            query &= "ON a.HallID = h.HallID "

            query &= "WHERE i.UserID = @UserID "
            query &= "AND ei.Status = 'Assigned' "
            query &= "AND a.Status = 'Active' "
            query &= "AND e.Status <> 'Cancelled' "

            query &= "ORDER BY "
            query &= "e.ExamDate ASC, "
            query &= "e.StartTime ASC, "
            query &= "h.HallName ASC, "
            query &= "CAST(a.SeatNumber AS UNSIGNED) ASC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@UserID", userID)
            )

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query, parameters)

            gvStudents.DataSource = dt
            gvStudents.DataBind()

        Catch ex As Exception

            gvStudents.DataSource = Nothing
            gvStudents.DataBind()

        End Try

    End Sub

End Class
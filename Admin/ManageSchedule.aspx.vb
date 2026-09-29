
Imports System
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Partial Class Admin_ManageSchedule
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

            txtSearch.Attributes.Add("placeholder", "Search exam, subject, department or status...")

            LoadSchedule()
            LoadStatistics()

        End If

    End Sub

    '========================================
    ' LOAD SCHEDULE
    '========================================
    Private Sub LoadSchedule()

        Try

            Dim query As String =
                "SELECT " &
                "s.ScheduleID, " &
                "s.ExamID, " &
                "e.ExamName, " &
                "e.Subject, " &
                "s.ExamDate, " &
                "s.StartTime, " &
                "s.EndTime, " &
                "e.Department, " &
                "e.`Year`, " &
                "s.Status " &
                "FROM Schedule s " &
                "INNER JOIN Exams e ON s.ExamID = e.ExamID " &
                "ORDER BY s.ScheduleID DESC"

            Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

            gvSchedule.DataSource = dt
            gvSchedule.DataBind()

        Catch ex As Exception

            lblMessage.Text = "Error loading schedules: " & ex.Message
            lblMessage.Visible = True

        End Try

    End Sub

    '========================================
    ' LOAD STATISTICS
    '========================================
    Private Sub LoadStatistics()

        Try

            Dim totalQuery As String =
                "SELECT COUNT(*) FROM Schedule"

            Dim scheduledQuery As String =
                "SELECT COUNT(*) FROM Schedule WHERE Status = 'Scheduled'"

            Dim activeQuery As String =
                "SELECT COUNT(*) FROM Schedule WHERE Status = 'Active'"

            Dim completedQuery As String =
                "SELECT COUNT(*) FROM Schedule WHERE Status = 'Completed'"

            Dim total As Object = DatabaseHelper.ExecuteScalar(totalQuery)
            Dim scheduled As Object = DatabaseHelper.ExecuteScalar(scheduledQuery)
            Dim active As Object = DatabaseHelper.ExecuteScalar(activeQuery)
            Dim completed As Object = DatabaseHelper.ExecuteScalar(completedQuery)

            lblTotalSchedules.Text = Convert.ToString(total)
            lblScheduled.Text = Convert.ToString(scheduled)
            lblActive.Text = Convert.ToString(active)
            lblCompleted.Text = Convert.ToString(completed)

        Catch ex As Exception

            lblMessage.Text = "Error loading statistics: " & ex.Message
            lblMessage.Visible = True

        End Try

    End Sub

    '========================================
    ' SEARCH
    '========================================
    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click

        Try

            Dim searchText As String = txtSearch.Text.Trim()

            If searchText = "" Then

                LoadSchedule()
                LoadStatistics()
                Return

            End If

            Dim query As String =
                "SELECT " &
                "s.ScheduleID, " &
                "s.ExamID, " &
                "e.ExamName, " &
                "e.Subject, " &
                "s.ExamDate, " &
                "s.StartTime, " &
                "s.EndTime, " &
                "e.Department, " &
                "e.`Year`, " &
                "s.Status " &
                "FROM Schedule s " &
                "INNER JOIN Exams e ON s.ExamID = e.ExamID " &
                "WHERE e.ExamName LIKE @Search " &
                "OR e.Subject LIKE @Search " &
                "OR e.Department LIKE @Search " &
                "OR s.Status LIKE @Search " &
                "ORDER BY s.ScheduleID DESC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@Search", "%" & searchText & "%")
            )

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query, parameters)

            gvSchedule.DataSource = dt
            gvSchedule.DataBind()

        Catch ex As Exception

            lblMessage.Text = "Search error: " & ex.Message
            lblMessage.Visible = True

        End Try

    End Sub

    '========================================
    ' CLEAR SEARCH
    '========================================
    Protected Sub btnClear_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClear.Click

        txtSearch.Text = ""

        lblMessage.Text = ""
        lblMessage.Visible = False

        LoadSchedule()
        LoadStatistics()

    End Sub

    '========================================
    ' ADD SCHEDULE
    '========================================
    Protected Sub btnAddSchedule_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddSchedule.Click

        Response.Redirect("AddSchedule.aspx")

    End Sub

    '========================================
    ' GRID ROW COMMAND
    '========================================
    Protected Sub gvSchedule_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs) Handles gvSchedule.RowCommand

        Try

            If e.CommandName = "EditSchedule" Then

                Dim scheduleID As Integer =
                    Convert.ToInt32(e.CommandArgument)

                Response.Redirect(
                    "EditSchedule.aspx?ScheduleID=" &
                    scheduleID.ToString()
                )

            ElseIf e.CommandName = "DeleteSchedule" Then

                Dim scheduleID As Integer =
                    Convert.ToInt32(e.CommandArgument)

                DeleteSchedule(scheduleID)

            End If

        Catch ex As Exception

            lblMessage.Text = "Error: " & ex.Message
            lblMessage.Visible = True

        End Try

    End Sub

    '========================================
    ' DELETE SCHEDULE
    '========================================
    Private Sub DeleteSchedule(ByVal scheduleID As Integer)

        Try

            Dim query As String =
                "DELETE FROM Schedule " &
                "WHERE ScheduleID = @ScheduleID"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@ScheduleID", scheduleID)
            )

            DatabaseHelper.ExecuteNonQuery(query, parameters)

            lblMessage.Text = "Schedule deleted successfully."
            lblMessage.Visible = True

            LoadSchedule()
            LoadStatistics()

        Catch ex As Exception

            lblMessage.Text = "Error deleting schedule: " & ex.Message
            lblMessage.Visible = True

        End Try

    End Sub

End Class

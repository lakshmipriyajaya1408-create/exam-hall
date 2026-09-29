
Imports System
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Partial Class Admin_EditSchedule
    Inherits System.Web.UI.Page

    Private scheduleID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Check Admin login
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Session("Role").ToString() <> "Admin" Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        ' Get ScheduleID from URL
        If Request.QueryString("ScheduleID") Is Nothing Then
            Response.Redirect("ManageSchedule.aspx")
            Return
        End If

        If Not Integer.TryParse(Request.QueryString("ScheduleID"), scheduleID) Then
            Response.Redirect("ManageSchedule.aspx")
            Return
        End If

        If Not IsPostBack Then

            LoadExamList()
            LoadSchedule()

        End If

    End Sub

    '========================================
    ' LOAD EXAM LIST
    '========================================
    Private Sub LoadExamList()

        Try

            Dim query As String =
                "SELECT ExamID, " &
                "CONCAT(ExamName, ' - ', Subject, " &
                "' (', Department, ', Year ', `Year`, ')') AS ExamDisplay " &
                "FROM Exams " &
                "WHERE Status <> 'Cancelled' " &
                "ORDER BY ExamDate DESC"

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)

            ddlExam.DataSource = dt
            ddlExam.DataTextField = "ExamDisplay"
            ddlExam.DataValueField = "ExamID"
            ddlExam.DataBind()

        Catch ex As Exception

            ShowError("Error loading examinations: " & ex.Message)

        End Try

    End Sub

    '========================================
    ' LOAD EXISTING SCHEDULE
    '========================================
    Private Sub LoadSchedule()

        Try

            Dim query As String =
                "SELECT " &
                "ScheduleID, " &
                "ExamID, " &
                "DATE_FORMAT(ExamDate, '%Y-%m-%d') AS ExamDateValue, " &
                "TIME_FORMAT(StartTime, '%H:%i') AS StartTimeValue, " &
                "TIME_FORMAT(EndTime, '%H:%i') AS EndTimeValue, " &
                "Status " &
                "FROM Schedule " &
                "WHERE ScheduleID = @ScheduleID"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@ScheduleID", scheduleID)
            )

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )

            If dt Is Nothing OrElse dt.Rows.Count = 0 Then

                ShowError("Schedule record could not be found.")

                btnUpdate.Enabled = False

                Return

            End If

            Dim row As DataRow = dt.Rows(0)

            ' Select examination
            Dim examID As Integer =
                Convert.ToInt32(row("ExamID"))

            If ddlExam.Items.FindByValue(examID.ToString()) IsNot Nothing Then
                ddlExam.SelectedValue = examID.ToString()
            End If

            ' Date
            txtExamDate.Text =
                Convert.ToString(row("ExamDateValue"))

            ' Start time
            txtStartTime.Text =
                Convert.ToString(row("StartTimeValue"))

            ' End time
            txtEndTime.Text =
                Convert.ToString(row("EndTimeValue"))

            ' Status
            Dim status As String =
                Convert.ToString(row("Status"))

            If ddlStatus.Items.FindByValue(status) IsNot Nothing Then
                ddlStatus.SelectedValue = status
            Else
                ddlStatus.SelectedValue = "Scheduled"
            End If

            lblInfo.Text =
                "Editing Schedule ID: " & scheduleID.ToString()

            lblInfo.Visible = True

        Catch ex As Exception

            ShowError("Error loading schedule: " & ex.Message)

        End Try

    End Sub

    '========================================
    ' UPDATE SCHEDULE
    '========================================
    Protected Sub btnUpdate_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnUpdate.Click

        lblMessage.Visible = False
        lblMessage.Text = ""

        ' Validate examination
        If ddlExam.SelectedValue = "" Then

            ShowError("Please select an examination.")
            Return

        End If

        ' Validate date
        If txtExamDate.Text.Trim() = "" Then

            ShowError("Please enter the examination date.")
            Return

        End If

        ' Validate start time
        If txtStartTime.Text.Trim() = "" Then

            ShowError("Please enter the start time.")
            Return

        End If

        ' Validate end time
        If txtEndTime.Text.Trim() = "" Then

            ShowError("Please enter the end time.")
            Return

        End If

        Try

            Dim examID As Integer =
                Convert.ToInt32(ddlExam.SelectedValue)

            Dim examDate As DateTime

            If Not DateTime.TryParse(
                txtExamDate.Text.Trim(),
                examDate
            ) Then

                ShowError(
                    "Please enter a valid examination date."
                )

                Return

            End If

            Dim startTime As TimeSpan
            Dim endTime As TimeSpan

            If Not TimeSpan.TryParse(
                txtStartTime.Text.Trim(),
                startTime
            ) Then

                ShowError(
                    "Please enter a valid start time."
                )

                Return

            End If

            If Not TimeSpan.TryParse(
                txtEndTime.Text.Trim(),
                endTime
            ) Then

                ShowError(
                    "Please enter a valid end time."
                )

                Return

            End If

            ' Check time validity
            If endTime <= startTime Then

                ShowError(
                    "End time must be later than start time."
                )

                Return

            End If

            '========================================
            ' CHECK FOR DUPLICATE SCHEDULE
            '========================================
            Dim duplicateQuery As String =
                "SELECT COUNT(*) " &
                "FROM Schedule " &
                "WHERE ExamID = @ExamID " &
                "AND ExamDate = @ExamDate " &
                "AND StartTime = @StartTime " &
                "AND EndTime = @EndTime " &
                "AND ScheduleID <> @ScheduleID"

            Dim duplicateParameters As New List(Of MySqlParameter)

            duplicateParameters.Add(
                New MySqlParameter("@ExamID", examID)
            )

            duplicateParameters.Add(
                New MySqlParameter("@ExamDate", examDate.Date)
            )

            duplicateParameters.Add(
                New MySqlParameter("@StartTime", startTime)
            )

            duplicateParameters.Add(
                New MySqlParameter("@EndTime", endTime)
            )

            duplicateParameters.Add(
                New MySqlParameter("@ScheduleID", scheduleID)
            )

            Dim duplicateCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        duplicateQuery,
                        duplicateParameters
                    )
                )

            If duplicateCount > 0 Then

                ShowError(
                    "Another schedule with the same examination date and time already exists."
                )

                Return

            End If

            '========================================
            ' UPDATE DATABASE
            '========================================
            Dim updateQuery As String =
                "UPDATE Schedule SET " &
                "ExamID = @ExamID, " &
                "ExamDate = @ExamDate, " &
                "StartTime = @StartTime, " &
                "EndTime = @EndTime, " &
                "Status = @Status " &
                "WHERE ScheduleID = @ScheduleID"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@ExamID", examID)
            )

            parameters.Add(
                New MySqlParameter("@ExamDate", examDate.Date)
            )

            parameters.Add(
                New MySqlParameter("@StartTime", startTime)
            )

            parameters.Add(
                New MySqlParameter("@EndTime", endTime)
            )

            parameters.Add(
                New MySqlParameter(
                    "@Status",
                    ddlStatus.SelectedValue
                )
            )

            parameters.Add(
                New MySqlParameter("@ScheduleID", scheduleID)
            )

            Dim result As Integer =
                DatabaseHelper.ExecuteNonQuery(
                    updateQuery,
                    parameters
                )

            If result > 0 Then

                Response.Redirect(
                    "ManageSchedule.aspx?updated=1"
                )

            Else

                ShowError(
                    "No changes were made to the schedule."
                )

            End If

        Catch ex As Exception

            ShowError(
                "Error updating schedule: " & ex.Message
            )

        End Try

    End Sub

    '========================================
    ' SHOW ERROR
    '========================================
    Private Sub ShowError(ByVal message As String)

        lblMessage.Text = message
        lblMessage.CssClass = "message"
        lblMessage.Visible = True

    End Sub

End Class

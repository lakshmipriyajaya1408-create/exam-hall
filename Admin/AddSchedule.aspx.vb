Imports System
Imports System.Data
Imports System.Collections.Generic
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class Admin_AddSchedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        '========================================
        ' ADMIN LOGIN CHECK
        '========================================
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Session("Role").ToString() <> "Admin" Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then

            ' Date and time picker support for VS2010
            txtExamDate.Attributes.Add("type", "date")
            txtStartTime.Attributes.Add("type", "time")
            txtEndTime.Attributes.Add("type", "time")

            LoadExams()

        End If

    End Sub


    '========================================
    ' LOAD EXAMS INTO DROPDOWN
    '========================================
    Private Sub LoadExams()

        Try

            Dim query As String =
                "SELECT ExamID, ExamName, Subject, Department, `Year` " &
                "FROM Exams " &
                "ORDER BY ExamDate ASC, StartTime ASC"

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)

            ddlExam.Items.Clear()

            ddlExam.Items.Add(
                New ListItem("-- Select Examination --", "")
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
                "Error loading examinations: " & ex.Message
            )

        End Try

    End Sub


    '========================================
    ' SAVE SCHEDULE
    '========================================
    Protected Sub btnSave_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnSave.Click

        lblMessage.Visible = False

        Try

            '----------------------------------------
            ' VALIDATE EXAM
            '----------------------------------------
            If ddlExam.SelectedValue = "" Then

                ShowMessage("Please select an examination.")
                Return

            End If


            '----------------------------------------
            ' VALIDATE DATE
            '----------------------------------------
            Dim examDate As DateTime

            If Not DateTime.TryParse(
                txtExamDate.Text.Trim(),
                examDate
            ) Then

                ShowMessage("Please enter a valid exam date.")
                Return

            End If


            '----------------------------------------
            ' VALIDATE START TIME
            '----------------------------------------
            Dim startTime As TimeSpan

            If Not TimeSpan.TryParse(
                txtStartTime.Text.Trim(),
                startTime
            ) Then

                ShowMessage("Please enter a valid start time.")
                Return

            End If


            '----------------------------------------
            ' VALIDATE END TIME
            '----------------------------------------
            Dim endTime As TimeSpan

            If Not TimeSpan.TryParse(
                txtEndTime.Text.Trim(),
                endTime
            ) Then

                ShowMessage("Please enter a valid end time.")
                Return

            End If


            '----------------------------------------
            ' CHECK TIME ORDER
            '----------------------------------------
            If endTime <= startTime Then

                ShowMessage(
                    "End time must be later than start time."
                )

                Return

            End If


            '----------------------------------------
            ' GET EXAM ID
            '----------------------------------------
            Dim examID As Integer =
                Convert.ToInt32(ddlExam.SelectedValue)


            '----------------------------------------
            ' CHECK DUPLICATE SCHEDULE
            '----------------------------------------
            Dim duplicateQuery As String =
                "SELECT COUNT(*) " &
                "FROM Schedule " &
                "WHERE ExamID = @ExamID"

            Dim duplicateParameters As New List(Of MySqlParameter)

            duplicateParameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )

            Dim duplicateCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        duplicateQuery,
                        duplicateParameters
                    )
                )

            If duplicateCount > 0 Then

                ShowMessage(
                    "A schedule already exists for this examination."
                )

                Return

            End If


            '----------------------------------------
            ' INSERT SCHEDULE
            '----------------------------------------
            Dim insertQuery As String =
                "INSERT INTO Schedule " &
                "(ExamID, ExamDate, StartTime, EndTime, Status) " &
                "VALUES " &
                "(@ExamID, @ExamDate, @StartTime, @EndTime, @Status)"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )

            parameters.Add(
                New MySqlParameter(
                    "@ExamDate",
                    examDate.Date
                )
            )

            parameters.Add(
                New MySqlParameter(
                    "@StartTime",
                    startTime
                )
            )

            parameters.Add(
                New MySqlParameter(
                    "@EndTime",
                    endTime
                )
            )

            parameters.Add(
                New MySqlParameter(
                    "@Status",
                    ddlStatus.SelectedValue
                )
            )

            DatabaseHelper.ExecuteNonQuery(
                insertQuery,
                parameters
            )


            '----------------------------------------
            ' SUCCESS
            '----------------------------------------
            Response.Redirect(
                "ManageSchedule.aspx?added=1"
            )

        Catch ex As Exception

            ShowMessage(
                "Error saving schedule: " & ex.Message
            )

        End Try

    End Sub


    '========================================
    ' SHOW MESSAGE
    '========================================
    Private Sub ShowMessage(ByVal message As String)

        lblMessage.Text = message
        lblMessage.Visible = True

    End Sub

End Class
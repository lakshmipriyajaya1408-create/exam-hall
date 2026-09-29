
Imports System
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Partial Class Admin_AddExam
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserID") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Session("Role") Is Nothing OrElse
           Session("Role").ToString() <> "Admin" Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If

        If Not IsPostBack Then

            txtExamName.Attributes.Add(
                "placeholder",
                "Enter exam name"
            )

            txtSubject.Attributes.Add(
                "placeholder",
                "Enter subject"
            )

            txtExamDate.Attributes.Add(
                "placeholder",
                "YYYY-MM-DD"
            )

            txtStartTime.Attributes.Add(
                "placeholder",
                "HH:MM"
            )

            txtEndTime.Attributes.Add(
                "placeholder",
                "HH:MM"
            )

            txtDepartment.Attributes.Add(
                "placeholder",
                "Enter department"
            )

        End If

    End Sub


    '========================================================
    ' SAVE EXAM
    '========================================================
    Protected Sub btnSave_Click(ByVal sender As Object,
                                ByVal e As System.EventArgs) _
                                Handles btnSave.Click

        Try

            '------------------------------------------------
            ' GET VALUES
            '------------------------------------------------

            Dim examName As String =
                txtExamName.Text.Trim()

            Dim subject As String =
                txtSubject.Text.Trim()

            Dim examDate As String =
                txtExamDate.Text.Trim()

            Dim startTime As String =
                txtStartTime.Text.Trim()

            Dim endTime As String =
                txtEndTime.Text.Trim()

            Dim department As String =
                txtDepartment.Text.Trim()

            Dim yearValue As Integer


            '------------------------------------------------
            ' VALIDATE BASIC FIELDS
            '------------------------------------------------

            If examName = "" Then

                ShowError("Please enter exam name.")
                Return

            End If


            If subject = "" Then

                ShowError("Please enter subject.")
                Return

            End If


            If examDate = "" Then

                ShowError("Please enter exam date.")
                Return

            End If


            If startTime = "" Then

                ShowError("Please enter start time.")
                Return

            End If


            If endTime = "" Then

                ShowError("Please enter end time.")
                Return

            End If


            If department = "" Then

                ShowError("Please enter department.")
                Return

            End If


            If ddlYear.SelectedValue = "" Then

                ShowError("Please select year.")
                Return

            End If


            yearValue =
                Convert.ToInt32(
                    ddlYear.SelectedValue
                )


            '------------------------------------------------
            ' INSERT EXAM
            '------------------------------------------------

            Dim query As String =
                "INSERT INTO Exams " &
                "(ExamName, Subject, ExamDate, StartTime, " &
                "EndTime, Department, `Year`, Status) " &
                "VALUES " &
                "(@ExamName, @Subject, @ExamDate, @StartTime, " &
                "@EndTime, @Department, @Year, @Status)"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@ExamName",
                    examName
                )
            )


            parameters.Add(
                New MySqlParameter(
                    "@Subject",
                    subject
                )
            )


            parameters.Add(
                New MySqlParameter(
                    "@ExamDate",
                    examDate
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
                    "@Department",
                    department
                )
            )


            parameters.Add(
                New MySqlParameter(
                    "@Year",
                    yearValue
                )
            )


            parameters.Add(
                New MySqlParameter(
                    "@Status",
                    ddlStatus.SelectedValue
                )
            )


            DatabaseHelper.ExecuteNonQuery(
                query,
                parameters
            )


            '------------------------------------------------
            ' SUCCESS
            '------------------------------------------------

            Response.Redirect(
                "ManageExams.aspx?added=1"
            )


        Catch ex As Exception

            ShowError(
                "Unable to save exam: " &
                ex.Message
            )

        End Try

    End Sub


    '========================================================
    ' CANCEL
    '========================================================
    Protected Sub btnCancel_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnCancel.Click

        Response.Redirect("ManageExams.aspx")

    End Sub


    '========================================================
    ' SHOW ERROR
    '========================================================
    Private Sub ShowError(ByVal message As String)

        lblMessage.Text = message

        lblMessage.CssClass =
            "alert alert-error"

    End Sub

End Class

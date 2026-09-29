
Imports System
Imports System.Collections.Generic
Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class Admin_EditExam
    Inherits System.Web.UI.Page

    Private examID As Integer


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


        If Request.QueryString("id") Is Nothing Then

            Response.Redirect("ManageExams.aspx")
            Return

        End If


        If Not Integer.TryParse(
            Request.QueryString("id"),
            examID
        ) Then

            Response.Redirect("ManageExams.aspx")
            Return

        End If


        If Not IsPostBack Then

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

            LoadExam()

        End If

    End Sub


    '========================================================
    ' LOAD EXAM
    '========================================================
    Private Sub LoadExam()

        Try

            Dim query As String =
                "SELECT ExamName, Subject, ExamDate, " &
                "StartTime, EndTime, Department, `Year`, Status " &
                "FROM Exams " &
                "WHERE ExamID=@ExamID"


            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            If dt.Rows.Count = 0 Then

                lblMessage.Text =
                    "Exam not found."

                lblMessage.CssClass =
                    "alert alert-error"

                Return

            End If


            Dim row As DataRow =
                dt.Rows(0)


            txtExamName.Text =
                row("ExamName").ToString()

            txtSubject.Text =
                row("Subject").ToString()

            txtExamDate.Text =
                Convert.ToDateTime(
                    row("ExamDate")
                ).ToString("yyyy-MM-dd")

            txtStartTime.Text =
                row("StartTime").ToString()

            txtEndTime.Text =
                row("EndTime").ToString()

            txtDepartment.Text =
                row("Department").ToString()

            ddlYear.SelectedValue =
                row("Year").ToString()

            ddlStatus.SelectedValue =
                row("Status").ToString()


        Catch ex As Exception

            lblMessage.Text =
                "Unable to load exam: " &
                ex.Message

            lblMessage.CssClass =
                "alert alert-error"

        End Try

    End Sub


    '========================================================
    ' UPDATE EXAM
    '========================================================
    Protected Sub btnUpdate_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnUpdate.Click

        Try

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
            ' VALIDATION
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
            ' UPDATE DATABASE
            '------------------------------------------------

            Dim query As String =
                "UPDATE Exams SET " &
                "ExamName=@ExamName, " &
                "Subject=@Subject, " &
                "ExamDate=@ExamDate, " &
                "StartTime=@StartTime, " &
                "EndTime=@EndTime, " &
                "Department=@Department, " &
                "`Year`=@Year, " &
                "Status=@Status " &
                "WHERE ExamID=@ExamID"


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


            parameters.Add(
                New MySqlParameter(
                    "@ExamID",
                    examID
                )
            )


            DatabaseHelper.ExecuteNonQuery(
                query,
                parameters
            )


            Response.Redirect(
                "ManageExams.aspx?updated=1"
            )


        Catch ex As Exception

            ShowError(
                "Unable to update exam: " &
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

Imports System
Imports System.Data
Imports System.Collections.Generic
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class Admin_ManageExams
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

            txtSearch.Attributes.Add(
                "placeholder",
                "Search by exam name, subject or department..."
            )

            LoadExams()
            LoadStatistics()

        End If

    End Sub


    '========================================================
    ' LOAD EXAMS
    '========================================================
    Private Sub LoadExams()

        Try

            Dim query As String =
                "SELECT ExamID, ExamName, Subject, ExamDate, " &
                "StartTime, EndTime, Department, `Year`, Status " &
                "FROM Exams " &
                "ORDER BY ExamID DESC"

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)

            gvExams.DataSource = dt
            gvExams.DataBind()

        Catch ex As Exception

            lblMessage.Text =
                "Error loading exams: " & ex.Message

            lblMessage.CssClass =
                "alert alert-error"

        End Try

    End Sub


    '========================================================
    ' LOAD STATISTICS
    '========================================================
    Private Sub LoadStatistics()

        Try

            Dim totalQuery As String =
                "SELECT COUNT(*) FROM Exams"

            Dim totalExams As Object =
                DatabaseHelper.ExecuteScalar(totalQuery)


            Dim activeQuery As String =
                "SELECT COUNT(*) FROM Exams " &
                "WHERE Status='Active'"

            Dim activeExams As Object =
                DatabaseHelper.ExecuteScalar(activeQuery)


            Dim upcomingQuery As String =
                "SELECT COUNT(*) FROM Exams " &
                "WHERE ExamDate >= CURDATE() " &
                "AND Status <> 'Completed'"

            Dim upcomingExams As Object =
                DatabaseHelper.ExecuteScalar(upcomingQuery)


            Dim completedQuery As String =
                "SELECT COUNT(*) FROM Exams " &
                "WHERE ExamDate < CURDATE() " &
                "OR Status='Completed'"

            Dim completedExams As Object =
                DatabaseHelper.ExecuteScalar(completedQuery)


            lblTotalExams.Text =
                Convert.ToInt32(totalExams).ToString()

            lblActiveExams.Text =
                Convert.ToInt32(activeExams).ToString()

            lblUpcomingExams.Text =
                Convert.ToInt32(upcomingExams).ToString()

            lblCompletedExams.Text =
                Convert.ToInt32(completedExams).ToString()

        Catch ex As Exception

            lblMessage.Text =
                "Unable to load statistics: " &
                ex.Message

            lblMessage.CssClass =
                "alert alert-error"

        End Try

    End Sub


    '========================================================
    ' SEARCH EXAMS
    '========================================================
    Protected Sub btnSearch_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnSearch.Click

        Try

            Dim searchText As String =
                txtSearch.Text.Trim()


            If searchText = "" Then

                LoadExams()
                Return

            End If


            Dim query As String =
                "SELECT ExamID, ExamName, Subject, ExamDate, " &
                "StartTime, EndTime, Department, `Year`, Status " &
                "FROM Exams " &
                "WHERE ExamName LIKE @Search " &
                "OR Subject LIKE @Search " &
                "OR Department LIKE @Search " &
                "OR Status LIKE @Search " &
                "ORDER BY ExamID DESC"


            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter(
                    "@Search",
                    "%" & searchText & "%"
                )
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            gvExams.DataSource = dt
            gvExams.DataBind()


            If dt.Rows.Count = 0 Then

                lblMessage.Text =
                    "No exams found for '" &
                    searchText & "'."

                lblMessage.CssClass =
                    "alert alert-error"

            Else

                lblMessage.Text =
                    dt.Rows.Count.ToString() &
                    " exam(s) found."

                lblMessage.CssClass =
                    "alert alert-success"

            End If


        Catch ex As Exception

            lblMessage.Text =
                "Search error: " & ex.Message

            lblMessage.CssClass =
                "alert alert-error"

        End Try

    End Sub


    '========================================================
    ' CLEAR SEARCH
    '========================================================
    Protected Sub btnClear_Click(ByVal sender As Object,
                                 ByVal e As System.EventArgs) _
                                 Handles btnClear.Click

        txtSearch.Text = ""

        lblMessage.Text = ""

        LoadExams()

    End Sub


    '========================================================
    ' ADD EXAM
    '========================================================
    Protected Sub btnAddExam_Click(ByVal sender As Object,
                                   ByVal e As System.EventArgs) _
                                   Handles btnAddExam.Click

        Response.Redirect("AddExam.aspx")

    End Sub


    '========================================================
    ' GRIDVIEW ROW COMMAND
    '========================================================
    Protected Sub gvExams_RowCommand(
        ByVal sender As Object,
        ByVal e As GridViewCommandEventArgs) _
        Handles gvExams.RowCommand

        Try

            If e.CommandArgument Is Nothing Then
                Return
            End If


            Dim examID As Integer


            If Not Integer.TryParse(
                e.CommandArgument.ToString(),
                examID
            ) Then

                lblMessage.Text =
                    "Invalid exam ID."

                lblMessage.CssClass =
                    "alert alert-error"

                Return

            End If


            If e.CommandName = "EditExam" Then

                Response.Redirect(
                    "EditExam.aspx?id=" &
                    examID.ToString()
                )

                Return

            End If


            If e.CommandName = "DeleteExam" Then

                DeleteExam(examID)

                Return

            End If


        Catch ex As Exception

            lblMessage.Text =
                "Operation failed: " & ex.Message

            lblMessage.CssClass =
                "alert alert-error"

        End Try

    End Sub


    '========================================================
    ' DELETE EXAM
    '========================================================
    Private Sub DeleteExam(ByVal examID As Integer)

        Try

            Dim query As String =
                "DELETE FROM Exams " &
                "WHERE ExamID=@ExamID"


            Dim parameters As New List(Of MySqlParameter)

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


            lblMessage.Text =
                "Exam deleted successfully."

            lblMessage.CssClass =
                "alert alert-success"


            LoadExams()
            LoadStatistics()


        Catch ex As Exception

            lblMessage.Text =
                "Delete failed: " & ex.Message

            lblMessage.CssClass =
                "alert alert-error"

        End Try

    End Sub

End Class
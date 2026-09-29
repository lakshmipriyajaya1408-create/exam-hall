Imports System
Imports System.Data
Imports System.Collections.Generic
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class Admin_ManageStudents
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        '====================================================
        ' CHECK LOGIN
        '====================================================
        If Session("UserID") Is Nothing Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        '====================================================
        ' CHECK ADMIN ROLE
        '====================================================
        If Session("Role") Is Nothing OrElse
           Session("Role").ToString() <> "Admin" Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        '====================================================
        ' FIRST PAGE LOAD
        '====================================================
        If Not IsPostBack Then

            'Search box placeholder
            txtSearch.Attributes.Add(
                "placeholder",
                "Search by register number or department..."
            )

            'Load student records
            LoadStudents()

            'Load statistics
            LoadStatistics()


            'Show success message after adding student
            If Request.QueryString("added") = "1" Then

                lblMessage.Text = "Student added successfully."
                lblMessage.CssClass = "alert alert-success"

            End If

        End If

    End Sub


    '========================================================
    ' LOAD STUDENTS
    '========================================================
    Private Sub LoadStudents()

        Try

            Dim query As String =
                "SELECT " &
                "s.StudentID, " &
                "u.Name, " &
                "s.RegisterNumber, " &
                "s.Department, " &
                "s.`Year`, " &
                "s.Section, " &
                "s.Status " &
                "FROM Students s " &
                "INNER JOIN Users u " &
                "ON s.UserID = u.UserID " &
                "ORDER BY s.StudentID DESC"

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)

            gvStudents.DataSource = dt
            gvStudents.DataBind()

        Catch ex As Exception

            lblMessage.Text =
                "Error loading students: " & ex.Message

            lblMessage.CssClass =
                "alert alert-error"

        End Try

    End Sub


    '========================================================
    ' SEARCH STUDENTS
    '========================================================
    Protected Sub btnSearch_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnSearch.Click

        Try

            Dim searchText As String =
                txtSearch.Text.Trim()


            'If search box is empty, load all students
            If searchText = "" Then

                LoadStudents()
                Return

            End If


            Dim query As String =
      "SELECT " &
      "s.StudentID, " &
      "u.Name, " &
      "s.RegisterNumber, " &
      "s.Department, " &
      "s.`Year`, " &
      "s.Section, " &
      "s.Status " &
      "FROM Students s " &
      "INNER JOIN Users u " &
      "ON s.UserID = u.UserID " &
      "WHERE s.RegisterNumber LIKE @Search " &
      "OR u.Name LIKE @Search " &
      "OR s.Department LIKE @Search " &
      "OR s.Section LIKE @Search " &
      "ORDER BY s.StudentID DESC"


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


            gvStudents.DataSource = dt
            gvStudents.DataBind()


            'Show result message
            If dt.Rows.Count = 0 Then

                lblMessage.Text =
                    "No students found for '" &
                    searchText & "'."

                lblMessage.CssClass =
                    "alert alert-error"

            Else

                lblMessage.Text =
                    dt.Rows.Count.ToString() &
                    " student(s) found."

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

        LoadStudents()

    End Sub


    '========================================================
    ' ADD STUDENT
    '========================================================
    Protected Sub btnAddStudent_Click(ByVal sender As Object,
                                      ByVal e As System.EventArgs) _
                                      Handles btnAddStudent.Click

        Response.Redirect("AddStudent.aspx")

    End Sub


    '========================================================
    ' GRIDVIEW ROW COMMAND
    '========================================================
    Protected Sub gvStudents_RowCommand(
        ByVal sender As Object,
        ByVal e As GridViewCommandEventArgs) _
        Handles gvStudents.RowCommand


        Try

            '----------------------------------------------
            ' GET STUDENT ID
            '----------------------------------------------
            If e.CommandArgument Is Nothing Then
                Return
            End If


            Dim studentID As Integer


            If Not Integer.TryParse(
                e.CommandArgument.ToString(),
                studentID
            ) Then

                lblMessage.Text =
                    "Invalid student ID."

                lblMessage.CssClass =
                    "alert alert-error"

                Return

            End If


            '----------------------------------------------
            ' EDIT STUDENT
            '----------------------------------------------
            If e.CommandName = "EditStudent" Then

                Response.Redirect(
                    "EditStudent.aspx?id=" &
                    studentID.ToString()
                )

                Return

            End If


            '----------------------------------------------
            ' DELETE STUDENT
            '----------------------------------------------
            If e.CommandName = "DeleteStudent" Then

                DeleteStudent(studentID)

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
    ' DELETE STUDENT
    '========================================================
    Private Sub DeleteStudent(ByVal studentID As Integer)

        Dim connection As MySqlConnection = Nothing
        Dim transaction As MySqlTransaction = Nothing


        Try

            '----------------------------------------------
            ' OPEN DATABASE CONNECTION
            '----------------------------------------------
            connection =
                DatabaseHelper.GetConnection()

            connection.Open()


            '----------------------------------------------
            ' START TRANSACTION
            '----------------------------------------------
            transaction =
                connection.BeginTransaction()


            '----------------------------------------------
            ' GET USER ID
            '----------------------------------------------
            Dim userID As Integer = 0


            Dim getUserQuery As String =
                "SELECT UserID " &
                "FROM Students " &
                "WHERE StudentID=@StudentID"


            Using getUserCommand As New MySqlCommand(
                getUserQuery,
                connection,
                transaction
            )

                getUserCommand.Parameters.AddWithValue(
                    "@StudentID",
                    studentID
                )


                Dim result As Object =
                    getUserCommand.ExecuteScalar()


                If result Is Nothing OrElse
                   result Is DBNull.Value Then

                    transaction.Rollback()

                    lblMessage.Text =
                        "Student record not found."

                    lblMessage.CssClass =
                        "alert alert-error"

                    Return

                End If


                userID =
                    Convert.ToInt32(result)

            End Using


            '----------------------------------------------
            ' DELETE STUDENT RECORD
            '----------------------------------------------
            Dim deleteStudentQuery As String =
                "DELETE FROM Students " &
                "WHERE StudentID=@StudentID"


            Using deleteStudentCommand As New MySqlCommand(
                deleteStudentQuery,
                connection,
                transaction
            )

                deleteStudentCommand.Parameters.AddWithValue(
                    "@StudentID",
                    studentID
                )

                deleteStudentCommand.ExecuteNonQuery()

            End Using


            '----------------------------------------------
            ' DELETE USER RECORD
            '----------------------------------------------
            Dim deleteUserQuery As String =
                "DELETE FROM Users " &
                "WHERE UserID=@UserID"


            Using deleteUserCommand As New MySqlCommand(
                deleteUserQuery,
                connection,
                transaction
            )

                deleteUserCommand.Parameters.AddWithValue(
                    "@UserID",
                    userID
                )

                deleteUserCommand.ExecuteNonQuery()

            End Using


            '----------------------------------------------
            ' COMMIT TRANSACTION
            '----------------------------------------------
            transaction.Commit()


            '----------------------------------------------
            ' SUCCESS MESSAGE
            '----------------------------------------------
            lblMessage.Text =
                "Student deleted successfully."

            lblMessage.CssClass =
                "alert alert-success"


            'Reload records
            LoadStudents()

            'Reload statistics
            LoadStatistics()


        Catch ex As Exception

            '----------------------------------------------
            ' ROLLBACK IF ERROR OCCURS
            '----------------------------------------------
            Try

                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If

            Catch
                'Ignore rollback error
            End Try


            lblMessage.Text =
                "Delete failed: " & ex.Message

            lblMessage.CssClass =
                "alert alert-error"


        Finally

            '----------------------------------------------
            ' CLOSE CONNECTION
            '----------------------------------------------
            If connection IsNot Nothing Then

                If connection.State =
                   ConnectionState.Open Then

                    connection.Close()

                End If

            End If


        End Try

    End Sub
    Private Sub LoadStatistics()

        Try

            Dim totalQuery As String =
                "SELECT COUNT(*) FROM Students"

            Dim totalStudents As Object =
                DatabaseHelper.ExecuteScalar(totalQuery)

            Dim activeQuery As String =
                "SELECT COUNT(*) " &
                "FROM Students " &
                "WHERE Status='Active'"

            Dim activeStudents As Object =
                DatabaseHelper.ExecuteScalar(activeQuery)

            Dim inactiveQuery As String =
                "SELECT COUNT(*) " &
                "FROM Students " &
                "WHERE Status='Inactive'"

            Dim inactiveStudents As Object =
                DatabaseHelper.ExecuteScalar(inactiveQuery)

            lblTotalStudents.Text =
                Convert.ToInt32(totalStudents).ToString()

            lblActiveStudents.Text =
                Convert.ToInt32(activeStudents).ToString()

            lblInactiveStudents.Text =
                Convert.ToInt32(inactiveStudents).ToString()

        Catch ex As Exception

            lblMessage.Text =
                "Unable to load statistics: " &
                ex.Message

            lblMessage.CssClass =
                "alert alert-error"
        End Try

    End Sub

End Class

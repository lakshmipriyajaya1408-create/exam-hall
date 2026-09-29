Imports System
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Partial Class Admin_EditStudent
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

            txtName.Attributes.Add(
                "placeholder",
                "Enter student's full name"
            )

            txtRegisterNumber.Attributes.Add(
                "placeholder",
                "Enter register number"
            )

            txtEmail.Attributes.Add(
                "placeholder",
                "Enter email address"
            )

            txtPhone.Attributes.Add(
                "placeholder",
                "Enter phone number"
            )

            txtAddress.Attributes.Add(
                "placeholder",
                "Enter student's address"
            )

            LoadStudent()

        End If

    End Sub


    '========================================================
    ' LOAD STUDENT
    '========================================================

    Private Sub LoadStudent()

        Dim studentID As Integer

        If Request.QueryString("id") Is Nothing Then

            ShowError("Student ID was not provided.")
            Return

        End If

        If Not Integer.TryParse(
            Request.QueryString("id"),
            studentID
        ) Then

            ShowError("Invalid student ID.")
            Return

        End If


        Try

            Dim query As String =
                "SELECT " &
                "s.StudentID, " &
                "s.UserID, " &
                "s.RegisterNumber, " &
                "s.Department, " &
                "s.`Year`, " &
                "s.Section, " &
                "s.Status, " &
                "u.Name, " &
                "u.Email, " &
                "u.Phone, " &
                "u.Address " &
                "FROM Students s " &
                "INNER JOIN Users u ON s.UserID = u.UserID " &
                "WHERE s.StudentID=@StudentID"


            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter(
                    "@StudentID",
                    studentID
                )
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            If dt Is Nothing OrElse
               dt.Rows.Count = 0 Then

                ShowError(
                    "Student record was not found."
                )

                Return

            End If


            Dim row As DataRow =
                dt.Rows(0)


            ViewState("UserID") =
                Convert.ToInt32(row("UserID"))

            ViewState("StudentID") =
                Convert.ToInt32(row("StudentID"))


            txtName.Text =
                row("Name").ToString()

            txtRegisterNumber.Text =
                row("RegisterNumber").ToString()

            txtEmail.Text =
                row("Email").ToString()

            txtPhone.Text =
                row("Phone").ToString()

            txtAddress.Text =
                row("Address").ToString()


            Dim departmentValue As String =
                row("Department").ToString()

            If ddlDepartment.Items.FindByValue(
                departmentValue
            ) IsNot Nothing Then

                ddlDepartment.SelectedValue =
                    departmentValue

            Else

                ddlDepartment.SelectedIndex = 0

            End If


            Dim yearValue As String =
                row("Year").ToString()

            If ddlYear.Items.FindByValue(
                yearValue
            ) IsNot Nothing Then

                ddlYear.SelectedValue =
                    yearValue

            Else

                ddlYear.SelectedIndex = 0

            End If


            Dim sectionValue As String =
                row("Section").ToString()

            If ddlSection.Items.FindByValue(
                sectionValue
            ) IsNot Nothing Then

                ddlSection.SelectedValue =
                    sectionValue

            Else

                ddlSection.SelectedIndex = 0

            End If


            Dim statusValue As String =
                row("Status").ToString()

            If ddlStatus.Items.FindByValue(
                statusValue
            ) IsNot Nothing Then

                ddlStatus.SelectedValue =
                    statusValue

            Else

                ddlStatus.SelectedValue =
                    "Active"

            End If


        Catch ex As Exception

            ShowError(
                "Unable to load student: " &
                ex.Message
            )

        End Try

    End Sub


    '========================================================
    ' UPDATE STUDENT
    '========================================================

    Protected Sub btnUpdate_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnUpdate.Click


        lblMessage.Text = ""
        lblMessage.CssClass = "alert"


        If ViewState("StudentID") Is Nothing OrElse
           ViewState("UserID") Is Nothing Then

            ShowError(
                "Student information is missing."
            )

            Return

        End If


        Dim studentID As Integer =
            Convert.ToInt32(
                ViewState("StudentID")
            )


        Dim userID As Integer =
            Convert.ToInt32(
                ViewState("UserID")
            )


        Dim studentName As String =
            txtName.Text.Trim()

        Dim registerNumber As String =
            txtRegisterNumber.Text.Trim()

        Dim email As String =
            txtEmail.Text.Trim()

        Dim phone As String =
            txtPhone.Text.Trim()

        Dim department As String =
            ddlDepartment.SelectedValue

        Dim yearValue As String =
            ddlYear.SelectedValue

        Dim section As String =
            ddlSection.SelectedValue

        Dim status As String =
            ddlStatus.SelectedValue

        Dim address As String =
            txtAddress.Text.Trim()


        '====================================================
        ' VALIDATION
        '====================================================

        If studentName = "" Then

            ShowError(
                "Please enter the student's name."
            )

            Return

        End If


        If registerNumber = "" Then

            ShowError(
                "Please enter the register number."
            )

            Return

        End If


        If email = "" Then

            ShowError(
                "Please enter the email address."
            )

            Return

        End If


        If phone = "" Then

            ShowError(
                "Please enter the phone number."
            )

            Return

        End If


        If department = "" Then

            ShowError(
                "Please select a department."
            )

            Return

        End If


        If yearValue = "" Then

            ShowError(
                "Please select the year."
            )

            Return

        End If


        Dim yearNumber As Integer

        If Not Integer.TryParse(
            yearValue,
            yearNumber
        ) Then

            ShowError(
                "Invalid year selected."
            )

            Return

        End If


        If section = "" Then

            ShowError(
                "Please select the section."
            )

            Return

        End If


        If status = "" Then

            ShowError(
                "Please select the status."
            )

            Return

        End If


        '====================================================
        ' CHECK DUPLICATE EMAIL
        '====================================================

        Try

            Dim emailQuery As String =
                "SELECT COUNT(*) " &
                "FROM Users " &
                "WHERE Email=@Email " &
                "AND UserID<>@UserID"


            Dim emailParameters As New List(Of MySqlParameter)

            emailParameters.Add(
                New MySqlParameter(
                    "@Email",
                    email
                )
            )

            emailParameters.Add(
                New MySqlParameter(
                    "@UserID",
                    userID
                )
            )


            Dim emailCount As Object =
                DatabaseHelper.ExecuteScalar(
                    emailQuery,
                    emailParameters
                )


            If Convert.ToInt32(emailCount) > 0 Then

                ShowError(
                    "Another user already uses this email address."
                )

                Return

            End If


        Catch ex As Exception

            ShowError(
                "Unable to check email: " &
                ex.Message
            )

            Return

        End Try


        '====================================================
        ' CHECK DUPLICATE REGISTER NUMBER
        '====================================================

        Try

            Dim registerQuery As String =
                "SELECT COUNT(*) " &
                "FROM Students " &
                "WHERE RegisterNumber=@RegisterNumber " &
                "AND StudentID<>@StudentID"


            Dim registerParameters As New List(Of MySqlParameter)

            registerParameters.Add(
                New MySqlParameter(
                    "@RegisterNumber",
                    registerNumber
                )
            )

            registerParameters.Add(
                New MySqlParameter(
                    "@StudentID",
                    studentID
                )
            )


            Dim registerCount As Object =
                DatabaseHelper.ExecuteScalar(
                    registerQuery,
                    registerParameters
                )


            If Convert.ToInt32(registerCount) > 0 Then

                ShowError(
                    "Another student already uses this register number."
                )

                Return

            End If


        Catch ex As Exception

            ShowError(
                "Unable to check register number: " &
                ex.Message
            )

            Return

        End Try


        '====================================================
        ' DATABASE TRANSACTION
        '====================================================

        Dim connection As MySqlConnection = Nothing
        Dim transaction As MySqlTransaction = Nothing


        Try

            connection =
                DatabaseHelper.GetConnection()

            connection.Open()


            transaction =
                connection.BeginTransaction()


            '================================================
            ' UPDATE USERS
            '================================================

            Dim userQuery As String =
                "UPDATE Users SET " &
                "Name=@Name, " &
                "Email=@Email, " &
                "Phone=@Phone, " &
                "Address=@Address, " &
                "Status=@Status " &
                "WHERE UserID=@UserID"


            Using userCommand As New MySqlCommand(
                userQuery,
                connection,
                transaction
            )

                userCommand.Parameters.AddWithValue(
                    "@Name",
                    studentName
                )

                userCommand.Parameters.AddWithValue(
                    "@Email",
                    email
                )

                userCommand.Parameters.AddWithValue(
                    "@Phone",
                    phone
                )

                userCommand.Parameters.AddWithValue(
                    "@Address",
                    address
                )

                userCommand.Parameters.AddWithValue(
                    "@Status",
                    status
                )

                userCommand.Parameters.AddWithValue(
                    "@UserID",
                    userID
                )

                userCommand.ExecuteNonQuery()

            End Using


            '================================================
            ' UPDATE STUDENTS
            '================================================

            Dim studentQuery As String =
                "UPDATE Students SET " &
                "RegisterNumber=@RegisterNumber, " &
                "Department=@Department, " &
                "`Year`=@Year, " &
                "Section=@Section, " &
                "Status=@Status " &
                "WHERE StudentID=@StudentID"


            Using studentCommand As New MySqlCommand(
                studentQuery,
                connection,
                transaction
            )

                studentCommand.Parameters.AddWithValue(
                    "@RegisterNumber",
                    registerNumber
                )

                studentCommand.Parameters.AddWithValue(
                    "@Department",
                    department
                )

                studentCommand.Parameters.AddWithValue(
                    "@Year",
                    yearNumber
                )

                studentCommand.Parameters.AddWithValue(
                    "@Section",
                    section
                )

                studentCommand.Parameters.AddWithValue(
                    "@Status",
                    status
                )

                studentCommand.Parameters.AddWithValue(
                    "@StudentID",
                    studentID
                )

                studentCommand.ExecuteNonQuery()

            End Using


            transaction.Commit()


            Response.Redirect(
                "ManageStudents.aspx?updated=1"
            )

            Return


        Catch ex As Exception


            Try

                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If

            Catch

            End Try


            ShowError(
                "Unable to update student: " &
                ex.Message
            )


        Finally

            If connection IsNot Nothing Then

                If connection.State =
                   ConnectionState.Open Then

                    connection.Close()

                End If

            End If

        End Try

    End Sub


    '========================================================
    ' CANCEL
    '========================================================

    Protected Sub btnCancel_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnCancel.Click

        Response.Redirect(
            "ManageStudents.aspx"
        )

    End Sub


    '========================================================
    ' ERROR MESSAGE
    '========================================================

    Private Sub ShowError(
        ByVal message As String
    )

        lblMessage.Text = message

        lblMessage.CssClass =
            "alert alert-error"

    End Sub

End Class
Imports System
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Partial Class Admin_AddStudent
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
        ' PLACEHOLDERS
        '====================================================

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

            txtPassword.Attributes.Add(
                "placeholder",
                "Enter password"
            )

            txtAddress.Attributes.Add(
                "placeholder",
                "Enter student's address"
            )

        End If

    End Sub


    '========================================================
    ' SAVE STUDENT
    '========================================================

    Protected Sub btnSave_Click(ByVal sender As Object,
                                ByVal e As System.EventArgs) _
                                Handles btnSave.Click

        'Clear previous message
        lblMessage.Text = ""
        lblMessage.CssClass = "alert"


        '====================================================
        ' GET VALUES
        '====================================================

        Dim studentName As String =
            txtName.Text.Trim()

        Dim registerNumber As String =
            txtRegisterNumber.Text.Trim()

        Dim email As String =
            txtEmail.Text.Trim()

        Dim phone As String =
            txtPhone.Text.Trim()

        Dim password As String =
            txtPassword.Text.Trim()

        Dim department As String =
            ddlDepartment.SelectedValue

        Dim yearValue As String =
            ddlYear.SelectedValue

        Dim section As String =
            ddlSection.SelectedValue

        Dim address As String =
            txtAddress.Text.Trim()


        '====================================================
        ' VALIDATE NAME
        '====================================================

        If studentName = "" Then

            ShowError("Please enter the student's name.")
            Return

        End If


        '====================================================
        ' VALIDATE REGISTER NUMBER
        '====================================================

        If registerNumber = "" Then

            ShowError("Please enter the register number.")
            Return

        End If


        '====================================================
        ' VALIDATE EMAIL
        '====================================================

        If email = "" Then

            ShowError("Please enter the email address.")
            Return

        End If


        '====================================================
        ' VALIDATE PHONE
        '====================================================

        If phone = "" Then

            ShowError("Please enter the phone number.")
            Return

        End If


        '====================================================
        ' VALIDATE PASSWORD
        '====================================================

        If password = "" Then

            ShowError("Please enter a password.")
            Return

        End If


        '====================================================
        ' VALIDATE DEPARTMENT
        '====================================================

        If department = "" Then

            ShowError("Please select a department.")
            Return

        End If


        '====================================================
        ' VALIDATE YEAR
        '====================================================

        If yearValue = "" Then

            ShowError("Please select the year.")
            Return

        End If


        '====================================================
        ' CONVERT YEAR TO INTEGER
        '====================================================

        Dim yearNumber As Integer

        If Not Integer.TryParse(
            yearValue,
            yearNumber
        ) Then

            ShowError("Invalid year selected.")
            Return

        End If


        '====================================================
        ' VALIDATE SECTION
        '====================================================

        If section = "" Then

            ShowError("Please select the section.")
            Return

        End If


        '====================================================
        ' CHECK DUPLICATE EMAIL
        '====================================================

        Try

            Dim emailQuery As String =
                "SELECT COUNT(*) " &
                "FROM Users " &
                "WHERE Email=@Email"


            Dim emailParameters As New List(Of MySqlParameter)

            emailParameters.Add(
                New MySqlParameter(
                    "@Email",
                    email
                )
            )


            Dim emailCount As Object =
                DatabaseHelper.ExecuteScalar(
                    emailQuery,
                    emailParameters
                )


            If Convert.ToInt32(emailCount) > 0 Then

                ShowError(
                    "A user with this email address already exists."
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
                "WHERE RegisterNumber=@RegisterNumber"


            Dim registerParameters As New List(Of MySqlParameter)

            registerParameters.Add(
                New MySqlParameter(
                    "@RegisterNumber",
                    registerNumber
                )
            )


            Dim registerCount As Object =
                DatabaseHelper.ExecuteScalar(
                    registerQuery,
                    registerParameters
                )


            If Convert.ToInt32(registerCount) > 0 Then

                ShowError(
                    "A student with this register number already exists."
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

            '------------------------------------------------
            ' OPEN CONNECTION
            '------------------------------------------------

            connection =
                DatabaseHelper.GetConnection()

            connection.Open()


            '------------------------------------------------
            ' START TRANSACTION
            '------------------------------------------------

            transaction =
                connection.BeginTransaction()


            '================================================
            ' INSERT INTO USERS
            '================================================

            Dim userQuery As String =
                "INSERT INTO Users " &
                "(Name, Email, Password, Phone, Address, Role, CreatedDate, Status) " &
                "VALUES " &
                "(@Name, @Email, @Password, @Phone, @Address, " &
                "'Student', NOW(), 'Active')"


            Dim userID As Integer


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
                    "@Password",
                    password
                )

                userCommand.Parameters.AddWithValue(
                    "@Phone",
                    phone
                )

                userCommand.Parameters.AddWithValue(
                    "@Address",
                    address
                )


                userCommand.ExecuteNonQuery()


                'Get newly generated UserID

                userID =
                    Convert.ToInt32(
                        userCommand.LastInsertedId
                    )

            End Using


            '================================================
            ' INSERT INTO STUDENTS
            '================================================

            Dim studentQuery As String =
                "INSERT INTO Students " &
                "(UserID, RegisterNumber, Department, `Year`, Section, Status) " &
                "VALUES " &
                "(@UserID, @RegisterNumber, @Department, " &
                "@Year, @Section, 'Active')"


            Using studentCommand As New MySqlCommand(
                studentQuery,
                connection,
                transaction
            )


                studentCommand.Parameters.AddWithValue(
                    "@UserID",
                    userID
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


                studentCommand.ExecuteNonQuery()

            End Using


            '================================================
            ' COMMIT
            '================================================

            transaction.Commit()


            '================================================
            ' SUCCESS
            '================================================

            Response.Redirect(
                "ManageStudents.aspx?added=1"
            )

            Return


        Catch ex As Exception


            '================================================
            ' ROLLBACK
            '================================================

            Try

                If transaction IsNot Nothing Then

                    transaction.Rollback()

                End If

            Catch

                'Ignore rollback error

            End Try


            ShowError(
                "Unable to add student: " &
                ex.Message
            )


        Finally


            '================================================
            ' CLOSE CONNECTION
            '================================================

            If connection IsNot Nothing Then

                If connection.State =
                   ConnectionState.Open Then

                    connection.Close()

                End If

            End If

        End Try

    End Sub


    '========================================================
    ' CANCEL BUTTON
    '========================================================

    Protected Sub btnCancel_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnCancel.Click

        Response.Redirect(
            "ManageStudents.aspx"
        )

    End Sub


    '========================================================
    ' ERROR MESSAGE
    '========================================================

    Private Sub ShowError(ByVal message As String)

        lblMessage.Text = message
        lblMessage.CssClass = "alert alert-error"

    End Sub

End Class
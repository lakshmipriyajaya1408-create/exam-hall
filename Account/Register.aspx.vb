Imports System
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Partial Class Account_Register

    Inherits System.Web.UI.Page


    '==========================================================
    ' PAGE LOAD
    '==========================================================

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            txtName.Attributes.Add(
                "placeholder",
                "Enter your full name"
            )

            txtEmail.Attributes.Add(
                "placeholder",
                "Enter your email address"
            )

            txtPassword.Attributes.Add(
                "placeholder",
                "Create a password"
            )

            txtPhone.Attributes.Add(
                "placeholder",
                "Enter phone number"
            )

            txtAddress.Attributes.Add(
                "placeholder",
                "Enter your address"
            )

            txtRegisterNumber.Attributes.Add(
                "placeholder",
                "Enter register number"
            )

            txtDepartment.Attributes.Add(
                "placeholder",
                "Example: CSE"
            )

            txtSection.Attributes.Add(
                "placeholder",
                "Example: A"
            )

            txtInvDepartment.Attributes.Add(
                "placeholder",
                "Example: CSE"
            )

            ShowRoleFields()

        End If

    End Sub


    '==========================================================
    ' ROLE CHANGE
    '==========================================================

    Protected Sub ddlRole_SelectedIndexChanged(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles ddlRole.SelectedIndexChanged

        ShowRoleFields()

    End Sub


    '==========================================================
    ' SHOW CORRECT ROLE FIELDS
    '==========================================================

    Private Sub ShowRoleFields()

        pnlStudent.Visible = False
        pnlInvigilator.Visible = False


        If ddlRole.SelectedValue = "Student" Then

            pnlStudent.Visible = True

        ElseIf ddlRole.SelectedValue = "Invigilator" Then

            pnlInvigilator.Visible = True

        End If

    End Sub


    '==========================================================
    ' REGISTER
    '==========================================================

    Protected Sub btnRegister_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnRegister.Click


        lblMessage.Visible = False


        Try

            '--------------------------------------------------
            ' BASIC VALIDATION
            '--------------------------------------------------

            If txtName.Text.Trim() = "" Then

                ShowMessage(
                    "Please enter your name.",
                    False
                )

                Return

            End If


            If txtEmail.Text.Trim() = "" Then

                ShowMessage(
                    "Please enter your email address.",
                    False
                )

                Return

            End If


            If txtPassword.Text.Trim() = "" Then

                ShowMessage(
                    "Please enter a password.",
                    False
                )

                Return

            End If


            If ddlRole.SelectedValue = "" Then

                ShowMessage(
                    "Please select your role.",
                    False
                )

                Return

            End If


            '--------------------------------------------------
            ' STUDENT VALIDATION
            '--------------------------------------------------

            If ddlRole.SelectedValue = "Student" Then

                If txtRegisterNumber.Text.Trim() = "" Then

                    ShowMessage(
                        "Please enter your register number.",
                        False
                    )

                    Return

                End If


                If txtDepartment.Text.Trim() = "" Then

                    ShowMessage(
                        "Please enter your department.",
                        False
                    )

                    Return

                End If


                If ddlYear.SelectedValue = "" Then

                    ShowMessage(
                        "Please select your year.",
                        False
                    )

                    Return

                End If


                If txtSection.Text.Trim() = "" Then

                    ShowMessage(
                        "Please enter your section.",
                        False
                    )

                    Return

                End If

            End If


            '--------------------------------------------------
            ' INVIGILATOR VALIDATION
            '--------------------------------------------------

            If ddlRole.SelectedValue = "Invigilator" Then

                If txtInvDepartment.Text.Trim() = "" Then

                    ShowMessage(
                        "Please enter the invigilator department.",
                        False
                    )

                    Return

                End If

            End If


            Dim email As String =
                txtEmail.Text.Trim()


            '--------------------------------------------------
            ' DUPLICATE EMAIL
            '--------------------------------------------------

            Dim duplicateQuery As String =
                "SELECT COUNT(*) " &
                "FROM Users " &
                "WHERE Email = @Email"


            Dim duplicateParameters As New List(Of MySqlParameter)


            duplicateParameters.Add(
                New MySqlParameter(
                    "@Email",
                    email
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
                    "An account with this email already exists.",
                    False
                )

                Return

            End If


            '==================================================
            ' DATABASE TRANSACTION
            '==================================================

            Using connection As MySqlConnection =
                DatabaseHelper.GetConnection()


                connection.Open()


                Using transaction As MySqlTransaction =
                    connection.BeginTransaction()


                    Try

                        '--------------------------------------
                        ' INSERT USERS
                        '--------------------------------------

                        Dim userQuery As String =
                            "INSERT INTO Users " &
                            "(Name, Email, Password, Phone, Address, Role, Status) " &
                            "VALUES " &
                            "(@Name, @Email, @Password, @Phone, @Address, @Role, 'Active')"


                        Dim userCommand As New MySqlCommand(
                            userQuery,
                            connection,
                            transaction
                        )


                        userCommand.Parameters.AddWithValue(
                            "@Name",
                            txtName.Text.Trim()
                        )


                        userCommand.Parameters.AddWithValue(
                            "@Email",
                            email
                        )


                        userCommand.Parameters.AddWithValue(
                            "@Password",
                            txtPassword.Text
                        )


                        userCommand.Parameters.AddWithValue(
                            "@Phone",
                            txtPhone.Text.Trim()
                        )


                        userCommand.Parameters.AddWithValue(
                            "@Address",
                            txtAddress.Text.Trim()
                        )


                        userCommand.Parameters.AddWithValue(
                            "@Role",
                            ddlRole.SelectedValue
                        )


                        userCommand.ExecuteNonQuery()


                        Dim userID As Integer =
                            Convert.ToInt32(
                                userCommand.LastInsertedId
                            )


                        '--------------------------------------
                        ' INSERT STUDENT
                        '--------------------------------------

                        If ddlRole.SelectedValue = "Student" Then


                            'Check register number

                            Dim registerCheckQuery As String =
                                "SELECT COUNT(*) " &
                                "FROM Students " &
                                "WHERE RegisterNumber = @RegisterNumber"


                            Dim registerCheckCommand As New MySqlCommand(
                                registerCheckQuery,
                                connection,
                                transaction
                            )


                            registerCheckCommand.Parameters.AddWithValue(
                                "@RegisterNumber",
                                txtRegisterNumber.Text.Trim()
                            )


                            Dim registerCount As Integer =
                                Convert.ToInt32(
                                    registerCheckCommand.ExecuteScalar()
                                )


                            If registerCount > 0 Then

                                transaction.Rollback()


                                ShowMessage(
                                    "This register number is already registered.",
                                    False
                                )

                                Return

                            End If


                            Dim studentQuery As String =
                                "INSERT INTO Students " &
                                "(UserID, RegisterNumber, Department, `Year`, Section, Status) " &
                                "VALUES " &
                                "(@UserID, @RegisterNumber, @Department, @Year, @Section, 'Active')"


                            Dim studentCommand As New MySqlCommand(
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
                                txtRegisterNumber.Text.Trim()
                            )


                            studentCommand.Parameters.AddWithValue(
                                "@Department",
                                txtDepartment.Text.Trim()
                            )


                            studentCommand.Parameters.AddWithValue(
                                "@Year",
                                Convert.ToInt32(
                                    ddlYear.SelectedValue
                                )
                            )


                            studentCommand.Parameters.AddWithValue(
                                "@Section",
                                txtSection.Text.Trim()
                            )


                            studentCommand.ExecuteNonQuery()


                            '--------------------------------------
                            ' INSERT INVIGILATOR
                            '--------------------------------------

                        ElseIf ddlRole.SelectedValue = "Invigilator" Then


                            Dim invigilatorQuery As String =
                                "INSERT INTO Invigilators " &
                                "(UserID, Department, Availability, Status) " &
                                "VALUES " &
                                "(@UserID, @Department, @Availability, 'Active')"


                            Dim invigilatorCommand As New MySqlCommand(
                                invigilatorQuery,
                                connection,
                                transaction
                            )


                            invigilatorCommand.Parameters.AddWithValue(
                                "@UserID",
                                userID
                            )


                            invigilatorCommand.Parameters.AddWithValue(
                                "@Department",
                                txtInvDepartment.Text.Trim()
                            )


                            invigilatorCommand.Parameters.AddWithValue(
                                "@Availability",
                                ddlAvailability.SelectedValue
                            )


                            invigilatorCommand.ExecuteNonQuery()

                        End If


                        transaction.Commit()


                    Catch

                        transaction.Rollback()

                        Throw

                    End Try

                End Using

            End Using


            '==================================================
            ' SUCCESS
            '==================================================

            ShowMessage(
                "Registration successful. You can now sign in.",
                True
            )


            ClearForm()

            ShowRoleFields()


        Catch ex As Exception

            ShowMessage(
                "Registration failed: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' CLEAR FORM
    '==========================================================

    Private Sub ClearForm()

        txtName.Text = ""
        txtEmail.Text = ""
        txtPassword.Text = ""
        txtPhone.Text = ""
        txtAddress.Text = ""

        txtRegisterNumber.Text = ""
        txtDepartment.Text = ""
        txtSection.Text = ""

        txtInvDepartment.Text = ""

        ddlRole.SelectedIndex = 0
        ddlYear.SelectedIndex = 0
        ddlAvailability.SelectedIndex = 0

    End Sub


    '==========================================================
    ' MESSAGE
    '==========================================================

    Private Sub ShowMessage(
        ByVal message As String,
        ByVal success As Boolean
    )

        lblMessage.Text = message
        lblMessage.Visible = True


        If success Then

            lblMessage.CssClass =
                "message success-message"

        Else

            lblMessage.CssClass =
                "message error-message"

        End If

    End Sub

End Class
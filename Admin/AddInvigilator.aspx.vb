Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Admin_AddInvigilator
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Session("Role").ToString() <> "Admin" Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then

            txtName.Attributes.Add("placeholder", "Enter full name")
            txtEmail.Attributes.Add("placeholder", "Enter email address")
            txtPassword.Attributes.Add("placeholder", "Enter password")
            txtPhone.Attributes.Add("placeholder", "Enter phone number")
            txtDepartment.Attributes.Add("placeholder", "Enter department")

        End If

    End Sub


    '=============================
    ' SAVE INVIGILATOR
    '=============================
    Protected Sub btnSave_Click(ByVal sender As Object,
                                ByVal e As System.EventArgs) Handles btnSave.Click

        If Not Page.IsValid Then
            Return
        End If

        Dim connection As MySqlConnection = Nothing
        Dim transaction As MySqlTransaction = Nothing

        Try

            Dim name As String = txtName.Text.Trim()
            Dim email As String = txtEmail.Text.Trim()
            Dim password As String = txtPassword.Text.Trim()
            Dim phone As String = txtPhone.Text.Trim()
            Dim department As String = txtDepartment.Text.Trim()
            Dim availability As String = ddlAvailability.SelectedValue
            Dim status As String = ddlStatus.SelectedValue

            '=============================
            ' CHECK DUPLICATE EMAIL
            '=============================

            Dim checkQuery As String =
                "SELECT COUNT(*) FROM Users WHERE Email = @Email"

            Dim checkParameters As New List(Of MySqlParameter)

            checkParameters.Add(
                New MySqlParameter("@Email", email)
            )

            Dim existingCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        checkQuery,
                        checkParameters
                    )
                )

            If existingCount > 0 Then

                lblMessage.Text =
                    "An account with this email already exists."

                Return

            End If


            '=============================
            ' OPEN CONNECTION
            '=============================

            connection = DatabaseHelper.GetConnection()
            connection.Open()

            transaction = connection.BeginTransaction()


            '=============================
            ' INSERT INTO USERS
            '=============================

            Dim userQuery As String =
                "INSERT INTO Users " &
                "(Name, Email, Password, Phone, Role, Status) " &
                "VALUES " &
                "(@Name, @Email, @Password, @Phone, 'Invigilator', @Status)"

            Dim userCommand As New MySqlCommand(
                userQuery,
                connection,
                transaction
            )

            userCommand.Parameters.AddWithValue(
                "@Name",
                name
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
                "@Status",
                status
            )

            userCommand.ExecuteNonQuery()


            '=============================
            ' GET NEW USER ID
            '=============================

            Dim userID As Integer =
                Convert.ToInt32(userCommand.LastInsertedId)


            '=============================
            ' INSERT INTO INVIGILATORS
            '=============================

            Dim invigilatorQuery As String =
                "INSERT INTO Invigilators " &
                "(UserID, Department, Availability, Status) " &
                "VALUES " &
                "(@UserID, @Department, @Availability, @Status)"

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
                department
            )

            invigilatorCommand.Parameters.AddWithValue(
                "@Availability",
                availability
            )

            invigilatorCommand.Parameters.AddWithValue(
                "@Status",
                status
            )

            invigilatorCommand.ExecuteNonQuery()


            '=============================
            ' COMMIT
            '=============================

            transaction.Commit()

            Response.Redirect(
                "ManageInvigilators.aspx?added=1"
            )


        Catch ex As Exception

            If transaction IsNot Nothing Then

                Try
                    transaction.Rollback()
                Catch
                End Try

            End If

            lblMessage.Text =
                "Unable to save invigilator. " &
                ex.Message


        Finally

            If connection IsNot Nothing Then

                If connection.State =
                    ConnectionState.Open Then

                    connection.Close()

                End If

            End If

        End Try

    End Sub


    '=============================
    ' CANCEL
    '=============================
    Protected Sub btnCancel_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) Handles btnCancel.Click

        Response.Redirect("ManageInvigilators.aspx")

    End Sub

End Class

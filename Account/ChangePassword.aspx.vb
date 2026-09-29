
Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Account_ChangePassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Check whether the user is logged in
        If Session("UserID") Is Nothing Then
            Response.Redirect("Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            txtCurrentPassword.Text = ""
            txtNewPassword.Text = ""
            txtConfirmPassword.Text = ""
        End If

    End Sub

    Protected Sub btnChangePassword_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnChangePassword.Click

        lblMessage.Text = ""
        lblMessage.CssClass = ""

        ' Validate fields
        If txtCurrentPassword.Text.Trim() = "" Then
            ShowError("Please enter your current password.")
            Return
        End If

        If txtNewPassword.Text.Trim() = "" Then
            ShowError("Please enter a new password.")
            Return
        End If

        If txtConfirmPassword.Text.Trim() = "" Then
            ShowError("Please confirm your new password.")
            Return
        End If

        ' Check whether new passwords match
        If txtNewPassword.Text <> txtConfirmPassword.Text Then
            ShowError("New password and confirm password do not match.")
            Return
        End If

        ' Minimum password length
        If txtNewPassword.Text.Length < 6 Then
            ShowError("New password must contain at least 6 characters.")
            Return
        End If

        ' Prevent using the same password
        If txtCurrentPassword.Text = txtNewPassword.Text Then
            ShowError("New password must be different from your current password.")
            Return
        End If

        Try

            Dim userID As Integer =
                Convert.ToInt32(Session("UserID"))

            ' Get current password
            Dim selectQuery As String = ""

            selectQuery &= "SELECT Password "
            selectQuery &= "FROM Users "
            selectQuery &= "WHERE UserID = @UserID"

            Dim selectParameters As New List(Of MySqlParameter)

            selectParameters.Add(
                New MySqlParameter("@UserID", userID)
            )

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    selectQuery,
                    selectParameters
                )

            If dt Is Nothing OrElse dt.Rows.Count = 0 Then
                ShowError("User account could not be found.")
                Return
            End If

            Dim storedPassword As String =
                Convert.ToString(dt.Rows(0)("Password"))

            ' Verify current password
            If storedPassword <> txtCurrentPassword.Text Then
                ShowError("Current password is incorrect.")
                Return
            End If

            ' Update password
            Dim updateQuery As String = ""

            updateQuery &= "UPDATE Users "
            updateQuery &= "SET Password = @NewPassword "
            updateQuery &= "WHERE UserID = @UserID"

            Dim updateParameters As New List(Of MySqlParameter)

            updateParameters.Add(
                New MySqlParameter(
                    "@NewPassword",
                    txtNewPassword.Text
                )
            )

            updateParameters.Add(
                New MySqlParameter(
                    "@UserID",
                    userID
                )
            )

            Dim result As Integer =
                DatabaseHelper.ExecuteNonQuery(
                    updateQuery,
                    updateParameters
                )

            If result > 0 Then

                ShowSuccess(
                    "Password changed successfully. Please use your new password the next time you sign in."
                )

                txtCurrentPassword.Text = ""
                txtNewPassword.Text = ""
                txtConfirmPassword.Text = ""

            Else

                ShowError("Password could not be changed.")

            End If

        Catch ex As Exception

            ShowError(
                "An error occurred while changing the password."
            )

        End Try

    End Sub

    Private Sub ShowError(ByVal message As String)

        lblMessage.Text = message
        lblMessage.CssClass = "message-error"

    End Sub

    Private Sub ShowSuccess(ByVal message As String)

        lblMessage.Text = message
        lblMessage.CssClass = "message-success"

    End Sub

End Class

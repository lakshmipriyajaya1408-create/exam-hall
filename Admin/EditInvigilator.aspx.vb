Imports MySql.Data.MySqlClient
Imports System.Data
Imports System.Collections.Generic

Partial Class Admin_EditInvigilator
    Inherits System.Web.UI.Page

    Private invigilatorID As Integer


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


        If Not Integer.TryParse(Request.QueryString("id"), invigilatorID) Then

            Response.Redirect("ManageInvigilators.aspx")
            Return

        End If


        If Not IsPostBack Then

            txtName.Attributes.Add("placeholder", "Enter full name")
            txtEmail.Attributes.Add("placeholder", "Enter email address")
            txtPhone.Attributes.Add("placeholder", "Enter phone number")
            txtDepartment.Attributes.Add("placeholder", "Enter department")

            LoadInvigilator()

        End If

    End Sub


    '=========================================
    ' LOAD INVIGILATOR
    '=========================================

    Private Sub LoadInvigilator()

        Try

            Dim query As String =
                "SELECT " &
                "u.Name, " &
                "u.Email, " &
                "u.Phone, " &
                "i.Department, " &
                "i.Availability, " &
                "i.Status " &
                "FROM Invigilators i " &
                "INNER JOIN Users u ON i.UserID = u.UserID " &
                "WHERE i.InvigilatorID = @InvigilatorID"


            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@InvigilatorID", invigilatorID)
            )


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(
                    query,
                    parameters
                )


            If dt.Rows.Count = 0 Then

                Response.Redirect("ManageInvigilators.aspx")
                Return

            End If


            Dim row As DataRow = dt.Rows(0)


            txtName.Text =
                row("Name").ToString()

            txtEmail.Text =
                row("Email").ToString()

            txtPhone.Text =
                row("Phone").ToString()

            txtDepartment.Text =
                row("Department").ToString()

            ddlAvailability.SelectedValue =
                row("Availability").ToString()

            ddlStatus.SelectedValue =
                row("Status").ToString()


        Catch ex As Exception

            lblMessage.Text =
                "Unable to load invigilator. " &
                ex.Message

        End Try

    End Sub


    '=========================================
    ' UPDATE INVIGILATOR
    '=========================================

    Protected Sub btnUpdate_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnUpdate.Click

        Try

            Dim name As String =
                txtName.Text.Trim()

            Dim email As String =
                txtEmail.Text.Trim()

            Dim phone As String =
                txtPhone.Text.Trim()

            Dim department As String =
                txtDepartment.Text.Trim()

            Dim availability As String =
                ddlAvailability.SelectedValue

            Dim status As String =
                ddlStatus.SelectedValue


            If name = "" Then

                lblMessage.Text =
                    "Please enter the invigilator name."

                Return

            End If


            If email = "" Then

                lblMessage.Text =
                    "Please enter the email address."

                Return

            End If


            '=========================================
            ' CHECK DUPLICATE EMAIL
            '=========================================

            Dim checkQuery As String =
                "SELECT COUNT(*) " &
                "FROM Users u " &
                "INNER JOIN Invigilators i " &
                "ON u.UserID = i.UserID " &
                "WHERE u.Email = @Email " &
                "AND i.InvigilatorID <> @InvigilatorID"


            Dim checkParameters As New List(Of MySqlParameter)

            checkParameters.Add(
                New MySqlParameter("@Email", email)
            )

            checkParameters.Add(
                New MySqlParameter("@InvigilatorID", invigilatorID)
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
                    "Another invigilator already uses this email."

                Return

            End If


            '=========================================
            ' GET USER ID
            '=========================================

            Dim userQuery As String =
                "SELECT UserID " &
                "FROM Invigilators " &
                "WHERE InvigilatorID = @InvigilatorID"


            Dim userParameters As New List(Of MySqlParameter)

            userParameters.Add(
                New MySqlParameter("@InvigilatorID", invigilatorID)
            )


            Dim userID As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        userQuery,
                        userParameters
                    )
                )


            '=========================================
            ' UPDATE USERS
            '=========================================

            Dim updateUserQuery As String =
                "UPDATE Users SET " &
                "Name = @Name, " &
                "Email = @Email, " &
                "Phone = @Phone, " &
                "Status = @Status " &
                "WHERE UserID = @UserID"


            Dim userUpdateParameters As New List(Of MySqlParameter)

            userUpdateParameters.Add(
                New MySqlParameter("@Name", name)
            )

            userUpdateParameters.Add(
                New MySqlParameter("@Email", email)
            )

            userUpdateParameters.Add(
                New MySqlParameter("@Phone", phone)
            )

            userUpdateParameters.Add(
                New MySqlParameter("@Status", status)
            )

            userUpdateParameters.Add(
                New MySqlParameter("@UserID", userID)
            )


            DatabaseHelper.ExecuteNonQuery(
                updateUserQuery,
                userUpdateParameters
            )


            '=========================================
            ' UPDATE INVIGILATORS
            '=========================================

            Dim updateInvigilatorQuery As String =
                "UPDATE Invigilators SET " &
                "Department = @Department, " &
                "Availability = @Availability, " &
                "Status = @Status " &
                "WHERE InvigilatorID = @InvigilatorID"


            Dim invigilatorParameters As New List(Of MySqlParameter)

            invigilatorParameters.Add(
                New MySqlParameter("@Department", department)
            )

            invigilatorParameters.Add(
                New MySqlParameter("@Availability", availability)
            )

            invigilatorParameters.Add(
                New MySqlParameter("@Status", status)
            )

            invigilatorParameters.Add(
                New MySqlParameter("@InvigilatorID", invigilatorID)
            )


            DatabaseHelper.ExecuteNonQuery(
                updateInvigilatorQuery,
                invigilatorParameters
            )


            Response.Redirect(
                "ManageInvigilators.aspx?updated=1"
            )


        Catch ex As Exception

            lblMessage.Text =
                "Unable to update invigilator. " &
                ex.Message

        End Try

    End Sub


    '=========================================
    ' CANCEL
    '=========================================

    Protected Sub btnCancel_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnCancel.Click

        Response.Redirect("ManageInvigilators.aspx")

    End Sub

End Class
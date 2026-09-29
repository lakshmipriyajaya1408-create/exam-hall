
Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Admin_AddHall
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
            txtHallName.Attributes.Add("placeholder", "Enter hall name")
            txtBuilding.Attributes.Add("placeholder", "Enter building name")
            txtFloor.Attributes.Add("placeholder", "Enter floor")
            txtCapacity.Attributes.Add("placeholder", "Enter seating capacity")
        End If

    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object,
                                ByVal e As System.EventArgs) Handles btnSave.Click

        If Not Page.IsValid Then
            Return
        End If

        Try

            Dim hallName As String = txtHallName.Text.Trim()
            Dim building As String = txtBuilding.Text.Trim()
            Dim floor As String = txtFloor.Text.Trim()
            Dim capacity As Integer
            Dim status As String = ddlStatus.SelectedValue

            If Not Integer.TryParse(txtCapacity.Text.Trim(), capacity) Then

                lblMessage.Text = "Please enter a valid numeric capacity."
                Return

            End If

            If capacity <= 0 Then

                lblMessage.Text = "Capacity must be greater than zero."
                Return

            End If

            ' Check whether hall name already exists
            Dim checkQuery As String =
                "SELECT COUNT(*) FROM Halls WHERE HallName = @HallName"

            Dim checkParameters As New List(Of MySqlParameter)

            checkParameters.Add(
                New MySqlParameter("@HallName", hallName)
            )

            Dim existingCount As Integer =
                Convert.ToInt32(
                    DatabaseHelper.ExecuteScalar(
                        checkQuery,
                        checkParameters
                    )
                )

            If existingCount > 0 Then

                lblMessage.Text = "A hall with this name already exists."
                Return

            End If

            ' Insert hall
            Dim query As String =
                "INSERT INTO Halls " &
                "(HallName, Building, Floor, Capacity, Status) " &
                "VALUES " &
                "(@HallName, @Building, @Floor, @Capacity, @Status)"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@HallName", hallName)
            )

            parameters.Add(
                New MySqlParameter("@Building", building)
            )

            parameters.Add(
                New MySqlParameter("@Floor", floor)
            )

            parameters.Add(
                New MySqlParameter("@Capacity", capacity)
            )

            parameters.Add(
                New MySqlParameter("@Status", status)
            )

            DatabaseHelper.ExecuteNonQuery(query, parameters)

            Response.Redirect("ManageHalls.aspx?added=1")

        Catch ex As Exception

            lblMessage.Text =
                "Unable to save hall. " & ex.Message

        End Try

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) Handles btnCancel.Click

        Response.Redirect("ManageHalls.aspx")

    End Sub

End Class

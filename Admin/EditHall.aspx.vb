
Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Admin_EditHall
    Inherits System.Web.UI.Page

    Private hallID As Integer

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

        If Request.QueryString("id") Is Nothing Then
            Response.Redirect("ManageHalls.aspx")
            Return
        End If

        If Not Integer.TryParse(Request.QueryString("id"), hallID) Then
            Response.Redirect("ManageHalls.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadHall()
        End If

    End Sub

    Private Sub LoadHall()

        Try

            Dim query As String =
                "SELECT HallName, Building, Floor, Capacity, Status " &
                "FROM Halls " &
                "WHERE HallID = @HallID"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter("@HallID", hallID)
            )

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query, parameters)

            If dt.Rows.Count = 0 Then
                Response.Redirect("ManageHalls.aspx")
                Return
            End If

            txtHallName.Text =
                dt.Rows(0)("HallName").ToString()

            txtBuilding.Text =
                dt.Rows(0)("Building").ToString()

            txtFloor.Text =
                dt.Rows(0)("Floor").ToString()

            txtCapacity.Text =
                dt.Rows(0)("Capacity").ToString()

            ddlStatus.SelectedValue =
                dt.Rows(0)("Status").ToString()

        Catch ex As Exception

            lblMessage.Text =
                "Unable to load hall. " & ex.Message

        End Try

    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) Handles btnUpdate.Click

        If Not Page.IsValid Then
            Return
        End If

        Try

            Dim hallName As String =
                txtHallName.Text.Trim()

            Dim building As String =
                txtBuilding.Text.Trim()

            Dim floor As String =
                txtFloor.Text.Trim()

            Dim capacity As Integer

            Dim status As String =
                ddlStatus.SelectedValue

            If Not Integer.TryParse(
                txtCapacity.Text.Trim(),
                capacity) Then

                lblMessage.Text =
                    "Please enter a valid numeric capacity."

                Return

            End If

            If capacity <= 0 Then

                lblMessage.Text =
                    "Capacity must be greater than zero."

                Return

            End If

            ' Check duplicate hall name
            Dim checkQuery As String =
                "SELECT COUNT(*) FROM Halls " &
                "WHERE HallName = @HallName " &
                "AND HallID <> @HallID"

            Dim checkParameters As New List(Of MySqlParameter)

            checkParameters.Add(
                New MySqlParameter("@HallName", hallName)
            )

            checkParameters.Add(
                New MySqlParameter("@HallID", hallID)
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
                    "Another hall already uses this name."

                Return

            End If

            ' Update hall
            Dim query As String =
                "UPDATE Halls SET " &
                "HallName = @HallName, " &
                "Building = @Building, " &
                "Floor = @Floor, " &
                "Capacity = @Capacity, " &
                "Status = @Status " &
                "WHERE HallID = @HallID"

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

            parameters.Add(
                New MySqlParameter("@HallID", hallID)
            )

            DatabaseHelper.ExecuteNonQuery(
                query,
                parameters
            )

            Response.Redirect(
                "ManageHalls.aspx?updated=1"
            )

        Catch ex As Exception

            lblMessage.Text =
                "Unable to update hall. " & ex.Message

        End Try

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) Handles btnCancel.Click

        Response.Redirect("ManageHalls.aspx")

    End Sub

End Class

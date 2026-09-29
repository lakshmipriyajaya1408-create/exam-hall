
Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Admin_ManageHalls
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Session("Role").ToString() <> "Admin" Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadHalls()
            LoadStatistics()
        End If

        txtSearch.Attributes.Add("placeholder", "Search by hall name, building or floor...")
    End Sub

    '=============================
    ' LOAD HALLS
    '=============================
    Private Sub LoadHalls()

        Try

            Dim query As String =
                "SELECT HallID, HallName, Building, Floor, Capacity, Status " &
                "FROM Halls " &
                "ORDER BY HallID DESC"

            Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

            gvHalls.DataSource = dt
            gvHalls.DataBind()

        Catch ex As Exception

            Response.Write("<script>alert('Error loading halls: " &
                           ex.Message.Replace("'", "\'") &
                           "');</script>")

        End Try

    End Sub

    '=============================
    ' LOAD STATISTICS
    '=============================
    Private Sub LoadStatistics()

        Try

            Dim query As String =
                "SELECT " &
                "COUNT(*) AS TotalHalls, " &
                "SUM(CASE WHEN Status = 'Available' THEN 1 ELSE 0 END) AS AvailableHalls, " &
                "SUM(CASE WHEN Status <> 'Available' THEN 1 ELSE 0 END) AS OccupiedHalls, " &
                "COALESCE(SUM(Capacity), 0) AS TotalCapacity " &
                "FROM Halls"

            Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

            If dt.Rows.Count > 0 Then

                lblTotalHalls.Text = dt.Rows(0)("TotalHalls").ToString()
                lblAvailableHalls.Text = dt.Rows(0)("AvailableHalls").ToString()
                lblOccupiedHalls.Text = dt.Rows(0)("OccupiedHalls").ToString()
                lblTotalCapacity.Text = dt.Rows(0)("TotalCapacity").ToString()

            End If

        Catch ex As Exception

            lblTotalHalls.Text = "0"
            lblAvailableHalls.Text = "0"
            lblOccupiedHalls.Text = "0"
            lblTotalCapacity.Text = "0"

        End Try

    End Sub

    '=============================
    ' SEARCH
    '=============================
    Protected Sub btnSearch_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) Handles btnSearch.Click

        Try

            Dim searchText As String = txtSearch.Text.Trim()

            If searchText = "" Then

                LoadHalls()
                Return

            End If

            Dim query As String =
                "SELECT HallID, HallName, Building, Floor, Capacity, Status " &
                "FROM Halls " &
                "WHERE HallName LIKE @Search " &
                "OR Building LIKE @Search " &
                "OR Floor LIKE @Search " &
                "OR Status LIKE @Search " &
                "ORDER BY HallID DESC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@Search", "%" & searchText & "%"))
            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query, parameters)

            gvHalls.DataSource = dt
            gvHalls.DataBind()

        Catch ex As Exception

            Response.Write("<script>alert('Search error: " &
                           ex.Message.Replace("'", "\'") &
                           "');</script>")

        End Try

    End Sub

    '=============================
    ' CLEAR SEARCH
    '=============================
    Protected Sub btnClear_Click(ByVal sender As Object,
                                 ByVal e As System.EventArgs) Handles btnClear.Click

        txtSearch.Text = ""

        LoadHalls()

    End Sub

    '=============================
    ' ADD HALL
    '=============================
    Protected Sub btnAddHall_Click(ByVal sender As Object,
                                   ByVal e As System.EventArgs) Handles btnAddHall.Click

        Response.Redirect("AddHall.aspx")

    End Sub

    '=============================
    ' GRIDVIEW COMMANDS
    '=============================
    Protected Sub gvHalls_RowCommand(ByVal sender As Object,
                                     ByVal e As GridViewCommandEventArgs) Handles gvHalls.RowCommand

        If e.CommandName = "EditHall" Then

            Dim hallID As String = e.CommandArgument.ToString()

            Response.Redirect("EditHall.aspx?id=" & hallID)

        ElseIf e.CommandName = "DeleteHall" Then

            Dim hallID As Integer = Convert.ToInt32(e.CommandArgument)

            DeleteHall(hallID)

        End If

    End Sub

    '=============================
    ' DELETE HALL
    '=============================
    '=============================
    ' DELETE HALL
    '=============================
    Private Sub DeleteHall(ByVal hallID As Integer)

        Try

            Dim query As String =
                "DELETE FROM Halls WHERE HallID = @HallID"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@HallID", hallID))

            DatabaseHelper.ExecuteNonQuery(query, parameters)

            LoadHalls()
            LoadStatistics()

        Catch ex As Exception

            Response.Write("<script>alert('Unable to delete hall. " &
                           ex.Message.Replace("'", "\'") &
                           "');</script>")

        End Try

    End Sub

End Class

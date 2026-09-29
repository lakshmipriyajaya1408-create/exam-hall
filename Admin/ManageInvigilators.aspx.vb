Imports MySql.Data.MySqlClient
Imports System.Data
Imports System.Web.UI.WebControls

Partial Class Admin_ManageInvigilators
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        '=============================
        ' ADMIN LOGIN CHECK
        '=============================
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Session("Role").ToString() <> "Admin" Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        '=============================
        ' INITIAL LOAD
        '=============================
        If Not IsPostBack Then
            LoadInvigilators()
            LoadStatistics()
        End If

        txtSearch.Attributes.Add(
            "placeholder",
            "Search by name, email or department..."
        )

    End Sub


    '=============================
    ' LOAD INVIGILATORS
    '=============================
    Private Sub LoadInvigilators()

        Try

            Dim query As String =
                "SELECT " &
                "i.InvigilatorID, " &
                "u.Name, " &
                "u.Email, " &
                "i.Department, " &
                "i.Availability, " &
                "i.Status " &
                "FROM Invigilators i " &
                "INNER JOIN Users u " &
                "ON i.UserID = u.UserID " &
                "ORDER BY i.InvigilatorID DESC"

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)

            gvInvigilators.DataSource = dt
            gvInvigilators.DataBind()

        Catch ex As Exception

            Response.Write(
                "<script>alert('Error loading invigilators: " &
                ex.Message.Replace("'", "\'") &
                "');</script>"
            )

        End Try

    End Sub


    '=============================
    ' LOAD STATISTICS
    '=============================
    Private Sub LoadStatistics()

        Try

            Dim query As String =
                "SELECT " &
                "COUNT(*) AS TotalInvigilators, " &
                "SUM(CASE WHEN Availability = 'Available' THEN 1 ELSE 0 END) AS AvailableInvigilators, " &
                "SUM(CASE WHEN Availability <> 'Available' THEN 1 ELSE 0 END) AS UnavailableInvigilators, " &
                "SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS ActiveInvigilators " &
                "FROM Invigilators"

            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)

            If dt.Rows.Count > 0 Then

                lblTotalInvigilators.Text =
                    dt.Rows(0)("TotalInvigilators").ToString()

                lblAvailableInvigilators.Text =
                    dt.Rows(0)("AvailableInvigilators").ToString()

                lblUnavailableInvigilators.Text =
                    dt.Rows(0)("UnavailableInvigilators").ToString()

                lblActiveInvigilators.Text =
                    dt.Rows(0)("ActiveInvigilators").ToString()

            End If

        Catch ex As Exception

            lblTotalInvigilators.Text = "0"
            lblAvailableInvigilators.Text = "0"
            lblUnavailableInvigilators.Text = "0"
            lblActiveInvigilators.Text = "0"

        End Try

    End Sub


    '=============================
    ' SEARCH
    '=============================
    Protected Sub btnSearch_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) Handles btnSearch.Click

        Try

            Dim searchText As String =
                txtSearch.Text.Trim()

            If searchText = "" Then

                LoadInvigilators()
                Return

            End If

            Dim query As String =
                "SELECT " &
                "i.InvigilatorID, " &
                "u.Name, " &
                "u.Email, " &
                "i.Department, " &
                "i.Availability, " &
                "i.Status " &
                "FROM Invigilators i " &
                "INNER JOIN Users u " &
                "ON i.UserID = u.UserID " &
                "WHERE u.Name LIKE @Search " &
                "OR u.Email LIKE @Search " &
                "OR i.Department LIKE @Search " &
                "OR i.Availability LIKE @Search " &
                "OR i.Status LIKE @Search " &
                "ORDER BY i.InvigilatorID DESC"

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

            gvInvigilators.DataSource = dt
            gvInvigilators.DataBind()

        Catch ex As Exception

            Response.Write(
                "<script>alert('Search error: " &
                ex.Message.Replace("'", "\'") &
                "');</script>"
            )

        End Try

    End Sub


    '=============================
    ' CLEAR SEARCH
    '=============================
    Protected Sub btnClear_Click(ByVal sender As Object,
                                 ByVal e As System.EventArgs) Handles btnClear.Click

        txtSearch.Text = ""

        LoadInvigilators()

    End Sub


    '=============================
    ' ADD INVIGILATOR
    '=============================
    Protected Sub btnAddInvigilator_Click(ByVal sender As Object,
                                          ByVal e As System.EventArgs) Handles btnAddInvigilator.Click

        Response.Redirect("AddInvigilator.aspx")

    End Sub


    '=============================
    ' GRIDVIEW COMMANDS
    '=============================
    Protected Sub gvInvigilators_RowCommand(
        ByVal sender As Object,
        ByVal e As GridViewCommandEventArgs
        ) Handles gvInvigilators.RowCommand

        If e.CommandName = "EditInvigilator" Then

            Dim invigilatorID As String =
                e.CommandArgument.ToString()

            Response.Redirect(
                "EditInvigilator.aspx?id=" & invigilatorID
            )

        ElseIf e.CommandName = "DeleteInvigilator" Then

            Dim invigilatorID As Integer =
                Convert.ToInt32(e.CommandArgument)

            DeleteInvigilator(invigilatorID)

        End If

    End Sub


    '=============================
    ' DELETE INVIGILATOR
    '=============================
    Private Sub DeleteInvigilator(
        ByVal invigilatorID As Integer
        )

        Try

            Dim query As String =
                "DELETE FROM Invigilators " &
                "WHERE InvigilatorID = @InvigilatorID"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(
                New MySqlParameter(
                    "@InvigilatorID",
                    invigilatorID
                )
            )

            DatabaseHelper.ExecuteNonQuery(
                query,
                parameters
            )

            LoadInvigilators()
            LoadStatistics()

        Catch ex As Exception

            Response.Write(
                "<script>alert('Unable to delete invigilator. " &
                ex.Message.Replace("'", "\'") &
                "');</script>"
            )

        End Try

    End Sub

End Class
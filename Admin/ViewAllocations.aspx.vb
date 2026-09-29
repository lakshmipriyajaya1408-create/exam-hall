Imports System
Imports System.Data
Imports System.Collections.Generic
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class Admin_ViewAllocations

    Inherits System.Web.UI.Page


    '==========================================================
    ' PAGE LOAD
    '==========================================================

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        'Check login
        If Session("UserID") Is Nothing OrElse
           Session("Role") Is Nothing Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        'Only Admin can access this page
        If Session("Role").ToString() <> "Admin" Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        If Not IsPostBack Then

            txtSearch.Attributes.Add(
                "placeholder",
                "Search student, register number, exam, hall or department..."
            )

            LoadAllocations()
            LoadStatistics()

        End If

    End Sub


    '==========================================================
    ' LOAD ALLOCATIONS
    '==========================================================

    Private Sub LoadAllocations()

        Try

            Dim query As String =
                "SELECT " &
                "a.AllocationID, " &
                "a.ExamID, " &
                "e.ExamName, " &
                "e.Subject, " &
                "s.StudentID, " &
                "u.Name AS StudentName, " &
                "s.RegisterNumber, " &
                "s.Department, " &
                "s.`Year`, " &
                "h.HallName, " &
                "a.SeatNumber, " &
                "a.AllocationDate, " &
                "a.Status " &
                "FROM Allocations a " &
                "INNER JOIN Exams e " &
                "ON a.ExamID = e.ExamID " &
                "INNER JOIN Students s " &
                "ON a.StudentID = s.StudentID " &
                "INNER JOIN Users u " &
                "ON s.UserID = u.UserID " &
                "INNER JOIN Halls h " &
                "ON a.HallID = h.HallID " &
                "ORDER BY a.AllocationID DESC"


            Dim dt As DataTable =
                DatabaseHelper.GetDataTable(query)


            gvAllocations.DataSource = dt
            gvAllocations.DataBind()


        Catch ex As Exception

            ShowMessage(
                "Error loading allocations: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' LOAD STATISTICS
    '==========================================================

    Private Sub LoadStatistics()

        Try

            'Total allocations
            Dim totalQuery As String =
                "SELECT COUNT(*) FROM Allocations"


            'Active allocations
            Dim activeQuery As String =
                "SELECT COUNT(*) " &
                "FROM Allocations " &
                "WHERE Status = 'Active'"


            'Number of halls currently used
            Dim hallsQuery As String =
                "SELECT COUNT(DISTINCT HallID) " &
                "FROM Allocations " &
                "WHERE Status = 'Active'"


            Dim total As Object =
                DatabaseHelper.ExecuteScalar(totalQuery)


            Dim active As Object =
                DatabaseHelper.ExecuteScalar(activeQuery)


            Dim halls As Object =
                DatabaseHelper.ExecuteScalar(hallsQuery)


            lblTotalAllocations.Text =
                Convert.ToString(total)


            lblActiveAllocations.Text =
                Convert.ToString(active)


            lblHallsUsed.Text =
                Convert.ToString(halls)


        Catch ex As Exception

            ShowMessage(
                "Error loading statistics: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' SEARCH
    '==========================================================

    Protected Sub btnSearch_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs) _
                                  Handles btnSearch.Click

        Try

            Dim searchText As String =
                txtSearch.Text.Trim()


            'If search box is empty
            If searchText = "" Then

                LoadAllocations()
                LoadStatistics()

                Return

            End If


            Dim query As String =
                "SELECT " &
                "a.AllocationID, " &
                "a.ExamID, " &
                "e.ExamName, " &
                "e.Subject, " &
                "s.StudentID, " &
                "u.Name AS StudentName, " &
                "s.RegisterNumber, " &
                "s.Department, " &
                "s.`Year`, " &
                "h.HallName, " &
                "a.SeatNumber, " &
                "a.AllocationDate, " &
                "a.Status " &
                "FROM Allocations a " &
                "INNER JOIN Exams e " &
                "ON a.ExamID = e.ExamID " &
                "INNER JOIN Students s " &
                "ON a.StudentID = s.StudentID " &
                "INNER JOIN Users u " &
                "ON s.UserID = u.UserID " &
                "INNER JOIN Halls h " &
                "ON a.HallID = h.HallID " &
                "WHERE u.Name LIKE @Search " &
                "OR s.RegisterNumber LIKE @Search " &
                "OR e.ExamName LIKE @Search " &
                "OR e.Subject LIKE @Search " &
                "OR s.Department LIKE @Search " &
                "OR h.HallName LIKE @Search " &
                "OR a.SeatNumber LIKE @Search " &
                "OR a.Status LIKE @Search " &
                "ORDER BY a.AllocationID DESC"


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


            gvAllocations.DataSource = dt
            gvAllocations.DataBind()


        Catch ex As Exception

            ShowMessage(
                "Search error: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' CLEAR SEARCH
    '==========================================================

    Protected Sub btnClear_Click(ByVal sender As Object,
                                 ByVal e As System.EventArgs) _
                                 Handles btnClear.Click

        txtSearch.Text = ""

        lblMessage.Text = ""
        lblMessage.Visible = False


        LoadAllocations()
        LoadStatistics()

    End Sub


    '==========================================================
    ' GRIDVIEW ROW COMMAND
    '==========================================================

    Protected Sub gvAllocations_RowCommand(
        ByVal sender As Object,
        ByVal e As GridViewCommandEventArgs
    ) Handles gvAllocations.RowCommand


        Try

            If e.CommandName = "DeleteAllocation" Then

                Dim allocationID As Integer =
                    Convert.ToInt32(e.CommandArgument)


                DeleteAllocation(allocationID)

            End If


        Catch ex As Exception

            ShowMessage(
                "Error: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' DELETE ALLOCATION
    '==========================================================

    Private Sub DeleteAllocation(
        ByVal allocationID As Integer
    )

        Try

            Dim query As String =
                "DELETE FROM Allocations " &
                "WHERE AllocationID = @AllocationID"


            Dim parameters As New List(Of MySqlParameter)


            parameters.Add(
                New MySqlParameter(
                    "@AllocationID",
                    allocationID
                )
            )


            DatabaseHelper.ExecuteNonQuery(
                query,
                parameters
            )


            ShowMessage(
                "Allocation deleted successfully.",
                True
            )


            LoadAllocations()
            LoadStatistics()


        Catch ex As Exception

            ShowMessage(
                "Error deleting allocation: " & ex.Message,
                False
            )

        End Try

    End Sub


    '==========================================================
    ' STATUS CSS CLASS
    '==========================================================

    Public Function GetStatusClass(
        ByVal status As String
    ) As String


        If status Is Nothing Then

            Return "status-inactive"

        End If


        Select Case status.ToLower()

            Case "active"

                Return "status-active"


            Case "completed"

                Return "status-completed"


            Case Else

                Return "status-inactive"

        End Select

    End Function


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
                "message danger-message"

        End If

    End Sub

End Class
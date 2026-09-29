Imports MySql.Data.MySqlClient
Imports System.Data

Partial Class Student_HallAllocation
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Check student login
        If Session("UserID") Is Nothing OrElse Session("Role") Is Nothing Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        ' Only students can access this page
        If Session("Role").ToString() <> "Student" Then
            Response.Redirect("../Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadHallAllocation()
        End If

    End Sub


    Private Sub LoadHallAllocation()

        Try

            Dim userID As Integer = Convert.ToInt32(Session("UserID"))

            Dim query As String = ""

            query &= "SELECT "
            query &= "e.ExamName AS ExamName, "
            query &= "e.Subject AS SubjectName, "
            query &= "e.ExamDate AS ExamDateValue, "
            query &= "e.StartTime AS StartTimeValue, "
            query &= "e.EndTime AS EndTimeValue, "
            query &= "h.HallName AS HallName, "
            query &= "h.Building AS Building, "
            query &= "h.Floor AS Floor, "
            query &= "a.SeatNumber AS SeatNumber "
            query &= "FROM Allocations a "
            query &= "INNER JOIN Students s ON a.StudentID = s.StudentID "
            query &= "INNER JOIN Exams e ON a.ExamID = e.ExamID "
            query &= "INNER JOIN Halls h ON a.HallID = h.HallID "
            query &= "WHERE s.UserID = @UserID "
            query &= "AND a.Status = 'Active' "
            query &= "AND e.Status <> 'Cancelled' "
            query &= "ORDER BY e.ExamDate ASC, e.StartTime ASC"

            Dim parameters As New List(Of MySqlParameter)

            parameters.Add(New MySqlParameter("@UserID", userID))

            Dim dt As DataTable = DatabaseHelper.GetDataTable(query, parameters)


            If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then

                Dim row As DataRow = dt.Rows(0)

                ' Show allocation section
                pnlAllocation.Visible = True
                pnlNoAllocation.Visible = False


                ' ==========================
                ' EXAM NAME
                ' ==========================

                If row.Table.Columns.Contains("ExamName") Then

                    If Not IsDBNull(row("ExamName")) Then
                        lblExamName.Text = Convert.ToString(row("ExamName"))
                    Else
                        lblExamName.Text = "-"
                    End If

                Else
                    lblExamName.Text = "-"
                End If


                ' ==========================
                ' SUBJECT
                ' ==========================

                If row.Table.Columns.Contains("SubjectName") Then

                    If Not IsDBNull(row("SubjectName")) Then
                        lblSubject.Text = Convert.ToString(row("SubjectName"))
                    Else
                        lblSubject.Text = "-"
                    End If

                Else
                    lblSubject.Text = "-"
                End If


                ' ==========================
                ' EXAM DATE
                ' ==========================

                If row.Table.Columns.Contains("ExamDateValue") Then

                    If Not IsDBNull(row("ExamDateValue")) Then
                        lblExamDate.Text = Convert.ToDateTime(row("ExamDateValue")).ToString("dd-MM-yyyy")
                    Else
                        lblExamDate.Text = "-"
                    End If

                Else
                    lblExamDate.Text = "-"
                End If


                ' ==========================
                ' EXAM TIME
                ' ==========================

                If Not IsDBNull(row("StartTimeValue")) AndAlso
                   Not IsDBNull(row("EndTimeValue")) Then

                    Dim startTime As TimeSpan
                    Dim endTime As TimeSpan

                    startTime = CType(row("StartTimeValue"), TimeSpan)
                    endTime = CType(row("EndTimeValue"), TimeSpan)

                    lblExamTime.Text = startTime.ToString("hh\:mm") &
                                       " - " &
                                       endTime.ToString("hh\:mm")

                Else

                    lblExamTime.Text = "-"

                End If


                ' ==========================
                ' HALL
                ' ==========================

                If Not IsDBNull(row("HallName")) Then
                    lblHallName.Text = Convert.ToString(row("HallName"))
                Else
                    lblHallName.Text = "-"
                End If


                ' ==========================
                ' BUILDING
                ' ==========================

                If Not IsDBNull(row("Building")) Then
                    lblBuilding.Text = Convert.ToString(row("Building"))
                Else
                    lblBuilding.Text = "-"
                End If


                ' ==========================
                ' FLOOR
                ' ==========================

                If Not IsDBNull(row("Floor")) Then
                    lblFloor.Text = Convert.ToString(row("Floor"))
                Else
                    lblFloor.Text = "-"
                End If


                ' ==========================
                ' SEAT NUMBER
                ' ==========================

                If Not IsDBNull(row("SeatNumber")) Then
                    lblSeatNumber.Text = Convert.ToString(row("SeatNumber"))
                Else
                    lblSeatNumber.Text = "-"
                End If


            Else

                ' No allocation found
                pnlAllocation.Visible = False
                pnlNoAllocation.Visible = True

            End If


        Catch ex As Exception

            ' In case of an unexpected error,
            ' show the no-allocation message.
            pnlAllocation.Visible = False
            pnlNoAllocation.Visible = True

        End Try

    End Sub

End Class
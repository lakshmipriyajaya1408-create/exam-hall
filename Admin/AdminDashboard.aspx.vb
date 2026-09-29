Imports System
Imports MySql.Data.MySqlClient

Partial Class Admin_AdminDashboard

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        '=========================================================
        ' CHECK LOGIN
        '=========================================================

        If Session("UserID") Is Nothing Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        '=========================================================
        ' CHECK ADMIN ROLE
        '=========================================================

        If Session("Role") Is Nothing Then

            Session.Clear()

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        If Session("Role").ToString() <> "Admin" Then

            Response.Redirect("~/Account/Login.aspx")
            Return

        End If


        '=========================================================
        ' LOAD DASHBOARD
        '=========================================================

        If Not IsPostBack Then

            lblWelcome.Text = Session("Name").ToString()
            lblTopName.Text = Session("Name").ToString()

            LoadDashboardStatistics()

        End If

    End Sub


    '=============================================================
    ' LOAD DATABASE STATISTICS
    '=============================================================

    Private Sub LoadDashboardStatistics()

        Try

            Using con As MySqlConnection = DatabaseHelper.GetConnection()

                con.Open()


                '-------------------------------------------------
                ' STUDENTS
                '-------------------------------------------------

                Dim studentQuery As String =
                    "SELECT COUNT(*) FROM Students " &
                    "WHERE Status = 'Active'"

                Using cmd As New MySqlCommand(studentQuery, con)

                    lblStudentCount.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString()

                End Using


                '-------------------------------------------------
                ' EXAMS
                '-------------------------------------------------

                Dim examQuery As String =
                    "SELECT COUNT(*) FROM Exams"

                Using cmd As New MySqlCommand(examQuery, con)

                    lblExamCount.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString()

                End Using


                '-------------------------------------------------
                ' HALLS
                '-------------------------------------------------

                Dim hallQuery As String =
                    "SELECT COUNT(*) FROM Halls " &
                    "WHERE Status = 'Available'"

                Using cmd As New MySqlCommand(hallQuery, con)

                    lblHallCount.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString()

                End Using


                '-------------------------------------------------
                ' INVIGILATORS
                '-------------------------------------------------

                Dim invigilatorQuery As String =
                    "SELECT COUNT(*) FROM Invigilators " &
                    "WHERE Status = 'Active'"

                Using cmd As New MySqlCommand(invigilatorQuery, con)

                    lblInvigilatorCount.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString()

                End Using


            End Using


        Catch ex As Exception

            lblStudentCount.Text = "0"
            lblExamCount.Text = "0"
            lblHallCount.Text = "0"
            lblInvigilatorCount.Text = "0"

        End Try

    End Sub


    '=============================================================
    ' LOGOUT
    '=============================================================

    Protected Sub btnLogout_Click(ByVal sender As Object,
                                   ByVal e As System.EventArgs) Handles btnLogout.Click

        Session.Clear()
        Session.Abandon()

        Response.Redirect("~/Account/Login.aspx")

    End Sub

End Class

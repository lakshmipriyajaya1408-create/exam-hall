Imports System
Imports MySql.Data.MySqlClient

Partial Class Account_Login

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            lblMessage.Text = ""
        End If

    End Sub


    Protected Sub btnLogin_Click(ByVal sender As Object,
                                 ByVal e As System.EventArgs) Handles btnLogin.Click

        Dim email As String = txtEmail.Text.Trim()
        Dim password As String = txtPassword.Text.Trim()

        If email = "" Or password = "" Then

            lblMessage.Text = "Please enter email and password."
            Return

        End If


        Try

            Using con As MySqlConnection = DatabaseHelper.GetConnection()

                con.Open()

                Dim query As String

                query = "SELECT UserID, Name, Role, Status " &
                        "FROM Users " &
                        "WHERE Email = @Email " &
                        "AND Password = @Password " &
                        "LIMIT 1"

                Using cmd As New MySqlCommand(query, con)

                    cmd.Parameters.AddWithValue("@Email", email)
                    cmd.Parameters.AddWithValue("@Password", password)

                    Using reader As MySqlDataReader = cmd.ExecuteReader()

                        If reader.Read() Then

                            If reader("Status").ToString() <> "Active" Then

                                lblMessage.Text = "Your account is inactive."
                                Return

                            End If


                            Session("UserID") =
                                Convert.ToInt32(reader("UserID"))

                            Session("Name") =
                                reader("Name").ToString()

                            Session("Role") =
                                reader("Role").ToString()


                            Select Case reader("Role").ToString()

                                Case "Admin"

                                    Response.Redirect(
                                        "~/Admin/AdminDashboard.aspx")

                                Case "Student"

                                    Response.Redirect(
                                        "~/Student/StudentDashboard.aspx")

                                Case "Invigilator"

                                    Response.Redirect(
                                        "~/Invigilator/InvigilatorDashboard.aspx")

                                Case Else

                                    Session.Clear()

                                    lblMessage.Text =
                                        "Invalid user role."

                            End Select

                        Else

                            lblMessage.Text =
                                "Invalid email or password."

                        End If

                    End Using

                End Using

            End Using


        Catch ex As Exception

            lblMessage.Text =
                "Login error: " & ex.Message

        End Try

    End Sub

End Class
Imports System
Imports MySql.Data.MySqlClient

Partial Class _Default

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnTestConnection_Click(ByVal sender As Object,
                                          ByVal e As System.EventArgs) Handles btnTestConnection.Click

        Try

            Using con As MySqlConnection = DatabaseHelper.GetConnection()

                con.Open()

                lblMessage.Text = "MySQL Connection Successful!"

            End Using

        Catch ex As Exception

            lblMessage.Text = "MySQL Connection Failed: " & ex.Message

        End Try

    End Sub

End Class
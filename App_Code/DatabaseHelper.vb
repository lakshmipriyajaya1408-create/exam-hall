Imports System
Imports System.Configuration
Imports System.Data
Imports System.Collections.Generic
Imports MySql.Data.MySqlClient

Public Class DatabaseHelper

    '=========================================================
    ' GET DATABASE CONNECTION
    '=========================================================

    Public Shared Function GetConnection() As MySqlConnection

        Dim connectionString As String

        connectionString = ConfigurationManager.ConnectionStrings(
            "OnlineExamDBConnection"
        ).ConnectionString

        Return New MySqlConnection(connectionString)

    End Function


    '=========================================================
    ' GET DATATABLE
    '=========================================================

    Public Shared Function GetDataTable(
        ByVal query As String
    ) As DataTable

        Dim dt As New DataTable()

        Using con As MySqlConnection = GetConnection()

            Using cmd As New MySqlCommand(query, con)

                Using adapter As New MySqlDataAdapter(cmd)

                    adapter.Fill(dt)

                End Using

            End Using

        End Using

        Return dt

    End Function


    '=========================================================
    ' GET DATATABLE WITH PARAMETERS
    '=========================================================

    Public Shared Function GetDataTable(
        ByVal query As String,
        ByVal parameters As List(Of MySqlParameter)
    ) As DataTable

        Dim dt As New DataTable()

        Using con As MySqlConnection = GetConnection()

            Using cmd As New MySqlCommand(query, con)

                If parameters IsNot Nothing Then

                    For Each parameter As MySqlParameter In parameters

                        cmd.Parameters.Add(parameter)

                    Next

                End If

                Using adapter As New MySqlDataAdapter(cmd)

                    adapter.Fill(dt)

                End Using

            End Using

        End Using

        Return dt

    End Function


    '=========================================================
    ' EXECUTE SCALAR
    '=========================================================

    Public Shared Function ExecuteScalar(
        ByVal query As String
    ) As Object

        Using con As MySqlConnection = GetConnection()

            con.Open()

            Using cmd As New MySqlCommand(query, con)

                Return cmd.ExecuteScalar()

            End Using

        End Using

    End Function


    '=========================================================
    ' EXECUTE SCALAR WITH PARAMETERS
    '=========================================================

    Public Shared Function ExecuteScalar(
        ByVal query As String,
        ByVal parameters As List(Of MySqlParameter)
    ) As Object

        Using con As MySqlConnection = GetConnection()

            con.Open()

            Using cmd As New MySqlCommand(query, con)

                If parameters IsNot Nothing Then

                    For Each parameter As MySqlParameter In parameters

                        cmd.Parameters.Add(parameter)

                    Next

                End If

                Return cmd.ExecuteScalar()

            End Using

        End Using

    End Function


    '=========================================================
    ' EXECUTE NON QUERY
    '=========================================================

    Public Shared Function ExecuteNonQuery(
        ByVal query As String
    ) As Integer

        Using con As MySqlConnection = GetConnection()

            con.Open()

            Using cmd As New MySqlCommand(query, con)

                Return cmd.ExecuteNonQuery()

            End Using

        End Using

    End Function


    '=========================================================
    ' EXECUTE NON QUERY WITH PARAMETERS
    '=========================================================

    Public Shared Function ExecuteNonQuery(
        ByVal query As String,
        ByVal parameters As List(Of MySqlParameter)
    ) As Integer

        Using con As MySqlConnection = GetConnection()

            con.Open()

            Using cmd As New MySqlCommand(query, con)

                If parameters IsNot Nothing Then

                    For Each parameter As MySqlParameter In parameters

                        cmd.Parameters.Add(parameter)

                    Next

                End If

                Return cmd.ExecuteNonQuery()

            End Using

        End Using

    End Function

End Class
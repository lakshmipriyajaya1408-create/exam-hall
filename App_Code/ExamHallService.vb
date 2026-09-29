Imports System
Imports System.Data
Imports System.Web.Services
Imports System.Web.Services.Protocols

<WebService(Namespace:="http://exam-hall-system.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
Public Class ExamHallService
    Inherits System.Web.Services.WebService

    '=========================================================
    ' 1. GET ALL STUDENTS
    '=========================================================

    <WebMethod()> _
    Public Function GetAllStudents() As DataSet

        Dim ds As New DataSet()

        Dim query As String = _
            "SELECT s.StudentID, u.Name, s.RegisterNumber, " & _
            "s.Department, s.Year, s.Section, s.Status " & _
            "FROM Students s " & _
            "INNER JOIN Users u ON s.UserID = u.UserID " & _
            "ORDER BY s.StudentID"

        Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

        dt.TableName = "Students"

        ds.Tables.Add(dt)

        Return ds

    End Function


    '=========================================================
    ' 2. GET ALL EXAMINATIONS
    '=========================================================

    <WebMethod()> _
    Public Function GetAllExams() As DataSet

        Dim ds As New DataSet()

        Dim query As String = _
            "SELECT ExamID, ExamName, Subject, ExamDate, " & _
            "StartTime, EndTime, Department, Year, Status " & _
            "FROM Exams " & _
            "ORDER BY ExamDate, StartTime"

        Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

        dt.TableName = "Exams"

        ds.Tables.Add(dt)

        Return ds

    End Function


    '=========================================================
    ' 3. GET ALL EXAMINATION HALLS
    '=========================================================

    <WebMethod()> _
    Public Function GetAllHalls() As DataSet

        Dim ds As New DataSet()

        Dim query As String = _
            "SELECT HallID, HallName, Building, Floor, " & _
            "Capacity, Status " & _
            "FROM Halls " & _
            "ORDER BY HallID"

        Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

        dt.TableName = "Halls"

        ds.Tables.Add(dt)

        Return ds

    End Function


    '=========================================================
    ' 4. GET ALL HALL ALLOCATIONS
    '=========================================================

    <WebMethod()> _
    Public Function GetAllAllocations() As DataSet

        Dim ds As New DataSet()

        Dim query As String = _
            "SELECT a.AllocationID, " & _
            "u.Name AS StudentName, " & _
            "s.RegisterNumber, " & _
            "s.Department, " & _
            "s.Year, " & _
            "e.ExamName, " & _
            "e.Subject, " & _
            "e.ExamDate, " & _
            "e.StartTime, " & _
            "e.EndTime, " & _
            "h.HallName, " & _
            "h.Building, " & _
            "h.Floor, " & _
            "a.SeatNumber, " & _
            "a.Status " & _
            "FROM Allocations a " & _
            "INNER JOIN Students s ON a.StudentID = s.StudentID " & _
            "INNER JOIN Users u ON s.UserID = u.UserID " & _
            "INNER JOIN Exams e ON a.ExamID = e.ExamID " & _
            "INNER JOIN Halls h ON a.HallID = h.HallID " & _
            "ORDER BY e.ExamDate, h.HallName, a.SeatNumber"

        Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

        dt.TableName = "Allocations"

        ds.Tables.Add(dt)

        Return ds

    End Function


    '=========================================================
    ' 5. GET INVIGILATOR ASSIGNMENTS
    '=========================================================

    <WebMethod()> _
    Public Function GetInvigilatorAssignments() As DataSet

        Dim ds As New DataSet()

        Dim query As String = _
            "SELECT ei.AssignmentID, " & _
            "u.Name AS InvigilatorName, " & _
            "u.Email, " & _
            "i.Department, " & _
            "e.ExamName, " & _
            "e.Subject, " & _
            "e.ExamDate, " & _
            "e.StartTime, " & _
            "e.EndTime, " & _
            "h.HallName, " & _
            "h.Building, " & _
            "h.Floor, " & _
            "ei.Status " & _
            "FROM ExamInvigilators ei " & _
            "INNER JOIN Invigilators i " & _
            "ON ei.InvigilatorID = i.InvigilatorID " & _
            "INNER JOIN Users u " & _
            "ON i.UserID = u.UserID " & _
            "INNER JOIN Exams e " & _
            "ON ei.ExamID = e.ExamID " & _
            "INNER JOIN Halls h " & _
            "ON ei.HallID = h.HallID " & _
            "ORDER BY e.ExamDate, e.StartTime"

        Dim dt As DataTable = DatabaseHelper.GetDataTable(query)

        dt.TableName = "InvigilatorAssignments"

        ds.Tables.Add(dt)

        Return ds

    End Function

End Class
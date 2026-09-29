Partial Class Account_Logout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Clear all session data
        Session.Clear()
        Session.RemoveAll()
        Session.Abandon()

        ' Prevent browser from caching protected pages
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache)
        Response.Cache.SetNoStore()
        Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1))
        Response.Cache.SetRevalidation(System.Web.HttpCacheRevalidation.AllCaches)

        ' Redirect to login page
        Response.Redirect("Login.aspx", False)

        Context.ApplicationInstance.CompleteRequest()

    End Sub

End Class

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Assignment2
{
    public partial class Assignment2 : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {   
            Page page1 = Page as Login;

            if (page1 == null)
            {
                // if the user is not currently logged in
                if (Session["user"] == null)
                {                    
                    // check if the unlogged in user is at the default, login or sitemap pages
                    if (!HttpContext.Current.Request.Path.EndsWith("Default.aspx", StringComparison.InvariantCultureIgnoreCase) &&
                        !HttpContext.Current.Request.Path.EndsWith("Login.aspx", StringComparison.InvariantCultureIgnoreCase) &&
                        !HttpContext.Current.Request.Path.EndsWith("Sitemap.aspx", StringComparison.InvariantCultureIgnoreCase))
                    {
                        // redirect the user to the login page
                        Response.Redirect("Login.aspx?redirected=" + this.Request.Url.LocalPath, true);
                    }                
                }
            }
            
            if (Request.QueryString["login"] == "no")
            {
                Session.Clear();
                Response.Redirect("Default.aspx");
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["user"] != null)
            {
                lblUserStatus.Text = "Logged in as " + Session["user"].ToString();
                lnkLogin.Visible = false;
                lnkLogout.Visible = true;
            }

            else
            {
                lblUserStatus.Text = "You are not currently logged in.";
                lnkLogin.Visible = true;
                lnkLogout.Visible = false;
                
                // hide all navigation bar links except for home
                lnkPatient.Visible = false;
                lnkRegPatient.Visible = false;
                lnkVisit.Visible = false;
                lnkDoctors.Visible = false;
                lnkBed.Visible = false;
                lnkRegUser.Visible = false;
                lnkDoctorPatientInfo.Visible = false;
                lnkDischargePatient.Visible = false;
                lnkDatabaseTables.Visible = false;
            }
            
        }
    }
}
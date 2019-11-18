using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Assignment2.models;

namespace Assignment2
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["login"] == "no")
            {
                // end the session logging out the user
                Session.Clear();
                Response.Redirect("default.aspx", true);
            }
            /*
            if (Request.QueryString["login"] == "yes")

                lblDeniedAccess.Visible = true;
            else
                lblDeniedAccess.Visible = false;*/
        }
        
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // create new instance of the Hospital Entities
            HospitalEntities HospitalDB = new HospitalEntities();
            string passwordHashed = HashAlgorithms.GetSHA1Hash(txtPassword.Text);

            using(HospitalDB)
            {
                User loginUser = HospitalDB.Users.SingleOrDefault(u => u.Username == txtUsername.Text &&
                                                                  u.Password == passwordHashed);
           
                if(loginUser != null)
                {
                    Session["user"] = loginUser.Username;

                    if (Request.QueryString["redirected"] != null)
                        Server.Transfer(Request.QueryString["redirected"]);
                    else
                        Server.Transfer("default.aspx");
                }
                else
                {
                    lblLoginFail.Visible = true;
                }

            }
        }
    }
}
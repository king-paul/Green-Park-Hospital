using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// additional namespaces
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;


namespace Assignment2
{
    public partial class RegUser2 : System.Web.UI.Page
    {
        // assign connection strin to sql connection
        SqlConnection connection = new SqlConnection(
                WebConfigurationManager.ConnectionStrings["HospitalConnection"].ToString()
                );

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // runs when confirm registration is clicked
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // validate the page when button is clicked
            Page.Validate();

            // if the information in teh page is valid, continue
            if(Page.IsValid)
            {
                // create the user using information in textboxes
                CreateUser(txtUserName.Text, txtPassword.Text, txtEmailAddress.Text, false);
                
                
            }
        }

        // adds a user to the database
        protected void CreateUser(string userName, string password, string emailAddress, bool isAdmin)
        {
            string passwordHashed = HashAlgorithms.GetSHA1Hash(password);

            SqlCommand command = new SqlCommand("CreateNewUser", connection);

            // add values using stored procedure
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@username", userName);
            command.Parameters.AddWithValue("@password", passwordHashed);
            command.Parameters.AddWithValue("@EmailAddress", emailAddress);
            command.Parameters.AddWithValue("@isAdmin", isAdmin);

            connection.Open();

            // aattempt to execute the sql command
            if(command.ExecuteNonQuery() == 0)
            {
                throw new ApplicationException();
            }

            connection.Close();

            lblAccountCreated.Visible = true;
        }

        protected void UsernameValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            List<string> users = GetUserNames();

            args.IsValid = !users.Any(u => u.Equals(txtUserName.Text,
                StringComparison.CurrentCultureIgnoreCase));
        }

        private List<string> GetUserNames()
        {
            List<string> usernames = new List<string>();

            SqlCommand command = new SqlCommand("SELECT * FROM Users", connection);
            //command.CommandType = CommandType.Text;

            connection.Open();

            SqlDataReader dataReader = command.ExecuteReader();

            // while there are values left to read
            while(dataReader.Read())
            {
                usernames.Add(dataReader["Username"].ToString());
            }

            connection.Close();

            return usernames;
        }

    }

}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using Assignment2.models;

namespace Assignment2
{
    public partial class DischargePatient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string value = GridViewDischargePatient.SelectedRow.ToString();
            btnDischarge.Enabled = true;
        }

        protected void btnDischarge_Click(object sender, EventArgs e)
        {
            // pass all the data in the selected grid to session variables
            Session["Name"] = GridViewDischargePatient.SelectedRow.Cells[1].Text;
            Session["Ward Type"] = GridViewDischargePatient.SelectedRow.Cells[2].Text;
            Session["Bed Number"] = GridViewDischargePatient.SelectedRow.Cells[3].Text;
            Session["Rate Per Day"] = GridViewDischargePatient.SelectedRow.Cells[4].Text;
            Session["Date Assigned"] = GridViewDischargePatient.SelectedRow.Cells[5].Text;
            Session["Days In"] = GridViewDischargePatient.SelectedRow.Cells[6].Text;
            Session["Amount Payable"] = GridViewDischargePatient.SelectedRow.Cells[7].Text;

            try
            {
                // call method to return the bed id using the name
                int bedID = getBedID();

                // create a new sql connection
                SqlConnection HospitalConnection = new SqlConnection();
                // assign the connection string to the connection
                HospitalConnection.ConnectionString = ConfigurationManager.ConnectionStrings["HospitalConnection"].ConnectionString;

                SqlCommand command = new SqlCommand("DischargePatient", HospitalConnection);
                command.CommandType = CommandType.StoredProcedure;

                HospitalConnection.Open();
                command.Parameters.AddWithValue("@BedId", bedID);
                command.Parameters.AddWithValue("@DateOfDischarge", DateTime.Now);
            
                command.ExecuteNonQuery();
                HospitalConnection.Close();

                Response.Redirect("Invoice.aspx");
            }
            catch(SqlException ex)
            {
                lblErrorMassage.Visible = true;
                lblException.Text = ex.Message;
            }
            
        }

        private int getBedID()
        {
            using (HospitalEntities HospitalDB = new HospitalEntities())
            {
                string wardType = GridViewDischargePatient.SelectedRow.Cells[2].Text;
                int bedNumber = Int32.Parse(GridViewDischargePatient.SelectedRow.Cells[3].Text);

                return HospitalDB.Beds
                        .Where(at => at.Ward_Type == wardType
                            && at.Bed_Number == bedNumber)
                        .Select(at => at.BedID)
                        .SingleOrDefault(); 
            }
        }

    }
}
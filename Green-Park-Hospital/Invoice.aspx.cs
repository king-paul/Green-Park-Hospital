using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Configuration;

namespace Assignment2
{
    public partial class Invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Name"] != null)
            {
                // set all the labels to equal to session variables
                lblName.Text = Session["Name"].ToString();
                lblWard.Text = Session["Ward Type"].ToString();
                lblBedNumber.Text = Session["Bed Number"].ToString();
                lblRatePerDay.Text = Session["Rate Per Day"].ToString();
                lblDateIn.Text = Session["Date Assigned"].ToString();
                lblDaysIn.Text = Session["Days In"].ToString();
                lblTotalCost.Text = Session["Amount Payable"].ToString();

                // set the date of discharge to the current date
                lblDateOfDischarge.Text = DateTime.Now.ToString();
            }
            else
            {
                Response.Redirect("DischargePatient.aspx");
            }

            paymentConfirmation.Visible = false;
            
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            paymentSection.Visible = false;
            paymentConfirmation.Visible = true;
        }
    }
}
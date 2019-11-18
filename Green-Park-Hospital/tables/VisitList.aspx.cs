using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Assignment2.models;

namespace Assignment2
{
    public partial class PatientVisit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (HospitalEntities HospitalDB = new HospitalEntities())
            {
                GridViewVisits.DataSource = HospitalDB.VisitsViews.ToList();
                GridViewVisits.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DateTime? DateStart, DateEnd;
            try
            {
                DateStart = DateTime.ParseExact(txtDateStart.Text, "dd/MM/yyyy", null);
            }
            catch(FormatException)
            {
                DateStart = null;
            }
            try
            {
                DateEnd = DateTime.ParseExact(txtDateEnd.Text, "dd/MM/yyyy", null);
            }
            catch (FormatException)
            {
                DateEnd = null;
            }


            // use the hospital entites to get date
            using (HospitalEntities HospitalDB = new HospitalEntities())
            {
                // reference the VisitsView view in the databse
                IQueryable<VisitsView> visits = HospitalDB.VisitsViews;

                // if there is text in the name text box
                if (!String.IsNullOrWhiteSpace(txtName.Text))
                {
                    // return all names that contain the text in the texbox
                    visits = visits.Where(visit => visit.Patient_Name.Contains(txtName.Text));
                }

                if (rblDateType.SelectedIndex == 0) // if visit is selected
                {
                    // display appropriate records if start date or end date have a value          
                    if (DateStart.HasValue)
                    {
                        visits = visits.Where(visit => visit.Date_Of_Visit >= DateStart.Value);
                    }
                    if (DateEnd.HasValue)
                    {
                        visits = visits.Where(visit => visit.Date_Of_Visit <= DateEnd.Value);
                    }
                }
                else if (rblDateType.SelectedIndex == 1) // if discharge is selected
                {
                    // display appropriate records if start date or end date have a value          
                    if (DateStart.HasValue)
                    {
                        visits = visits.Where(visit => visit.Date_Of_Discharge >= DateStart.Value);
                    }
                    if (DateEnd.HasValue)
                    {
                        visits = visits.Where(visit => visit.Date_Of_Discharge <= DateEnd.Value);
                    }
                }

                // update the data in the gridview with the matches that were found
                GridViewVisits.DataSource = visits.ToList();
                GridViewVisits.DataBind();

            } // end using
           
        } // end of method

        protected void lblStatus_DataBinding(object sender, EventArgs e)
        {
            Label statusValue = sender as Label;

            VisitsView visit = GetDataItem() as VisitsView;

            statusValue.ForeColor = System.Drawing.Color.Black;

            if(visit.In_Patient == true)
            {
                statusValue.Text = "In";
            }
            else
            {
                statusValue.Text = "Out";
            }
        }

        protected void GridViewVisits_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewVisits.PageIndex = e.NewPageIndex;
            GridViewVisits.DataBind();
        }

    }
}
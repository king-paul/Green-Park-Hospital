using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Assignment2.models;

namespace Assignment2
{
    public partial class BedList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void lblStatus_DataBinding(object sender, EventArgs e)
        {
            Label statusValue = sender as Label;

            BedView bedList = GetDataItem() as BedView;

            statusValue.ForeColor = System.Drawing.Color.Black;

            if (bedList.Occupied == true)
            {
                statusValue.Text = "Yes";
            }
        }
    }
}
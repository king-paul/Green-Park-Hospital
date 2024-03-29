//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Assignment2.models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Visit
    {
        public int VisitID { get; set; }
        public int DoctorID { get; set; }
        public int PatientID { get; set; }
        public bool In_Patient { get; set; }
        public Nullable<int> BedID { get; set; }
        public System.DateTime Date_Of_Visit { get; set; }
        public Nullable<System.DateTime> Date_Of_Discharge { get; set; }
        public string Symptoms { get; set; }
        public string Disease { get; set; }
        public string Treatment { get; set; }
    
        public virtual Bed Bed { get; set; }
        public virtual Doctor Doctor { get; set; }
        public virtual Patient Patient { get; set; }
    }
}

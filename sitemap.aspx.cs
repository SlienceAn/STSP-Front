using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_sitemap : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("datamap.aspx");
        if (!IsPostBack)
        {
            area.SelectedValue = "1";
            cclass.SelectedValue = "1";
            ViewState["item"] = "2354";
           
            Session["area"] = "1";
            Session["typeclass"] = "1";
            Session["item"] = "2354";
            Session["time"] = DateTime.Now.AddYears(1).AddYears(int.Parse(time.SelectedValue) * (-1)).Year.ToString();
            Session["time2"] = DateTime.Now.AddYears(1).Year.ToString();
            
       
        }
       
    }
    protected void time_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (time.SelectedValue == "0")
        {
            year1.Enabled = true;
            year2.Enabled = true;
        }
        else
        {
            year1.Enabled = false;
            year2.Enabled = false;
        }

    }
    protected void year1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void year2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void search_Click(object sender, EventArgs e)
    {
        Session["area"] = area.SelectedValue;
        Session["typeclass"] = cclass.SelectedValue;
        Session["item"] = item.SelectedValue;
     

        if (time.SelectedValue == "0")
        {
            Session["time"] = year1.SelectedValue + "-01-01 12:00:00.000";
            Session["time2"] = year2.SelectedValue + "-12-31 12:00:00.000";
        }
        else
        {
            Session["time"] = DateTime.Now.AddYears(1).AddYears(int.Parse(time.SelectedValue) * (-1)).Year.ToString();
            Session["time2"] = DateTime.Now.AddYears(1).Year.ToString();
        }


       
    }

    protected void area_DataBound(object sender, EventArgs e)
    {
        #region 抓封鎖的測站
        for (int i = 0; i < area.Items.Count; i++)
        {

        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = @"SELECT   [area_id] FROM [ShowToArea] where area_id=@area_id ";

          
            SqlCommand cmd = new SqlCommand(sql1, cn);
            cmd.Parameters.AddWithValue("area_id", area.Items[i].Value);
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();


            if (dr.Read())
            {

            }
            else
            {
                area.Items.Remove(area.Items[i]);
            }
        }

        }
        #endregion
      
    }
    protected void eid_DataBound(object sender, EventArgs e)
    {
        if (area.SelectedValue == "1")
        {
            for (int i = 1; i < cclass.Items.Count; i++)
            {

                using (SqlConnection cn = new SqlConnection(sin))
                {

                    string sql1 = @"SELECT   [class_id] FROM [ShowToFront] where area_id=1 and class_id=@class_id ";


                    SqlCommand cmd = new SqlCommand(sql1, cn);
                    cmd.Parameters.AddWithValue("class_id", cclass.Items[i].Value);
                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();


                    if (dr.Read())
                    {

                    }
                    else
                    {
                        cclass.Items.Remove(cclass.Items[i]);
                        i--;
                    }
                }

            }
        }
        else if (area.SelectedValue == "2")
        {
            for (int i = 1; i < cclass.Items.Count; i++)
            {

                using (SqlConnection cn = new SqlConnection(sin))
                {

                    string sql1 = @"SELECT   [class_id] FROM [ShowToFront] where area_id=2 and class_id=@class_id ";


                    SqlCommand cmd = new SqlCommand(sql1, cn);
                    cmd.Parameters.AddWithValue("class_id", cclass.Items[i].Value);
                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();


                    if (dr.Read())
                    {

                    }
                    else
                    {
                        cclass.Items.Remove(cclass.Items[i]);
                        i--;
                    }
                }

            }

        }
    }
    protected void item_DataBound(object sender, EventArgs e)
    {
        #region 抓封鎖的測站
        //for (int i = 0; i < item.Items.Count; i++)
        //{

        //    using (SqlConnection cn = new SqlConnection(sin))
        //    {

        //        string sql1 = @"SELECT   [item_id] FROM [ShowToItem] where area_id=@area_id and class_id=@class_id  and item_id=@item_id ";


        //        SqlCommand cmd = new SqlCommand(sql1, cn);
        //        cmd.Parameters.AddWithValue("area_id", area.SelectedValue);
        //        cmd.Parameters.AddWithValue("class_id", cclass.SelectedValue);
        //        cmd.Parameters.AddWithValue("item_id", item.Items[i].Value);
        //        cn.Open();
        //        SqlDataReader dr = cmd.ExecuteReader();


        //        if (dr.Read())
        //        {

        //        }
        //        else
        //        {
        //            item.Items.Remove(item.Items[i]);
        //            i--;
        //        }

        //    }

        //}
        #endregion
        if (!IsPostBack)
        {
          
            item.SelectedValue = ViewState["item"].ToString();
        }
    }
   
    protected void area_SelectedIndexChanged(object sender, EventArgs e)
    {
        cclass.DataBind();
    }
}
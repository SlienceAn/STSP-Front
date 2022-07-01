using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_onlimitdata : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
    string excel_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        int o = 0;
        if (Request.QueryString["id"] != null)
        {
            if (int.TryParse(Request.QueryString["id"].ToString(), out o))
            {
                excel_id = Request.QueryString["id"].ToString();
            }
        }
        if (!IsPostBack)
        {
            string class_id = "";
            #region 類別
            using (SqlConnection cn = new SqlConnection(sin))
            {

                string sql1 = @"SELECT  [excel_id]
                                  ,[excel_name]
                                  ,[excel_filepath]
                                  ,[area_id]
                                  ,[plan_id]
                                  ,[class_id]
                                  ,[upload_time]
                                  ,[status]
                              FROM [excel] where excel_id=@excel_id";


                SqlCommand cmd = new SqlCommand(sql1, cn);
                cmd.Parameters.AddWithValue("excel_id", excel_id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();


                while (dr.Read())
                {
                    class_id = dr["class_id"].ToString();

                }
            }
            #endregion
            SqlDataSource1.SelectCommand += @"  and t1.class = " + class_id;

            SqlDataSource1.SelectCommand += @" order by item_id ";
            dsearch();
        }
    }
    protected void dsearch()
    {
      
        SqlDataSource5.SelectCommand += @" and excel_id=" + excel_id;
        if (item.SelectedValue != "0" && item.SelectedValue != "")
            SqlDataSource5.SelectCommand += " and t5.itemNameSys = '" + item.SelectedItem.Text + "'";

        if (time.SelectedValue == "0" && time.SelectedValue == "")
        {
            SqlDataSource5.SelectCommand += " and t1.time > '" + year1.SelectedItem.Text + "'";
            SqlDataSource5.SelectCommand += " and t1.time < '" + year2.SelectedItem.Text + "'";
        }
        else
        {
            SqlDataSource5.SelectCommand += " and t1.time > '" + DateTime.Now.AddYears(1).AddYears(int.Parse(time.SelectedValue) * (-1)).Year.ToString() + "'";
            SqlDataSource5.SelectCommand += " and t1.time < '" + DateTime.Now.AddYears(1).Year.ToString() + "'";

        }
        GridView1.DataBind();
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            DataView dt = (DataView)SqlDataSource5.Select(new DataSourceSelectArguments());
            lblDataCount.Text = lblDataCount2.Text = dt.Table.Rows.Count.ToString();

            lblPageIndex.Text = lblPageIndex2.Text = GridView1.PageIndex + 1 + "/" + GridView1.PageCount;
            if (GridView1.PageCount > 0)
            {
                GridView1.BottomPagerRow.Visible = false;         //'隱藏分頁欄
            }
            if (GridView1.PageIndex == 0 & GridView1.PageCount == 1)
            {
                this.lkbPagePrev.Enabled = lkbPagePrev2.Enabled = false;
                this.lkbPageNext.Enabled = lkbPageNext2.Enabled = false;
            }
            else if (GridView1.PageIndex == 0)
            {
                this.lkbPagePrev.Enabled = lkbPagePrev2.Enabled = false;
                this.lkbPageNext.Enabled = lkbPageNext2.Enabled = true;
            }
            else if (GridView1.PageIndex == GridView1.PageCount - 1)
            {
                this.lkbPageNext.Enabled = lkbPageNext2.Enabled = false;
                this.lkbPagePrev.Enabled = lkbPagePrev2.Enabled = true;
            }
            else
            {
                this.lkbPagePrev.Enabled = lkbPagePrev2.Enabled = true;
                this.lkbPageNext.Enabled = lkbPageNext2.Enabled = true;
            }
            ddlPageIndex.Items.Clear();
            ddlPageIndex2.Items.Clear();
            for (int i = 0; i < GridView1.PageCount; i++)
            {
                ddlPageIndex.Items.Add(new ListItem((i + 1).ToString(), i.ToString()));
                ddlPageIndex2.Items.Add(new ListItem((i + 1).ToString(), i.ToString()));
            }
            ddlPageIndex2.SelectedValue = (GridView1.PageIndex).ToString();
            ddlPageIndex.SelectedValue = (GridView1.PageIndex).ToString();
        }

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {


        }
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlPageSize2.SelectedValue = ddlPageSize.SelectedValue;
        GridView1.PageSize = int.Parse(ddlPageSize.SelectedValue);
        
        dsearch();
    }
    protected void ddlPageSize2_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlPageSize.SelectedValue = ddlPageSize2.SelectedValue;
        GridView1.PageSize = int.Parse(ddlPageSize.SelectedValue);
        
        dsearch();
    }
    protected void ddlPageIndex_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList d = (DropDownList)sender;
        GridView1.PageIndex = int.Parse(d.SelectedValue);
        GridView1.DataBind();
    
        dsearch();
    }
    protected void lkbPagePrev_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex -= 1;
        GridView1.DataBind();
     
        dsearch();
    }
    protected void lkbPageNext_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex += 1;
        GridView1.DataBind();
       
        dsearch();
    }
    protected void gvShow_PageIndexChanged(object sender, EventArgs e)
    {
        dsearch();
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
        dsearch();
       
    }
    protected void year1_SelectedIndexChanged(object sender, EventArgs e)
    {
        dsearch();
     
    }
    protected void year2_SelectedIndexChanged(object sender, EventArgs e)
    {
        dsearch();
       
    }
    protected void item_SelectedIndexChanged(object sender, EventArgs e)
    {
        dsearch();
      
    }
      protected void search_Click(object sender, EventArgs e)
    {
        dsearch();

    }
}
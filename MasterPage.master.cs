using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_MasterPage : System.Web.UI.MasterPage
{
    string sin = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
    DataTable dss = new DataTable();
    int ek = 0;
    string[] ExamItemName = new string[1000];
    string[] ExamItemID = new string[1000];
    int ekt = 0;
    string[] ItemName = new string[1000];
    string[] ItemID = new string[1000];
    string[] ItemUnit = new string[1000];
    protected void Page_Load(object sender, EventArgs e)
    {
        var Url = Request.Url.AbsoluteUri;
        if (Url.IndexOf("sitemap.") >= 0 )
            Literal2.Text = " style='background-color:#91e620;border-top:3px inset #1f4306;' ";
        if (Url.IndexOf("Data_Site.") >= 0)
            Literal3.Text = " style='background-color:#91e620;border-top:3px inset #1f4306;' ";
      //  if (Url.IndexOf("AirQualityTreeMap2.") >= 0)
       //     Literal4.Text = " style='background-color:#91e620;border-top:3px inset #1f4306;' ";
      //  if (Url.IndexOf("sitemap.") >= 0)
        //       Literal2.Text = " style='background-color:#91e620;border-top:3px inset #1f4306;' ";
        if (Url.IndexOf("Download.") >= 0)
            Literal6.Text = " style='background-color:#91e620;border-top:3px inset #1f4306;' ";

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ViewState["aclass"] = "1";
       // confirm.Visible = true;
        search();
        Session.Add("dt", dss);

        string url = "Pdf_Print.aspx";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "window.open('" + url + "','','toolbar=no,menubar=yes,status=no,scrollbars=no,resizable=no,width=700,height=600');", true);
        Response.Redirect(url);
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        ViewState["aclass"] = "2";
        // confirm.Visible = true;
        search();
        Session.Add("dt", dss);

        string url = "Pdf_Print.aspx";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "window.open('" + url + "','','toolbar=no,menubar=yes,status=no,scrollbars=no,resizable=no,width=700,height=600');", true);
        Response.Redirect(url);
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        ViewState["aclass"] = "3";
        // confirm.Visible = true;
        search();
        Session.Add("dt", dss);

        string url = "Pdf_Print.aspx";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "window.open('" + url + "','','toolbar=no,menubar=yes,status=no,scrollbars=no,resizable=no,width=700,height=600');", true);
        Response.Redirect(url);
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        ViewState["aclass"] = "7";
        // confirm.Visible = true;
        search();
        Session.Add("dt", dss);

        string url = "PDF_Print.aspx";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "window.open('" + url + "','','toolbar=no,menubar=yes,status=no,scrollbars=no,resizable=no,width=700,height=600');", true);
        Response.Redirect(url);
    }
  
    protected void search()
    {


        dss.Columns.Clear();
        dss.Rows.Clear();
        dss.Columns.Add("測站名稱", typeof(string));
        dss.Columns.Add("採樣日期", typeof(string));
        dss.Columns.Add("採樣時間", typeof(string));
     //   dss.Columns.Add("階段", typeof(string));
        #region 測項欄位

        ekt = 0;
        ItemName.Initialize();
        ItemID.Initialize();
        using (SqlConnection cn = new SqlConnection(sin))
        {
            string sql1 = @"SELECT top 9 t1.[item_id]
			                                  ,[itemNameSys]
                                              ,[unit]
			                                FROM [tV_ItemClass] as t1
                                            inner join [ShowToItem] as t2 on t1.item_id=t2.item_id and t2.cause_id=1
			                                where ";
            sql1 += "  background is null and t1.class_id= '" + ViewState["aclass"].ToString() + "'";

            if (ViewState["aclass"].ToString() == "1")
                sql1 += " and t1.[item_id] in ('360','361','362','363','364','365','366','367','368','369')";

            if (ViewState["aclass"].ToString() == "2")
                sql1 += " and t1.[item_id] != '72' and [itemNameSys]!=''";

            SqlCommand cmd = new SqlCommand(sql1, cn);
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {
                try
                {
                    dss.Columns.Add(dr["itemNameSys"].ToString() + "_" + dr["unit"].ToString(), typeof(string));
                    ItemName[ekt] = dr["itemNameSys"].ToString();
                    ItemID[ekt] = dr["item_id"].ToString();
                    ItemUnit[ekt] = dr["unit"].ToString();
                    ekt++;
                }
                catch { }

            }


            cn.Close();
        }
        //單位
        DataRow newrowu = dss.NewRow();
        newrowu[dss.Columns[0].ColumnName] = "";
        newrowu[dss.Columns[1].ColumnName] = "";
        newrowu[dss.Columns[2].ColumnName] = "";
        for (int i = 3; i < dss.Columns.Count; i++)
        {
            newrowu[dss.Columns[i].ColumnName] = ItemUnit[i - 3];
        }
        dss.Rows.Add(newrowu);
        #endregion
        #region 資料

        ekt = 0;
        ItemName.Initialize();
        ItemID.Initialize();
        using (SqlConnection cn = new SqlConnection(sin))
        {
            string sql1 = @"SELECT  distinct [site]
				                    ,t2.siteName
				                    ,[time]
                              
			                    FROM [Data] as t1 
			                    inner join DetectSite_A as t2
			                    on t1.site=t2.site_id  
			                    where 1=1
			                    and   t1.class=@class and t1.dele=0 
                              ";


            sql1 += " and t1.time > '" + DateTime.Now.AddYears(-2).ToShortDateString() + "'";
            sql1 += " and t1.time < '" + DateTime.Now.ToShortDateString() + "'";




            SqlCommand cmd = new SqlCommand(sql1, cn);
        
            cmd.Parameters.Add("class", ViewState["aclass"].ToString());

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {
                DataRow newrow = dss.NewRow();

                newrow[dss.Columns[0].ColumnName] = dr["siteName"].ToString();
                newrow[dss.Columns[1].ColumnName] = DateTime.Parse(dr["time"].ToString()).ToShortDateString();
                newrow[dss.Columns[2].ColumnName] = DateTime.Parse(dr["time"].ToString()).ToShortTimeString();
              //  newrow[dss.Columns[3].ColumnName] = dr["val"].ToString();

                getbasedata(dr["site"].ToString(), dr["time"].ToString(), newrow);
                dss.Rows.Add(newrow);


                Session["area"] = "";
                Session["typeclass"] = ViewState["aclass"].ToString();
                Session["show_area"] = "全部";

                if (ViewState["aclass"].ToString() == "1")
                    Session["show_typeclass"] = "空氣品質";
                if (ViewState["aclass"].ToString() == "2")
                    Session["show_typeclass"] = "地面水";
                if (ViewState["aclass"].ToString() == "3")
                    Session["show_typeclass"] = "放流水";
                Session["show_item"] = "全部";

                Session["show_time1"] = DateTime.Now.AddYears(-2).ToShortDateString();
                Session["show_time2"] = DateTime.Now.ToShortDateString();

            }


            cn.Close();
        }



        #endregion

    }
    private void getbasedata(string site, string time, DataRow newrow)
    {
        #region 資料

        ekt = 0;
        ItemName.Initialize();
        ItemID.Initialize();
        using (SqlConnection cn = new SqlConnection(sin))
        {
            string sql1 = @"SELECT [data_id]
                                  ,[excel_id]
                                  ,[area]
                                  ,[cause]
                                  ,[class]
                                  ,[site]
                                  ,t2.siteName
                                  ,t3.itemNameSys
                                  ,[time]
                                  ,[val],[val_num]
                              FROM [Data] as t1 
                              inner join DetectSite_A as t2
                              on t1.site=t2.site_id  
                              inner join Detect_Item as t3
                              on t1.item=t3.item_id  
                              where  site=@site and t1.time=@time and t1.dele=0 and t1.cause=1
                              ";
            SqlCommand cmd = new SqlCommand(sql1, cn);
            cmd.Parameters.Add("site", site);
            cmd.Parameters.Add("time", DateTime.Parse(time));
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {
                for (int i = 0; i < dss.Columns.Count; i++)
                {
                    if (dr["itemNameSys"].ToString() == dss.Columns[i].ColumnName.Split('_')[0])
                        newrow[dss.Columns[i].ColumnName] = dr["val"].ToString();
                }
            }
            cn.Close();
        }
        #endregion
    }
}

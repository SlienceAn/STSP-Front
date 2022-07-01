using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class index_datamap : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            area.SelectedValue = "1";
            cclass.SelectedValue = "1";
            ViewState["item"] = "247";//1159 

            Session["area"] = "1";
            Session["typeclass"] = "1";
            //  Session["item"] = "1159";
            Session["time"] = DateTime.Now.AddYears(1).AddYears(int.Parse(time.SelectedValue) * (-2)).Year.ToString();
            Session["time2"] = DateTime.Now.AddYears(1).Year.ToString();
            ViewState["start"] = "";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "BE", @"                            
                             document.getElementById('ContentPlaceHolder1_search').click();
                                   ", true);

        }


    }
    protected void search_Click(object sender, EventArgs e)
    {
        Session["area"] = area.SelectedValue;
        Session["typeclass"] = cclass.SelectedValue;
        Session["item"] = item.SelectedValue;
        ViewState["item"] = item.SelectedValue;

        if (time.SelectedValue == "0")
        {
            Session["time"] = year1.SelectedValue + "-01-01 12:00:00.000";
            Session["time2"] = year2.SelectedValue + "-12-31 12:00:00.000";
        }
        else
        {
            Session["time"] = DateTime.Now.AddYears(0).AddYears(int.Parse(time.SelectedValue) * (-1)).Year.ToString();
            Session["time2"] = DateTime.Now.AddYears(1).Year.ToString();
        }

        if (ViewState["start"].ToString() == "")
            ScriptManager.RegisterStartupScript(this, this.GetType(), "AE", @"
                       if($(window).width()>991)     
                    {showModal();}
                                   ", true);
        if (cclass.SelectedValue != "0")
        {
            if (item.SelectedValue != "0")
                showdata();
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", @"alert('請選擇項目');", true);

        }
        else
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", @"alert('請選擇類別');", true);


       
    }

    protected void report_Click(object sender, EventArgs e)
    {
        rsearch();
        Session.Add("dt", dss);

        string url = "PDF_Print.aspx";

        Response.Redirect(url);
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
    protected void area_DataBound(object sender, EventArgs e)
    {
        #region 抓封鎖的測站
        //for (int i = 0; i < area.Items.Count; i++)
        //{

        //    using (SqlConnection cn = new SqlConnection(sin))
        //    {

        //        string sql1 = @"SELECT   [area_id] FROM [ShowToArea] where area_id=@area_id ";


        //        SqlCommand cmd = new SqlCommand(sql1, cn);
        //        cmd.Parameters.AddWithValue("area_id", area.Items[i].Value);
        //        cn.Open();
        //        SqlDataReader dr = cmd.ExecuteReader();


        //        if (dr.Read())
        //        {

        //        }
        //        else
        //        {
        //            area.Items.Remove(area.Items[i]);
        //        }
        //    }

        //}
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

                    string sql1 = @"SELECT   [class_id] FROM [ShowToFront] where area_id=1 and class_id=@class_id  and cause_id=1";


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

                    string sql1 = @"SELECT   [class_id] FROM [ShowToFront] where area_id=2 and class_id=@class_id  and cause_id=1";


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

        item.DataBind();
    }
    protected void item_DataBound(object sender, EventArgs e)
    {
        #region 抓封鎖的測站
        for (int i = 0; i < item.Items.Count; i++)
        {

            using (SqlConnection cn = new SqlConnection(sin))
            {

                string sql1 = @"SELECT   [item_id] FROM [ShowToItem] where area_id=@area_id and class_id=@class_id  and item_id=@item_id  and cause_id=1";


                SqlCommand cmd = new SqlCommand(sql1, cn);
                cmd.Parameters.AddWithValue("area_id", area.SelectedValue);
                cmd.Parameters.AddWithValue("class_id", cclass.SelectedValue);
                cmd.Parameters.AddWithValue("item_id", item.Items[i].Value);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();


                if (dr.Read())
                {

                }
                else
                {
                    item.Items.Remove(item.Items[i]);
                    i--;
                }

            }

        }
        #endregion


        #region

        for (int i =1; i < item.Items.Count; i++)
        {
            using (SqlConnection cn = new SqlConnection(sin))
            {

                string sql1 = @"SELECT top 1  [data_id] FROM [Data] where [item]=" + item.Items[i].Value + @" and [area]=" + area.SelectedValue + @" and [class]=" + cclass.SelectedValue + @" and [dele]=0  and [cause]=1";
                 

                SqlCommand cmd = new SqlCommand(sql1, cn);
                cmd.Parameters.AddWithValue("item", item.Items[i].Value);
                cmd.Parameters.AddWithValue("class", cclass.SelectedValue);
                cmd.Parameters.AddWithValue("area", area.SelectedValue);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();


                if (dr.Read())
                {
                //    Response.Write("1:" + item.Items[i].Text + item.Items[i].Value + sql1 + "<br>");
                }
                else
                {
                //    Response.Write("2:" + item.Items[i].Text + item.Items[i].Value + "<br>");
                    item.Items.Remove(item.Items[i]);
                    i--;
                }
            }
        
        
        }

        #endregion

            if (!IsPostBack)
            {
                if (ViewState["item"]!=null)
                item.SelectedValue = ViewState["item"].ToString();
            }
    }

    protected void area_SelectedIndexChanged(object sender, EventArgs e)
    {
        cclass.DataBind();
    }


    protected void showdata()
    {
        if (Session["area"] == null)
        {
            Session["area"] = Session["typeclass"] = 1;
            Session["item"] = Session["item"].ToString();
            Session["time"] = "2014-01-01 12:00:00.000";
            Session["time2"] = "2015-01-01 12:00:00.000";
        }
        string area = Session["area"].ToString();
        string typeclass = Session["typeclass"].ToString();
        string item = Session["item"].ToString();
        string time = Session["time"].ToString();
        double maxx = 0, maxy = 0, minx = 999999999, miny = 999999999;
        site.Value = "";
        using (SqlConnection cn = new SqlConnection(sin))
        {
            string sql1 = @"SELECT distinct [site_id],
                            (Select top 1 [area_name] from [C_Detect_Area] where [C_Detect_Area].[area_id]=[DetectSite_A].area_id)as [area],
                            (Select top 1 [class_name] from [C_Detect_Class] where [C_Detect_Class].[class_id]=[DetectSite_A].[class_id]) as [class],[siteName],[gis_x],[gis_y],
                            (SELECT top 1 [itemName] from [Detect_Item] where [item_id]=@item)as [item],
						    (SELECT top 1 t2.[unit] from [Detect_Item] as t1 inner join Detect_ClassItmeMapping as t2 on t1.item_id=t2.item_id where t1.[item_id]=@item) as [unit] ,
                            (SELECT top 1 [up_limit]+t1.[unit]  FROM [law_data] as t1 inner join Detect_ClassItmeMapping as t2 on t1.CIM_id=t2.CIM_id inner join law as t3 on t1.law_id=t3.law_id  where t2.item_id = @item and t2.class_id=@typeclass and t3.law_class_id=2 and t3.plan_id=1) as [up_law],
                            (SELECT top 1 [down_limit]+t1.[unit] FROM [law_data] as t1 inner join Detect_ClassItmeMapping as t2 on t1.CIM_id=t2.CIM_id inner join law as t3 on t1.law_id=t3.law_id  where t2.item_id = @item and t2.class_id=@typeclass and t3.law_class_id=2 and t3.plan_id=1) as [down_law]


                             FROM [DetectSite_A] Where [site_id] in
                            (SELECT DISTINCT [site] FROM [Data] where [area]=@area and [class]=@typeclass and [cause]=1 and [item]=@item and [time] >= @time and [time] < @time2 and val!=''  ) and [area_id]=@area and [class_id]=@typeclass";
            SqlCommand cmd = new SqlCommand(sql1, cn);
            cmd.Parameters.AddWithValue("@area", area);
            cmd.Parameters.AddWithValue("@typeclass", typeclass);
            cmd.Parameters.AddWithValue("@item", item);
            cmd.Parameters.AddWithValue("@time", time);
            cmd.Parameters.AddWithValue("@time2", Session["time2"].ToString());

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                if (dr["gis_x"].ToString() != "" && dr["gis_y"].ToString() != "")
                {
                    if (minx > Convert.ToDouble(dr["gis_x"].ToString()))
                        minx = Convert.ToDouble(dr["gis_x"].ToString());
                    if (maxx < Convert.ToDouble(dr["gis_x"].ToString()))
                        maxx = Convert.ToDouble(dr["gis_x"].ToString());
                    if (miny > Convert.ToDouble(dr["gis_y"].ToString()))
                        miny = Convert.ToDouble(dr["gis_y"].ToString());
                    if (maxy < Convert.ToDouble(dr["gis_y"].ToString()))
                        maxy = Convert.ToDouble(dr["gis_y"].ToString());

                  /*  string law_unit = "";
                    if (dr["law_unit"].ToString() != "")
                        law_unit = "(" + dr["law_unit"].ToString() + ")";
                    else
                        law_unit = "-";*/

                    string up_law = "";
                    if (dr["up_law"].ToString() != "")
                        up_law = "上限值：" + dr["up_law"].ToString()+" ";
                    else
                        up_law = "-";

                    string down_law = "";
                    if (dr["down_law"].ToString() != "")
                        down_law = "下限值：" + dr["down_law"].ToString();
                    else
                        down_law = "-";


                    site.Value += dr["site_id"].ToString() + ","
                    + dr["area"].ToString() +
                    "," + dr["class"].ToString() +
                    "," + dr["siteName"].ToString() +
                    "," + dr["area"].ToString() +
                    "," + dr["gis_x"].ToString() +
                    "," + dr["gis_y"].ToString() +
                    "," + dr["item"].ToString().Replace(",", "_") +
                    "," + dr["unit"].ToString() +
                    "," + up_law +
                    "," + down_law + ",";



                }
            }
            cn.Close();
        }
        if (ViewState["start"].ToString() == "1")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SE", @"
                             
                               $('#lengel').toggle();
                               $('#watericon').attr('src', 'image/open.png');
                               c = 1;
                               
                            


                                   ", true);


        }
        if (site.Value == "")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "nopoint", @"
                             
                        alert('查無資料');

                                   ", true);


        }


        ViewState["start"] = "1";

    }
    protected void data_Click(object sender, EventArgs e)
    {
        string ar = area.SelectedValue;
        string tc = cclass.SelectedValue;
        string it = item.SelectedValue;
        string tt = "";
        string tt2 = "";
        if (time.SelectedValue == "0")
        {
            tt = year1.SelectedValue + "-01-01 00:00:00.000";
            tt2 = year2.SelectedValue + "-12-31 23:59:59.000";
        }
        else
        {
            tt = DateTime.Now.AddYears(1).AddYears(int.Parse(time.SelectedValue) * (-1)).Year.ToString();
            tt2 = DateTime.Now.AddYears(1).Year.ToString();
        }
        string a = "", b = "", c = "";
        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = @"SELECT [time],[val_num],[val] FROM [Data] where [cause] = 1 and [area]='" + ar + @"' and [class]='" + tc + @"' and [item]='" + it + @"' and [time] >= '" + tt + @"' and [time] < '" + tt2 + @"' and [site] = '" + HiddenField4.Value + @"' and val!='' order by [time]  ";
            SqlCommand cmd = new SqlCommand(sql1, cn);
            //cmd.Parameters.AddWithValue("@area", area);
            //cmd.Parameters.AddWithValue("@typeclass", tc);
            //cmd.Parameters.AddWithValue("@item", item);
            //cmd.Parameters.AddWithValue("@time", time);
            //cmd.Parameters.AddWithValue("@time2", tt2);
            //cmd.Parameters.AddWithValue("@site", HiddenField4.Value);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                double temp = 0;
                double o = 0;



                if (double.TryParse(dr["val"].ToString().Replace("<", "-"), out o))
                {
                    temp = double.Parse(dr["val"].ToString().Replace("<", "-"));

                    if (temp < 0)
                        temp = 0;
                }

                if (dr["val"].ToString() == "ND" || dr["val"].ToString().IndexOf("<") != -1)
                    c += "red,";
                else
                    c += "blue,";

                a += Convert.ToDateTime(dr["time"].ToString()).ToString("yyyy/MM/dd") + ",";
                b += temp + ",";
                // HiddenField3.Value = Convert.ToDateTime(dr["time"].ToString()).ToString("yyyy");
            }

            cn.Close();
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "AE", @"
            //
            //                           alert('" + Session["item"].ToString() + @"');
            //                            
            //
            //
            //                                   ", true);

            try
            {
                HiddenField1.Value = a.Substring(0, a.Length - 1);
            }
            catch{ }
            HiddenField2.Value = b.Substring(0, b.Length - 1);

            HiddenField6.Value = c.Substring(0, c.Length - 1);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "EAt", @"test();", true);
        }


    }


    protected void rsearch()
    {
        Session["area"] = area.SelectedValue;
        Session["typeclass"] = cclass.SelectedValue;
        Session["item"] = item.SelectedValue;
        ViewState["item"] = item.SelectedValue;

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
            string sql1 = @"SELECT distinct t1.[item_id]
			                                  ,[itemNameSys]
                                              ,[unit]
			                                FROM [tV_ItemClass] as t1
			                                where ";
            sql1 += "  background is null and t1.class_id= '" + cclass.SelectedValue + "'";
            sql1 += " and  t1.item_id = @item ";

            SqlCommand cmd = new SqlCommand(sql1, cn);
            cmd.Parameters.AddWithValue("@item", Session["item"].ToString());
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
            string sql1 = @"SELECT [data_id]
                                  ,[excel_id]
                                  ,[area]
                                  ,[cause]
                                  ,[class]
                                  ,[site]
                                  ,t2.siteName
                                  ,[time]
                                  ,[val]
                              FROM [Data] as t1 
                              inner join DetectSite_A as t2
                              on t1.site=t2.site_id  
                              where t1.dele=0 
                              and  t1.area=@area and t1.class=@typeclass and  t1.item = @item and time>=@stime and time<@etime and t1.[cause]=1
                              ";


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


            Session["show_area"] = area.SelectedItem.Text;
            Session["show_typeclass"] = cclass.SelectedItem.Text;
            Session["show_item"] = item.SelectedItem.Text;
            Session["show_time1"] = Session["time"].ToString();
            Session["show_time2"] = Session["time2"].ToString();

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cmd.Parameters.AddWithValue("@area", Session["area"].ToString());
            cmd.Parameters.AddWithValue("@typeclass", Session["typeclass"].ToString());
            cmd.Parameters.AddWithValue("@item", Session["item"].ToString());
            cmd.Parameters.AddWithValue("@stime", Session["time"].ToString());
            cmd.Parameters.AddWithValue("@etime", Session["time2"].ToString());
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
                              where  site=@site and t1.time=@time and t1.dele=0 and t1.[cause]=1
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
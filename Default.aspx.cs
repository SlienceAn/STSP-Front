using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    string conn = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["area"] == null)
        { 
        Session["area"] = Session["typeclass"] = 1;
        Session["item"] = 1128;
        Session["time"] = "2014-01-01 12:00:00.000";
        Session["time2"] = "2015-01-01 12:00:00.000";
        }
        string area = Session["area"].ToString();
        string typeclass = Session["typeclass"].ToString();
        string item = Session["item"].ToString();
        string time = Session["time"].ToString();
        double maxx = 0, maxy = 0, minx = 999999999, miny = 999999999;

        using (SqlConnection cn = new SqlConnection(conn))
        {
            string sql1 = @"SELECT [site_id],
                            (Select [area_name] from [C_Detect_Area] where [C_Detect_Area].[area_id]=[DetectSite_A].area_id)as [area],
                            (Select [class_name] from [C_Detect_Class] where [C_Detect_Class].[class_id]=[DetectSite_A].[class_id]) as [class],[siteName],[gis_x],[gis_y],
                            (SELECT [itemName] from [Detect_Item] where [item_id]=@item)as [item],
						    (SELECT t2.[unit] from [Detect_Item] as t1 inner join Detect_ClassItmeMapping as t2 on t1.item_id=t2.item_id where t1.[item_id]=@item) as [unit] ,
                            (SELECT [up_limit]  FROM [law_data] as t1 inner join Detect_ClassItmeMapping as t2 on t1.CIM_id=t2.CIM_id where t2.item_id = @item and t2.class_id=@typeclass) as [law],
                            (SELECT t1.[unit] FROM [law_data] as t1 inner join Detect_ClassItmeMapping as t2 on t1.CIM_id=t2.CIM_id where t2.item_id = @item and t2.class_id=@typeclass) as [law_unit]


                             FROM [DetectSite_A] Where [site_id] in
                            (SELECT DISTINCT [site] FROM [Data] where [area]=@area and [class]=@typeclass and [item]=@item and [time] >= @time and val!='')";
            SqlCommand cmd = new SqlCommand(sql1, cn);
            cmd.Parameters.AddWithValue("@area", area);
            cmd.Parameters.AddWithValue("@typeclass", typeclass);
            cmd.Parameters.AddWithValue("@item", item);
            cmd.Parameters.AddWithValue("@time", time);

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

                    string law_unit = "";
                    if (dr["law_unit"].ToString() != "")
                        law_unit = "(" + dr["law_unit"].ToString() + ")";
                    else
                        law_unit = "-";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SE" + dr["site_id"].ToString(), @"

                                        var pointFeature = new ol.Feature({
                                            geometry: new ol.geom.Point([" + dr["gis_x"].ToString() + "," + dr["gis_y"].ToString() + @"]),
                                            siteid:'" + dr["site_id"].ToString() + @"',
                                            area:'" + dr["area"].ToString() + @"',
                                            class:'" + dr["class"].ToString() + @"',
                                            siteName:'" + dr["siteName"].ToString() + "(" + dr["gis_x"].ToString() + "/" + dr["gis_y"].ToString() + @")',
                                            item:'" + dr["item"].ToString() + @"',
                                            unit:'" + dr["unit"].ToString() + @"',
                                            population: 4000,
                                            rainfall: 500,
                                            x:" + dr["gis_x"].ToString() + @",
                                            y:" + dr["gis_y"].ToString() + @",
                                            law:'" + dr["law"].ToString() + @"',
                                            law_unit:'" + law_unit + @"'
                                        });
                                      
                                      LdefIcon = new ol.style.Style({
                                                          image: new ol.style.Circle({
                                                                fill: new ol.style.Fill({
                                                                    color: [255, 255, 255, 1]
                                                                }),
                                                                stroke: new ol.style.Stroke({
                                                                    color: [255, 0, 0, 1],
                                                                    width: 5
                                                                }),
                                                                radius: 5
                                                            }),
                                                          text: new ol.style.Text({
                                                              text: '" + dr["siteName"].ToString() + @"'
                                                             ,fill: new ol.style.Fill({
                                                                 color: [0, 0, 0]
                                                               })
                                                             ,scale:1
                                                             ,offsetY:15
                                                          })
                                                      });

                                             pointFeature.setStyle(LdefIcon);

                                             pointvectorSource.addFeature(pointFeature);










                                   ", true);
                }
            }
            cn.Close();
        }
        if (!IsPostBack)
        {
            if ((minx == maxx) && (miny == maxy))
                ScriptManager.RegisterStartupScript(this, this.GetType(), "move", @"map.getView().setZoom(13);view.animate({center: [" + minx + "," + miny + "," + maxx + "," + maxy + "],duration: 1000});", true);
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "move", @"map.getView().fit([" + minx + "," + miny + "," + maxx + "," + maxy + "], { duration: 1000 });", true);
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string area = Session["area"].ToString();
        string typeclass = Session["typeclass"].ToString();
        string item = Session["item"].ToString();
        string time = Session["time"].ToString();
        string time2 = Session["time2"].ToString();

        string a = "", b = "", c = "";
        using (SqlConnection cn = new SqlConnection(conn))
        {
            string sql1 = @"SELECT [time],[val_num],[val] FROM [Data] where [area]=@area and [class]=@typeclass and [item]=@item and [time] >= @time and [time] < @time2 and [site] = @site and val!='' order by [time]  ";
            SqlCommand cmd = new SqlCommand(sql1, cn);
            cmd.Parameters.AddWithValue("@area", area);
            cmd.Parameters.AddWithValue("@typeclass", typeclass);
            cmd.Parameters.AddWithValue("@item", item);
            cmd.Parameters.AddWithValue("@time", time);
            cmd.Parameters.AddWithValue("@time2", time2);
            cmd.Parameters.AddWithValue("@site", HiddenField4.Value);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                double temp = 0;
                double o = 0;

                if (double.TryParse(dr["val"].ToString().Replace("<",""), out o))
                {
                    temp = double.Parse(dr["val"].ToString().Replace("<", ""));
                }

                if (dr["val"].ToString()=="ND")
                    c += "red,";
                else
                    c += "blue,";

                a += Convert.ToDateTime(dr["time"].ToString()).ToString("yyyy/MM/dd") + ",";
                b += temp + ",";
               // HiddenField3.Value = Convert.ToDateTime(dr["time"].ToString()).ToString("yyyy");
            }
            HiddenField1.Value = a.Substring(0, a.Length - 1);
            HiddenField2.Value = b.Substring(0, b.Length - 1);
            HiddenField6.Value = c.Substring(0, c.Length - 1);
            cn.Close();
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "EAt", @"test();", true);

    }
}
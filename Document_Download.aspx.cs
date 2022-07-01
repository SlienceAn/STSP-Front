using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Web.Configuration;
using System.Drawing;

public partial class Document_Download : System.Web.UI.Page
{
    string ctsp = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
  
    static List<List<string>> AreaList = new List<List<string>>();
    static string aColor, aID, bID, cID, aBtnID, bBtnID, cBtnID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (AreaList.Count == 0)
            {
                getListData();
              
            }
            //園區顏色
            aColor = "#5bc0de";
            //pk
            aID = "1";
            //按鈕id
            aBtnID = "aBtn0";


            ViewState["area_id"] = "1";

        }

        showsearch();
        if (!IsPostBack)
        {

      
                #region 預設園區
                //原按鈕變灰
                Button bt = (Button)PL1.FindControl(aBtnID.ToString());
                bt.Style.Add("background-color", "#cccccc");
                //按的鈕變色
                int n = int.Parse(ViewState["area_id"].ToString()) - 1;
                Button aBtn = (Button)PL1.FindControl("aBtn" + n.ToString()); ;
                aBtn.Style.Add("background-color", "#5bc0de");

                aColor = "#" + AreaList[n][1];
                aID = AreaList[n][2];
                aBtnID = aBtn.ID;
                SqlDataSource1.SelectCommand += " and area_id=" + ViewState["area_id"].ToString();

                SqlDataSource1.SelectCommand += " order by [sort] ";
                GridView1.DataBind();


                #endregion

            


        }
    }

    protected void getListData()
    {
        using (SqlConnection cn = new SqlConnection(ctsp))
        {

            string sql1 = "";
            //園區
            sql1 = "select area_name,area_color,area_id from C_Detect_Area where isDel = 0 order by area_id";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                AreaList.Add(new List<string>() { dr["area_name"].ToString(), dr["area_color"].ToString(), dr["area_id"].ToString() });
            }
            cn.Close();
        }
    }

    //園區按鈕重設
    private void aBtnColorReSet()
    {
        //try
        //{
        for (int i = 0; i < AreaList.Count(); i++)
        {
            Button bt = (Button)PL1.FindControl("aBtn" + i.ToString());
            bt.Style.Add("background-color", "#cccccc");
        }
        //}
        //catch { }
    }

    //園區、原委、類別按鈕
    protected void showsearch()
    {
        //園區:aBtn,原委:bBtn,類別:cBtn
      //  PL1.Controls.Add(new LiteralControl("<div class=\"Paper_Title_S\">園區</div>"));
        for (int i = 0; i < AreaList.Count(); i++)
        {
            Button btn = new Button();
            btn.ID = "aBtn" + i;
            btn.Text = AreaList[i][0];
            btn.CssClass = "btn btn ";//pull-left
            btn.Attributes.Add("Style", "margin-right:10px;width:85px;");

            if (i == 0)
            {
                btn.Style.Add("background-color", "#5bc0de");
              //  btn.Style.Add("font-size", "14px");
            }
            else
            {
                btn.Style.Add("background-color", "#cccccc");
               // btn.Style.Add("font-size", "14px");
            }
            //btn.BackColor=System.Drawing.Color.FromName("#"+dr["area_color"].ToString()) ;
            btn.Click += new EventHandler(aBtn_Click);
            PL1.Controls.Add(btn);
        }

    }
    protected void aBtn_Click(object sender, EventArgs e)
    {
        //原按鈕變灰
        Button bt = (Button)PL1.FindControl(aBtnID.ToString());
        bt.CssClass = "btn btn-info";
        bt.Style.Add("background-color", "#cccccc");
        //按的鈕變色
        Button aBtn = (Button)sender;
        int n = int.Parse(aBtn.ID.Replace("aBtn", ""));
        aBtnColorReSet();
       // aBtn.Style.Add("background-color", "#" + AreaList[n][1]);
        aBtn.CssClass = "btn btn-info";
        aBtn.Style.Add("background-color", "");
     //   GridView1.HeaderStyle.BackColor = Color.FromName("#" + AreaList[n][1]);

        aColor = "#" + AreaList[n][1];
        aID = AreaList[n][2];
        aBtnID = aBtn.ID;
        ViewState["area_id"] = AreaList[n][2];



        SqlDataSource1.SelectCommand += " and area_id=" + ViewState["area_id"].ToString();
        SqlDataSource1.SelectCommand += " order by [sort] ";
        GridView1.DataBind();

    }




    protected void back_Click(object sender, EventArgs e)
    {

        Response.Redirect("index.aspx");
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
       // confirm.Visible = true;
        ViewState["file"] = Server.MapPath("~/") + lb.CommandName;
        Response.Redirect(ViewState["file"].ToString());
      
    }
    protected void Download_Click(object sender, ImageClickEventArgs e)
    {

        #region 問卷調查
        #region ip
        string IP = "";
        if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
        {
            IP = Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
        }
        else
        {
            IP = Request.ServerVariables["REMOTE_ADDR"].ToString();
        }

        string[] str_IPList = IP.Split(new String[] { "," }, StringSplitOptions.None);
        IP = str_IPList[0];
        #endregion
        using (SqlConnection cn = new SqlConnection(ctsp))
        {

            string sql1 = @"Insert into [Exam_download_log](
                           [area]         
                          ,[year]
                          ,[youridertify]
                          ,[downloadpurpose]
                          ,[downloadpurpose_o]
                          ,[downloadtime]
                          ,[download_ip]
                        ) values(
                       @area,@year,@youridertify,@downloadpurpose,@downloadpurpose_o,@downloadtime,@download_ip) ";


            SqlCommand Cmd = new SqlCommand(sql1, cn);

            Cmd.Parameters.AddWithValue("@area", ViewState["area_id"]);
            Cmd.Parameters.AddWithValue("@year", "2016");
            Cmd.Parameters.AddWithValue("@youridertify", youridertify.SelectedValue);
            Cmd.Parameters.AddWithValue("@downloadpurpose", downloadpurpose.SelectedValue);
            Cmd.Parameters.AddWithValue("@downloadpurpose_o", downloadpurpose_o.Text);
            Cmd.Parameters.AddWithValue("@downloadtime", DateTime.Now);
            Cmd.Parameters.AddWithValue("@download_ip", IP);



            cn.Open();
            Cmd.ExecuteNonQuery();
            cn.Close();
        }



        #endregion
        confirm.Visible = false;
        System.Net.WebClient wb = new System.Net.WebClient();
        string link = Server.MapPath("~/") + ViewState["file"].ToString();



      //  ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "window.open('" + ViewState["file"].ToString() + "','','toolbar=no,menubar=yes,status=no,scrollbars=yes,resizable=no,width=800,height=700');", true);
   
        Response.Redirect(ViewState["file"].ToString());

    }
    protected void disagree_Click(object sender, ImageClickEventArgs e)
    {
        confirm.Visible = false;

    }
}
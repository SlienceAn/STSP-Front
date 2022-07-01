using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Drawing;
using System.Configuration;
using System.IO;
using NPOI;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.Text.RegularExpressions;
using OfficeOpenXml;
using Ionic.Zip;
using OfficeOpenXml.FormulaParsing;
using PDFMaker;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;

public partial class PDF_Print : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
    DataTable dss = new DataTable();
    List<string> dele = new List<string>();
    List<string> cname = new List<string>();
    protected void Page_Load(object sender, EventArgs e)
    {
        dss = Session["dt"] as DataTable; // get data from session.
     
        if(Session["show_item"].ToString()=="全部")
           checknull();

        if (dss.Columns.Count != 0 && dss.Rows.Count != 0)
           print();
    }
    protected void checknull()
    {
        for (int j = 3; j < dss.Columns.Count; j++)
        {
            cname.Add(dss.Columns[j].ColumnName);

            int cn = 0;
            for (int i = 1; i < dss.Rows.Count; i++)
            {

                if (dss.Rows[i][j].ToString() != "" && dss.Rows[i][j] != null)
                {


                    cn = 1;


                }

            }

            if (cn == 0)
            {
                dele.Add(j.ToString());


            }
        }
        //公式資料設定
        #region 抓封鎖的測站
//        for (int j = 3; j < dss.Columns.Count; j++)
//        {

//            using (SqlConnection cn = new SqlConnection(sin))
//            {

//                string sql1 = @"SELECT  distinct t1.[item_id],t2.itemName FROM [ShowToItem] as t1
//                                 inner join [Detect_Item] as t2
//                                 on t1.item_id=t2.item_id
//                                 where t2.itemName=@itemName ";

//                if(Session["area"]!=null && Session["area"].ToString()!="")
//                    sql1 += " and  area_id=" + Session["area"].ToString();
//                if (Session["typeclass"] != null && Session["typeclass"].ToString() != "")
//                    sql1 += " and  class_id=" + Session["typeclass"].ToString();

//                SqlCommand cmd = new SqlCommand(sql1, cn);

//                cmd.Parameters.AddWithValue("itemName", dss.Columns[j].ColumnName.Split('_')[0]);
//                cn.Open();
//                SqlDataReader dr = cmd.ExecuteReader();


//                if (dr.Read())
//                {

//                }
//                else
//                {
//                    dele.Add((j-3).ToString());
                   
//                }

//            }

//        }
        #endregion


        for (int i = 0; i < dele.Count; i++)
        {
            try
            {
                //Response.Write(cname[int.Parse(dele[i])]);
                dss.Columns.Remove(cname[int.Parse(dele[i])]);
                //  dss.Columns.RemoveAt(int.Parse(dele[i]));
            }
            catch { }
        }

    }
    protected void print() {

        PDFClass pdf = new PDFClass();
        var doc = new Document(PageSize.A2.Rotate(), 10, 50, 50, 10);

        string filename = DateTime.Now.ToString("yyyyMMddHHmmss") + DateTime.Now.Second.ToString()  + ".pdf";

        PdfWriter ctsp = PdfWriter.GetInstance(doc, new FileStream(@Server.MapPath("~/") + "\\pdf\\" + filename, FileMode.Create));
        //   PdfWriter ctsp = PdfWriter.GetInstance(doc, new FileStream(@Server.MapPath("~/") + "\\pdf\\" + filename, FileMode.Create));

        MemoryStream Memory = new MemoryStream();
        PdfWriter pdfWriter = PdfWriter.GetInstance(doc, Memory);

        float[] pdfarray = new float[dss.Columns.Count];
        for (int i = 0; i < dss.Columns.Count; i++)
            pdfarray[i] = 1;

        PdfPTable table = new PdfPTable(pdfarray);
        table.TotalWidth = 1400f;
        table.FooterRows = 1;
        table.LockedWidth = true;

        try 
        { 
        table.AddCell(pdf.SetText(@"園區：" + Session["show_area"].ToString() + @" 類別：" + Session["show_typeclass"].ToString() + @" 測項：" + Session["show_item"].ToString() + @" 時間：" + Session["show_time1"].ToString() + "~" + Session["show_time2"].ToString(), 14, PDFClass.IsBold.No, PDFClass.span.Colspan, dss.Columns.Count, PDFClass.Border.Yes, 0, 0, 0, 0, PDFClass.Horizontal.Left, PDFClass.Vertical.MIDDLE, ""));
        }
        catch{ }
        table.AddCell(pdf.SetText(@"製表時間：" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"), 14, PDFClass.IsBold.No, PDFClass.span.Colspan, dss.Columns.Count, PDFClass.Border.Yes, 0, 0, 0, 0, PDFClass.Horizontal.Left, PDFClass.Vertical.MIDDLE, ""));

        for (int i = 0; i < dss.Columns.Count; i++)
        {
            try
            {
                table.AddCell(pdf.SetText(dss.Columns[i].ColumnName.Split('_')[0], 14, 1, PDFClass.IsBold.No, PDFClass.Horizontal.Left, PDFClass.Vertical.TOP, 0));

            }
            catch {
                table.AddCell(pdf.SetText(dss.Columns[i].ColumnName, 14, 1, PDFClass.IsBold.No, PDFClass.Horizontal.Left, PDFClass.Vertical.TOP, 0));
            }
        }
        Response.Write(dss.Rows.Count.ToString());
        for (int i = 0; i < dss.Rows.Count; i++)
        {
            if (dss.Rows[i][3].ToString() != "")
            { 
            for (int j = 0; j < dss.Columns.Count; j++)
           {
              
                double o = 0;
                if (double.TryParse(dss.Rows[i][j].ToString(), out o))
                {
                    double res = double.Parse(dss.Rows[i][j].ToString());
                    if (dss.Rows[i][j].ToString().Length>6)
                        table.AddCell(pdf.SetText(res.ToString("N3"), 14, 1, PDFClass.IsBold.No, PDFClass.Horizontal.Left, PDFClass.Vertical.TOP, 0));
                    else
                        table.AddCell(pdf.SetText(dss.Rows[i][j].ToString(), 14, 1, PDFClass.IsBold.No, PDFClass.Horizontal.Left, PDFClass.Vertical.TOP, 0));
                }
                else 
                   table.AddCell(pdf.SetText(dss.Rows[i][j].ToString(), 14, 1, PDFClass.IsBold.No, PDFClass.Horizontal.Left, PDFClass.Vertical.TOP, 0));
               

           }
            }
        }

        doc.Open();
        doc.Add(table);
        doc.Close();
        Watermark(@Server.MapPath("~/") + "pdf\\" + filename, @Server.MapPath("~/") + "image/southern_new3.gif");
        //Response.Clear();
        //Response.Charset = "UTF-8";
        //Response.ContentEncoding = Encoding.UTF8;
        //Response.AddHeader("Content-Disposition", "attachment;filename=" + DateTime.Now.ToString("yyyyMMddHHmmss") + DateTime.Now.Millisecond.ToString() + ".pdf");
        //Response.ContentType = "application/octet-stream";
        //Response.OutputStream.Write(Memory.GetBuffer(), 0, Memory.GetBuffer().Length);

        //Response.OutputStream.Flush();
        //Response.OutputStream.Close();
        //Response.Flush();
        //Response.End();
    
    
    }

    protected void Watermark(string inputPath, string watermarkPath)
    {

        try
        {
            PdfReader pdfReader = new PdfReader(inputPath);
            int numberOfPages = pdfReader.NumberOfPages;
            // FileStream outputStream = new FileStream(outputPath, FileMode.Create);
            MemoryStream Memory = new MemoryStream();

            PdfStamper pdfStamper = new PdfStamper(pdfReader, Memory);
            PdfContentByte waterMarkContent;

            string watermarkimagepath = watermarkPath;
            iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(watermarkimagepath);

            image.SetAbsolutePosition(300, 0);
           

            for (int i = 1; i <= numberOfPages; i++)
            {
                waterMarkContent = pdfStamper.GetUnderContent(i);
                waterMarkContent.AddImage(image);
               // waterMarkContent.SetGrayFill(0.3f);
            }
            pdfStamper.Close();
            pdfReader.Close();


            Response.Clear();
            Response.Charset = "UTF-8";
            Response.ContentEncoding = Encoding.UTF8;
            Response.AddHeader("Content-Disposition", "attachment;filename=" + DateTime.Now.ToString("yyyyMMddHHmmss") + DateTime.Now.Millisecond.ToString() + ".pdf");
            Response.ContentType = "application/octet-stream";
            Response.OutputStream.Write(Memory.GetBuffer(), 0, Memory.GetBuffer().Length);

            Response.OutputStream.Flush();
            Response.OutputStream.Close();
            Response.Flush();
            Response.End();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace PDFMaker
{
    /// <summary>PDF開發模組</summary>
    public class PDFClass
    {
        /// <summary>是否粗體</summary>
        public enum IsBold { No, Yes };

        /// <summary>跨欄還是跨列</summary>
        public enum span { Colspan, Rowspan }

        /// <summary>是否控制邊框</summary>
        public enum Border { No, Yes };

        public enum Horizontal { Left, CENTER, RIGHT };
        public enum Vertical { TOP, MIDDLE, BOTTOM };

        /// <summary>欄位預設高度</summary>
        float _cell_default_height;

        /// <summary>欄位預設高度</summary>
        public float Cell_Default_Height
        {
            get
            {
                return _cell_default_height;
            }
            set
            {
                _cell_default_height = value;
            }
        }
        /// <summary>設定邊界</summary>
        private void SetBorderWidth(float width, ref PdfPCell cell)
        {
            cell.BorderWidth = width;
        }

        /// <summary>設定邊界</summary>
        private void SetBorderWidth(float Top, float Bottom, float Left, float Right, ref PdfPCell cell)
        {
            cell.BorderWidthTop = Top;
            cell.BorderWidthBottom = Bottom;
            cell.BorderWidthLeft = Left;
            cell.BorderWidthRight = Right;
        }

        /// <summary>
        /// 產生欄位
        /// </summary>
        /// <param name="strContext">內容文字</param>
        /// <param name="fFontSize">字型大小</param>
        /// <param name="ib">是否粗體</param>
        /// <param name="_s">跨欄方式</param>
        /// <param name="iColspan">跨欄數量</param>
        /// <param name="_B">是否設定邊線寬度</param>
        /// <param name="Top">上邊線寬度</param>
        /// <param name="Bottom">下邊線寬度</param>
        /// <param name="Left">左邊線寬度</param>
        /// <param name="Right">右邊線寬度</param>
        /// <param name="_H">水平</param>
        /// <param name="_V">垂直</param>
        /// <param name="strFontName">字形名稱</param>
        /// <returns></returns>
        public PdfPCell SetText(string strContext, float fFontSize, IsBold ib, span _s, int iColspan, Border _B, float Top, float Bottom, float Left, float Right, Horizontal _H, Vertical _V, string strFontName)
        {
            string strFontPath = System.IO.Directory.GetParent(Environment.GetFolderPath(Environment.SpecialFolder.System)).FullName + @"\Fonts\";

            PdfPCell cell = new PdfPCell();
            if (_cell_default_height > 0) cell.MinimumHeight = _cell_default_height;

            switch (_H)
            {
                case Horizontal.Left:
                    cell.HorizontalAlignment = Element.ALIGN_LEFT;
                    break;
                case Horizontal.CENTER:
                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                    break;
                case Horizontal.RIGHT:
                    cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    break;
            }
            switch (_V)
            {
                case Vertical.TOP:
                    cell.VerticalAlignment = Element.ALIGN_TOP;
                    break;
                case Vertical.MIDDLE:
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    break;
                case Vertical.BOTTOM:
                    cell.VerticalAlignment = Element.ALIGN_BOTTOM;
                    break;
            }

            BaseFont gothicbf = BaseFont.CreateFont(strFontPath + (string.IsNullOrEmpty(strFontName) ? "kaiu.ttf" : strFontName), BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            iTextSharp.text.Font gothicfont;

            if (ib == IsBold.No)
                gothicfont = new iTextSharp.text.Font(gothicbf, fFontSize, 0);
            else
                gothicfont = new iTextSharp.text.Font(gothicbf, fFontSize, Font.BOLD);

            cell.Phrase = new Phrase(strContext, gothicfont);
            switch (_s)
            {
                case span.Colspan:
                    cell.Colspan = iColspan;
                    break;
                case span.Rowspan:
                    cell.Rowspan = iColspan;
                    break;
            }
            if (Border.Yes == _B)
                SetBorderWidth(Top, Bottom, Left, Right, ref cell);



            return cell;
        }
        public PdfPCell SetImage(Image strContext, float fFontSize, IsBold ib, span _s, int iColspan, Border _B, float Top, float Bottom, float Left, float Right, Horizontal _H, Vertical _V, string strFontName)
        {
            string strFontPath = System.IO.Directory.GetParent(Environment.GetFolderPath(Environment.SpecialFolder.System)).FullName + @"\Fonts\";

            PdfPCell cell = new PdfPCell();
            if (_cell_default_height > 0) cell.MinimumHeight = _cell_default_height;

            switch (_H)
            {
                case Horizontal.Left:
                    cell.HorizontalAlignment = Element.ALIGN_LEFT;
                    break;
                case Horizontal.CENTER:
                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                    break;
                case Horizontal.RIGHT:
                    cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    break;
            }
            switch (_V)
            {
                case Vertical.TOP:
                    cell.VerticalAlignment = Element.ALIGN_TOP;
                    break;
                case Vertical.MIDDLE:
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    break;
                case Vertical.BOTTOM:
                    cell.VerticalAlignment = Element.ALIGN_BOTTOM;
                    break;
            }

            BaseFont gothicbf = BaseFont.CreateFont(strFontPath + (string.IsNullOrEmpty(strFontName) ? "kaiu.ttf" : strFontName), BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            iTextSharp.text.Font gothicfont;

            if (ib == IsBold.No)
                gothicfont = new iTextSharp.text.Font(gothicbf, fFontSize, 0);
            else
                gothicfont = new iTextSharp.text.Font(gothicbf, fFontSize, Font.BOLD);
          //  PdfPCell im1 = new PdfPCell(strContext);
          //  strContext.ScaleAbsolute(15.0f, 15.0f);
            strContext.WidthPercentage = 50;
            cell.Image = strContext;
            cell.Image.WidthPercentage = 50;

            switch (_s)
            {
                case span.Colspan:
                    cell.Colspan = iColspan;
                    break;
                case span.Rowspan:
                    cell.Rowspan = iColspan;
                    break;
            }
            if (Border.Yes == _B)
                SetBorderWidth(Top, Bottom, Left, Right, ref cell);



            return cell;
        }
        /// <summary>
        /// 產生欄位
        /// </summary>
        /// <param name="strContext">內容文字</param>
        /// <param name="fFontSize">字型大小</param>
        /// <param name="iColspan">跨欄數量</param>
        /// <param name="ib">是否粗體</param>
        /// <param name="_H">水平</param>
        /// <param name="_V">垂直</param>
        /// <param name="width">邊線寬度</param>
        /// <returns></returns>
        public PdfPCell SetText(string strContext, float fFontSize, int iColspan, IsBold ib, Horizontal _H, Vertical _V, float width)
        {
            return SetText(strContext, fFontSize, ib, span.Colspan, iColspan, Border.No, width, width, width, width, _H, _V, "");
        }
        public PdfPCell SetImage(Image strContext, float fFontSize, int iColspan, IsBold ib, Horizontal _H, Vertical _V, float width)
        {
            return SetImage(strContext, fFontSize, ib, span.Colspan, iColspan, Border.No, width, width, width, width, _H, _V, "");
        }
        /// <summary>
        /// 產生欄位
        /// </summary>
        /// <param name="strContext">內容文字</param>
        /// <param name="fFontSize">字型大小</param>
        /// <param name="_s">跨欄方式</param>
        /// <param name="iColspan">跨欄數量</param>
        /// <param name="ib">是否粗體</param>
        /// <param name="_H">水平</param>
        /// <param name="_V">垂直</param>
        /// <param name="width">邊線寬度</param>
        /// <returns></returns>
        public PdfPCell SetText(string strContext, float fFontSize, span _s, int iColspan, IsBold ib, Horizontal _H, Vertical _V, float width)
        {
            return SetText(strContext, fFontSize, ib, _s, iColspan, Border.No, width, width, width, width, _H, _V, "");
        }
        public PdfPCell SetImage(Image strContext, float fFontSize, span _s, int iColspan, IsBold ib, Horizontal _H, Vertical _V, float width)
        {
            return SetImage(strContext, fFontSize, ib, _s, iColspan, Border.No, width, width, width, width, _H, _V, "");
        }
    
    }
}

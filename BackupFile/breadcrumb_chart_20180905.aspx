<%@ Page Language="VB" AutoEventWireup="false" CodeFile="breadcrumb_chart.aspx.vb" Inherits="breadcrumb_chart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Gentelella Alela! | </title>


    <link href="../backend/work_data/jquery-ui.css" rel="stylesheet" />
    <link href="../backend/work_data/ui.jqgrid.css" rel="stylesheet" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha256-eZrrJcwDc/3uDhsdt61sL2oOBY362qM3lon1gyExkL0=" crossorigin="anonymous" />
    <%-- link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"/ --%>
    <%-- link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/ --%>
    <link href="../backend/vendors/nprogress/nprogress.css" rel="stylesheet"/>
    <link href="../backend/datetimepicker/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="../backend/work_data/jquery-2.1.1.min.js"></script>
    <script src="../backend/work_data/grid.locale-tw.js"></script>
    <script src="../backend/work_data/jquery.jqGrid.min.js"></script>
    <script src="../backend/datetimepicker/jquery.datetimepicker.js"></script>
    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <%-- script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script --%>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	<script src="../backend/vendors/iCheck/icheck.min.js"></script>	
	<link href="../backend/vendors/iCheck/skins/all.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
               <asp:Panel ID="P_Content" runat="server">
        <div class="wrapper animated fadeInRight" style="padding: 10px 10px;">
            <%--<asp:Label ID="bWindow" runat="server"></asp:Label>--%>
            <asp:Panel ID="Panel1" runat="server">
                <div class="row white-bg" style="padding: 0 0 20px 0;">
                    <div class="col-lg-12">
                        <!--Common!-->

                        <i class="fa fa-calendar" style="float: left; font-size: 24px; margin: 5px 10px 0 0;"></i>
                        <asp:TextBox ID="date_timepicker_start" runat="server" name="date_timepicker_start"></asp:TextBox>
                        <%--<input id="date_timepicker_start" name="date_timepicker_start" type="text" />--%>
                        <asp:Label ID="dEnd" runat="server" Text="~" Class="dText"></asp:Label>
                       <%-- <input id="date_timepicker_end" name="date_timepicker_end" type="text" />--%>
                        <asp:TextBox ID="date_timepicker_end" runat="server" name="date_timepicker_end"></asp:TextBox>
                        <asp:DropDownList ID="TableTime" runat="server" style="width:70px;height:26px;"></asp:DropDownList>
                        <!--Custom!-->
                        <asp:DropDownList ID="D_Flag" runat="server"  Visible="false" >
                            <asp:ListItem Value="0">無標記</asp:ListItem>
                            <asp:ListItem Value="1">標記</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="D_ChartType" runat="server"  Visible="true" style="width:140px;height:26px;">
                            <asp:ListItem Value="0">一般圖表</asp:ListItem>
                            <asp:ListItem Value="1">多重坐標軸</asp:ListItem>
                            <asp:ListItem Value="2">坐標軸分行</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="D_SPar" runat="server" class="col-lg-3" Visible="false"></asp:DropDownList>
                        <asp:Label ID="Custom" runat="server"></asp:Label>
                        <asp:Label ID="date_timepicker_JQ" runat="server"></asp:Label>
                        <button type="button" id="Btn_Search" class="btn btn1 btn-primary" onclick="SearchData()"><i class="fa fa-search"></i>查詢</button>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </asp:Panel>
            
            <asp:Label ID="ChartSetting" runat="server"></asp:Label>
        </div>
    </form>

     <script>

         jQuery(function () {
             jQuery('#date_timepicker_start').datetimepicker({
                 format: 'Y/m/d H:i',
                 lang: 'zh-TW',
                 minDate: '2014/10/01',
                 maxDate: new Date()
             });
             jQuery('#date_timepicker_end').datetimepicker({
                 format: 'Y/m/d H:i',
                 lang: 'zh-TW',
                 minDate: '2014/10/01',
                 maxDate: new Date()
             });
         });

</script>
     <script>

        $(document).ready(function () {
            $('.i-checks').iCheck({ checkboxClass: 'icheckbox_square-green', radioClass: 'iradio_square-green' });
            //$("#ul_download").css("min-width", $("#Btn_download").width() + 26);
        });

        $(window).load(function () {
            parent.$("#wrapper").scrollTop(60);
            var i = parent.$("#max").find('i');
            if (i.hasClass('fa-compress')) {
                $("body").css("padding", "20");
                MaxSize()
            } else {
                NormalSize()
                parent.document.getElementById("ifs").height = document.body.scrollHeight;
            }
        });

        $(window).resize(function () { 
            var i = parent.$("#max").find('i');
            if (i.hasClass('fa-compress')) {
                MaxSize()
                parent.$("#wrapper").css("height", "");
            } else {
                NormalSize()
                parent.document.getElementById("ifs").height = document.body.scrollHeight;
            }
        });

        function MaxSize()
        {
            $("#CP_CPn_JQGrid2").jqGrid('setGridWidth', $(window).width() - 55, true);
            $("#CP_CPn_JQGrid2").jqGrid('setGridHeight', $(window).height() - 180, true);
            $("#Right_group").css("right", "50px");
            var Gets = document.location.toString();
            var Par = Gets.split("?")[1].split("&");
            var dPage = Gets.split("?")[0].split("/")[Gets.split("?")[0].split("/").length - 1].split(".")[0];
            if (dPage == "jRealTime")
                $("#container").css("height", $(window).height() - 60);
            else
                $("#container").css("height", $(window).height() - 120);
        }

        function NormalSize() {
            $("#CP_CPn_JQGrid2").jqGrid('setGridWidth', $(window).width() - 20, true);
            $("#CP_CPn_JQGrid2").jqGrid('setGridHeight', "500px", true);
            $("#Right_group").css("right", "10px");
            $("#container").css("height", "500px");
        }

         function SelectAll(s) {
             if (s == "cAll") {   //all checkbox
                 var n = 0;
                 while (true) {
                     if (document.getElementById("V" + n)) {
                         if (document.getElementById("cAll").checked == true) {
                             document.getElementById("V" + n).checked = true;
                             $("#V" + n).parent("div").addClass("checked");
                         }
                         else {
                             $("#V" + n).parent("div").removeClass("checked");
                             document.getElementById("V" + n).checked = false;
                         }
                         n += 1;
                     }
                     else {
                         if (document.getElementById("cAll").checked == true) {
                             document.getElementById("cAll").checked = false;
                             $("cAll").parent("div").removeClass("checked");
                         }
                         else {
                             $("cAll").parent("div").addClass("checked");
                             document.getElementById("cAll").checked = true;
                         }
					 break; }
                 }
             }
         }


        function dateValidationCheck(d) {
            var Valid = false;
            try {        
                var td = new Date();
                var yy = d.split(" ")[0].split("/")[0];
                var MM = d.split(" ")[0].split("/")[1];
                var dd = d.split(" ")[0].split("/")[2];
                var HH = d.split(" ")[1].split(":")[0];
                var mm = d.split(" ")[1].split(":")[1];

                if (!isNaN(yy) == true && !isNaN(MM) == true && !isNaN(dd) == true && !isNaN(HH) == true && !isNaN(mm) == true) {
                    if (yy <= td.getFullYear() && yy >= 2000 && MM >= 1 && MM <= 12 && HH >= 0 && HH <= 23 && mm >= 0 && mm <= 59) {
                        if (MM == 1 || MM == 3 || MM == 5 || MM == 7 || MM == 8 || MM == 10 || MM == 12) dv = 31;
                        else if (MM == 4 || MM == 6 || MM == 9 || MM == 11) dv = 30;
                        else if (yy % 4 == 0) dv = 29; else dv = 28;
                        if (dd >= 1 && dd <= dv) Valid = true;
                    }
                }

            } catch (e) { }
            return Valid;
        }

         function SearchData() {
             var Gets = document.location.toString();
             
             var Par = Gets.split("?")[1].split("&");

             var dPage = Gets.split("?")[0].split("/")[Gets.split("?")[0].split("/").length - 1].split(".")[0];
             var ReUrl = "";
             var ST = Par[0];
             var d1 = document.getElementById("date_timepicker_start").value;
             var d2 = document.getElementById("date_timepicker_end").value;

             
             //判斷日期 超防呆
             var d1v = dateValidationCheck(d1);

             var d2v = dateValidationCheck(d2);
             if (d1v == true && d2v == true) {
                 if (new Date(d1) > new Date(d2)) {
                     alert("起始日期時間不可大於結束日期時間");
                     return;
                 }
             } else {
                 alert("日期格式錯誤! yyyy/MM/dd HH:mm<br/>Date formatt error! dd/MM/yyyy HH:mm");
                 return;
             }


             ReUrl = dPage + ".aspx?" + ST + "&d1=" + d1 + "&d2=" + d2;

             switch (dPage) {
                 case "jDatalog":
                     alert(1)
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     ReUrl += "&col=" + document.getElementById("CP_D_SPar").value;
                     break;

                 case "jDatalogChart":
                     alert(2)
                     ReUrl += "&col=" + document.getElementById("CP_D_SPar").value;
                     break;

                 case "jBox":
                     alert(3)
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     ReUrl += "&col=" + document.getElementById("CP_D_SPar").value;
                     ReUrl += "&bp1=" + document.getElementById("bp1").value;
                     ReUrl += "&bp3=" + document.getElementById("bp3").value;
                     break;

                 case "jHeatMap":
                     alert(4)
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     ReUrl += "&col=" + document.getElementById("CP_D_SPar").value;
                     var gl = "&gl=";
                     var color = "&color=";
                     var n = 0;
                     while (true) {
                         if (document.getElementById("gl" + n)) {
                             gl += document.getElementById("gl" + n).value + ",";
                             color += document.getElementById("picker" + n).value + ",";
                             n += 1;
                         }
                         else { break; }
                     }
                     gl = gl.substring(0, gl.length - 1);   //remove last char
                     color = color.substring(0, color.length - 1);   //remove last char
                     ReUrl += gl + color;
                     break;

                 case "jHeatMapSDMN":
                     alert(5)
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     ReUrl += "&col=";
                     var n = 0;
                     while (true) {
                         if (document.getElementById("V" + n)) {
                             if (document.getElementById("V" + n).checked) { ReUrl += document.getElementById("V" + n).value + ","; }
                             n += 1;
                         }
                         else { break; }
                     }
                     ReUrl = ReUrl.substring(0, ReUrl.length - 1);   //remove last char
                     var gl = "&gl=";
                     var color = "&color=";
                     var n = 0;
                     while (true) {
                         if (document.getElementById("gl" + n)) {
                             gl += document.getElementById("gl" + n).value + ",";
                             color += document.getElementById("picker" + n).value + ",";
                             n += 1;
                         }
                         else { break; }
                     }
                     gl = gl.substring(0, gl.length - 1);   //remove last char
                     color = color.substring(0, color.length - 1);   //remove last char
                     ReUrl += gl + color;
                     break;

                 case "jDaily":
                     alert(6)
                     ReUrl += "&col=" + document.getElementById("CP_D_SPar").value;
                     break;

                 case "jCalib":
                     alert(7)
                     ReUrl += "&col=" + document.getElementById("CP_D_SPar").value;
                     break;

                 case "breadcrumb_table":

                     ReUrl += "&tt=" + document.getElementById("TableTime").value;
                     ReUrl += "&col=";

                     var n = 0;
                     while (true) {
                         if (document.getElementById("V" + n)) {
                             if (document.getElementById("V" + n).checked) { ReUrl += document.getElementById("V" + n).value + ","; }
                             n += 1;
                         }
                         else { break; }
                     }
                     ReUrl = ReUrl.substring(0, ReUrl.length - 1);   //remove last char
                     
                     break;

                 case "breadcrumb_chart":
                     
                     ReUrl += "&tt=" + document.getElementById("TableTime").value;
                     ReUrl += "&c=" + document.getElementById("D_ChartType").value;
                     var col = "&col=";
                     var line = "&line=";
                     var n = 0;
                     while (true) {
                         if (document.getElementById("V" + n)) {
                             if (document.getElementById("V" + n).checked) {
                                 col += document.getElementById("V" + n).value + ",";
                                 line += document.getElementById("LT" + n).value + ",";
                             }
                             n += 1;
                         }
                         else { break; }
                     }
                     col = col.substring(0, col.length - 1);   //remove last char
                     line = line.substring(0, line.length - 1);   //remove last char
                     ReUrl += col + line;
                  
                     break;

                 case "jMeteogram":
                     alert(10)
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     break;

                 case "jPolar":
                     alert(11)
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     var col = "&col=";
                     var n = 0;
                     while (true) {
                         if (document.getElementById("V" + n)) {
                             if (document.getElementById("V" + n).checked) {
                                 col += document.getElementById("V" + n).value + ",";
                             }
                             n += 1;
                         }
                         else { break; }
                     }
                     col = col.substring(0, col.length - 1);   //remove last char
                     ReUrl += col;
                     break;

                 case "jMonthly":
                     break;

                 case "jRealTime":
                     break;

                 case "jWindrose":
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     break;

                 case "jWind":
                     ReUrl += "&tt=" + document.getElementById("CP_TableTime").value;
                     break;

                 case "jIAQsbs":
                     ReUrl += "&tt=T60";
                     ReUrl += "&hr=" + document.getElementById("hr").value;
                     break;

                 default:
                     break;
             }

             document.location = ReUrl;
             
         }
        
    </script>


</body>
</html>

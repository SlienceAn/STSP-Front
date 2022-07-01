<%@ Page Title="" Language="C#" MasterPageFile="MasterPage2.master" AutoEventWireup="true" CodeFile="datamap.aspx.cs" Inherits="index_datamap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>--%>
    <script src="js/jquery-2.2.0.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3&sensor=true&key=AIzaSyCxpL2JuboOV8t0DPxPi-EuGktgvzf2Xqs"></script>
    
         <script src="js/Chart.bundle.js"></script>
        <script type="text/javascript" charset="utf-8" src="js/map.js"></script>

     <style type="text/css">
         #map {
             width: 100%;
             height: 800px;
         }

         .areadrp {
             width: 80px;
         }

         .typedrp {
             width: auto;
         }

         .timedrp {
             width: 68px;
             display: inline-block;
             padding: 3px 1px;
         }

         .btnAtr {
             width: 90px;
         }

         .searchMod {
             width: 610px;
             margin: 0 auto;
             position: absolute;
             z-index: 2;
             left: 50px;
             top: 200px;
             float: left;
             background: white;
             opacity: 1;
             border: 0px #788D93 solid;
         }

         .sideByside {
             display: inline-block;
         }

         #lengelfrom {
             position: absolute;
             z-index: 2;
             top: 220px;
             left: 12px;
             cursor: pointer;
         }
         /*#chart-legend-normal {
         width:95% !important;
         height:240px;
         }
         .gm-style-iw {
                height: auto;
                width: 240px !important;
            }*/
         @media (max-width:991px) {
             *#chart-legend-normal {
                 width: 95% !important;
                 height: 240px;
             }

             .gm-style-iw {
                 height: auto;
                 width: 240px !important;
             }

             .itemdrp {
                 width: 150px;
             }

             .searchMod {
                 width: 95%;
                 left: 9px;
                 top: 117px;
             }

             .btnBox .btn {
                 margin: 5px 0;
             }

             .disappear {
                 display: none;
             }

             #lengelApp {
                 position: relative;
                 z-index: 2;
                 cursor: pointer;
             }

                 #lengelApp img {
                     top: 60px;
                     left: 8px;
                     position: absolute;
                     width: 100px;
                     height: 40px;
                 }

             #lengel {
             }
         }

         @media(min-width: 992px) {
             .mobileShow {
                 display: none;
             }
         }
     </style>
        <script src="js/bootstrap.min.js"></script>
     <script>
         function showModal() {
             $('.bs-reply-modal-lg').modal('show');
         }
         function hideModal() {
             $('.bs-reply-modal-lg').modal('hide');
         }

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=screenW.ClientID%>").val($(window).width());

        });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div id="lengelfrom2" style="position: absolute;z-index: 2;top:140px;left:12px;cursor: pointer; "><a href="javascript:showModal()"><img class="disappear" src="image/explanation.png" alt=""  id="explanation" style="width: 100%;height: 100%;"/></a></div>
    <div id="lengelfrom" class="disappear" ><%--style="position: absolute;z-index: 2;top:220px;left:12px;cursor: pointer; "--%>
        <img src="image/close.png" alt=""  id="watericon" style="width: 100%;height: 100%;"/>
    </div>
    <div id="lengelApp" class="mobileShow"><img src="image/close_app.png" alt=""  id="waterApp"/></div>

 <div  class="searchMod" style="" >
 <div id='lengel'>
             
       <div class="Subtxt">
                    <div class="subTitle">
                        <h3>人工批次監測</h3>
                    </div>
                </div>

   <div class="softwareText">
               <div class="col-md-12">
               <div class="form-group row">
	            <label for="inputEmail3" class="col-sm-2 col-form-label">選擇園區</label>
                <div class="col-sm-10">
                   <asp:DropDownList ID="area" runat="server" DataSourceID="SqlDataSource1" DataTextField="area_name" DataValueField="area_id" OnDataBound="area_DataBound" AutoPostBack="True" OnSelectedIndexChanged="area_SelectedIndexChanged" CssClass="form-control areadrp"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT DISTINCT [area_id], [area_name] FROM [C_Detect_Area]"></asp:SqlDataSource>
                </div>
                </div>
                     <div class="form-group row">
        	<label for="inputEmail3" class="col-sm-2 col-form-label">選擇類別</label>
        <div class="col-sm-10">
                                <asp:DropDownList ID="cclass" runat="server" DataSourceID="SqlDataSource2" DataTextField="class_name" DataValueField="class_id" AutoPostBack="True" OnDataBound="eid_DataBound" CssClass="form-control typedrp"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT '0' as [class_id],'請選擇' as  [class_name] union SELECT DISTINCT [class_id], [class_name] FROM [C_Detect_Class] where class_id!=14 and class_id!=15"></asp:SqlDataSource>
          </div>
           </div>
              



                     <div class="form-group row">
          	<label for="inputEmail3" class="col-sm-2 col-form-label">選擇項目</label>
       <div class="col-sm-10">
           <asp:DropDownList ID="item" runat="server" DataSourceID="SqlDataSource3" DataTextField="itemName" DataValueField="item_id" OnDataBound="item_DataBound" CssClass="form-control itemdrp"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT '0' as item_id,'請選擇' as  [itemName] union SELECT DISTINCT t1.[item_id], [itemName] FROM [Detect_Item] as t1 
            inner join [Detect_ClassItmeMapping] as t2
            on t1.item_id=t2.item_id 
            where t2.class_id=@class_id and itemName!='污水處理廠名稱' and itemName!='平日/假日' and itemName!='方向' and itemName!='道路名稱'  and itemName!='風向'  ">
            <SelectParameters>
                <asp:ControlParameter ControlID="cclass" Name="class_id" PropertyName="SelectedValue" />
                 <asp:ControlParameter ControlID="area" Name="area" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
             </div>
                          </div>
                <div class="form-group row">
            
           <label for="inputEmail3" class="col-sm-2 col-form-label">選擇時間</label>
           
               <div class="col-sm-10" style="position:relative;">
                   <p style="display: inline-block;position: absolute;">最近</p><%--margin-top:5px;float:left;--%>
         <asp:RadioButtonList ID="time" runat="server" RepeatDirection="Horizontal"  style="margin-left:40px;display:inline-block;"
                         AutoPostBack="True" onselectedindexchanged="time_SelectedIndexChanged" RepeatColumns="3">
             <asp:ListItem Value="1"   style="padding-left: 5px"> 1年</asp:ListItem>
             <asp:ListItem Value="2" Selected="True"  style="padding-left: -5px">2年</asp:ListItem>
             <asp:ListItem Value="3" style="padding-left: 5px">3年</asp:ListItem>
             <asp:ListItem Value="0" style="padding-left: 5px">自訂</asp:ListItem>
         </asp:RadioButtonList>
      
        <div class="" style="position:absolute;left: 100px;top: 28px;">
             <span class="sideByside" style="padding-left:10px;">(限定範圍為3年)</span> </div>
                   <div style="margin-left:50px;">
            <div class="sideByside" style="margin-bottom:10px;"><asp:DropDownList ID="year1" runat="server"  CssClass="form-control timedrp"
             DataSourceID="SqlDataSource4" DataTextField="Column1" DataValueField="Column1" 
                         Enabled="False" AutoPostBack="True" 
                         onselectedindexchanged="year1_SelectedIndexChanged">
             </asp:DropDownList>年~</div>
                 <div class="sideByside"> <asp:DropDownList ID="year2" runat="server"  CssClass="form-control timedrp"
             DataSourceID="SqlDataSource4" DataTextField="Column1" DataValueField="Column1"  
                         Enabled="False" AutoPostBack="True" 
                         onselectedindexchanged="year2_SelectedIndexChanged" AppendDataBoundItems="True">
                      
             </asp:DropDownList>年<%--<span class="sideByside">(限定範圍為3年)</span> --%>
         <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
             ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT  distinct SUBSTRING( CONVERT(VARCHAR(10), [time], 121),0,5) as Column1
    
  FROM  [Data] where time>'2013'   order by Column1 desc"></asp:SqlDataSource>
                 </div>
                
                   </div>

                       </div>
             </div>

                   <div class="btnBox"><%-- style="margin-top:25px"--%>
                        <asp:Button ID="report" runat="server" Text="資料匯出" class="btnAtr btn btn-success " OnClick="report_Click" /><%-- class="btn btn-success pull-right"style="margin-left:5px"--%>
              			   <asp:Button ID="search" runat="server" Text="地圖查詢" class=" btnAtr btn btn-warning" OnClick="search_Click" /><%--class="btn btn-warning pull-right"--%>
                         
              			</div>
    

             </div>
             <%--	<div class="col-md-12">
						 <div class="bs-example" style="min-height: 200px">
							 <p>
								<ul class="listtalk">
									<li>
										綠圈符合法規標準，紅圈不符合法規標準。
									</li>
									<li>
										查詢後點選測點圖示，即可查詢測點詳細資料及監測數據趨勢圖。
									</li>
									<li>
										免責聲明:使用時須瞭解因環境等因素所可能產生之數據變異。
									</li>
                                    <li>
										想查各季人工監測測點位置，請<a href="Data_Site.aspx">點此</a>
									</li>
                                   

								</ul>
							     <p>
                                 </p>
							 </p>
						 </div>
                	</div>--%>
          </div>
      <h5 style="font-weight: normal">   
     </div>
     </div>
   

   
      <div id="map"></div>
      <asp:ScriptManager runat="server"></asp:ScriptManager>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
      <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField2" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField3" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField4" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField5" runat="server" Value="" />
               <asp:HiddenField ID="site" runat="server" Value="" />
                  <asp:HiddenField ID="HiddenField6" runat="server" Value="" />
      <asp:Button ID="data" runat="server" Text="Button" OnClick="data_Click" CssClass="hidden" />
                 </ContentTemplate>
        </asp:UpdatePanel>
     <script type="text/javascript">
         var c = 0;
         map();
        
         $("#lengelfrom").click(function () {
             $("#lengel").toggle();

             if (c == 0) {
                 $("#watericon").attr("src", "image/open.png");
                 c = 1;
             }
             else {
                 $("#watericon").attr("src", "image/close.png");
                 c = 0;
             }
         });
         $("#lengelApp").click(function () {
             $("#lengel").toggle();

             if (c == 0) {
                 $("#waterApp").attr("src", "image/open_app.png");
                 c = 1;
             }
             else {
                 $("#waterApp").attr("src", "image/close_app.png");
                 c = 0;
             }
         });

     </script>

      <div class="modal fade bs-reply-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
          
                      <div class="modal-dialog modal-lg" style="width: 970px;">
                <div class="modal-content">
                     <div class="modal-header">
      <a  style="float:left" href="javascript:hideModal()">  <img src="image/ICON_delete_24.png" /></a>
                        <br>
                         </div>
                     <div class="modal-body">
                        <div class="MainClass">
              <div role="form" class="form-horizontal">
              <div class="form-group">
              
                <div class="col-sm-8">
                  
                    <img src="image/操作說明.jpg" />

                    <a href="Data_Site.aspx" style="position:relative;top: -47px;left: 236px;color:white">______</a>

                </div>
            </div>
            </div>
            </div>
            </div>
            </div>
            </div>
          <asp:HiddenField ID="screenW" runat="server"/>
          </div>


</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="index.master" AutoEventWireup="true" CodeFile="index1.aspx.cs" Inherits="index_index1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript">



        // 顯示讀取遮罩
        function ShowProgressBar() {
            displayProgress();
            displayMaskFrame();
        }

        // 隱藏讀取遮罩
        function HideProgressBar() {
            var progress = $('#divProgress');
            var maskFrame = $("#divMaskFrame");
            progress.hide();
            maskFrame.hide();
        }
        // 顯示讀取畫面
        function displayProgress() {
            var w = $(document).width();
            var h = $(window).height();
            var progress = $('#divProgress');
            progress.css({ "z-index": 999999, "top": (h / 2) - (progress.height() / 2), "left": (w / 2) - (progress.width() / 2) });
            progress.show();
        }
        // 顯示遮罩畫面
        function displayMaskFrame() {
            var w = $(window).width();
            var h = $(document).height();
            var maskFrame = $("#divMaskFrame");
            maskFrame.css({ "z-index": 999998, "opacity": 0.7, "width": w, "height": h });
            maskFrame.show();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script>
         $(function () {
             $("#home").attr("class", "slip");
         });
    </script>
    <script>
        $(function () {
            if ($(window).width() > 991) {
                $('html, body').animate({ scrollTop: 580 }, 1000);
            }
        });
    </script>
              <script src="js/bootstrap.min.js"></script>
        <script>
            function showModal() {
                $('.bs-reply-modal-lg').modal('show');
            }
            function hideModal() {
                $('.bs-reply-modal-lg').modal('hide');
            }
            function showModal2() {
                $('.bs-reply2-modal-lg').modal('show');
            }
            function hideModal2() {
                $('.bs-reply2-modal-lg').modal('hide');
            }
    </script>
     <script>


         function click() {



         }

</script>
          <style type="text/css">
              .site7 {
                  left: -48px;
                  top: 154px;
              }

              .site8 {
                  left: -35px;
                  top: 46px;
              }

              .site1 {
                  left: 170px;
                  top: 200px;
              }

              .site2 {
                  left: 60px;
                  top: 170px;
              }

              .site3 {
                  left: 135px;
                  top: 230px;
              }

              .site4 {
                  left: 30px;
                  top: 165px;
              }

              .site6 {
                  left: -144px;
                  top: 312px;
              }

              .site5 {
                  left: -158px;
                  top: 362px;
              }

              .site1_1 {
                  left: 150px;
                  top: 200px;
              }

              .site2_1 {
                  left: -60px;
                  top: 120px;
              }

              .site3_1 {
                  left: 50px;
                  top: 350px;
              }

              .site4_1 {
                  left: -80px;
                  top: 80px;
              }

              .note1 {
                  left: 233px;
                  top: 284px;
              }

              .note2 {
                  left: 13px;
                  top: 396px;
              }

              .littleShot {
                  text-align: right;
              }
               .site9 {
                  left: 110px;
                  top: 250px;
              }
                .site10 {
                  left: 50px;
                  top: 110px;
              }
              @media(max-width: 1199px) {
                  .site7 {
                      left: -35px;
                      top: 145px;
                  }
                   
                  .site9 {
                  left: 85px;
                  top: 205px;
                  }
                  .site10 {
                  left: 40px;
                  top: 90px;
                  }
                  .site8 {
                      left: -21px;
                      top: 80px;
                  }

                  .site1 {
                      left: 130px;
                      top: 180px;
                  }

                  .site3 {
                      left: 110px;
                      top: 200px;
                  }

                  .site6 {
                      left: -110px;
                      top: 289px;
                  }

                  .site5 {
                      left: -130px;
                      top: 320px;
                  }

                  .site1_1 {
                      left: 110px;
                      top: 215px;
                  }

                  .site2_1 {
                      left: -60px;
                      top: 115px;
                  }

                  .site3_1 {
                      left: 35px;
                      top: 305px;
                  }

                  .site4_1 {
                      left: -70px;
                      top: 115px;
                  }

                  .site2 {
                      left: 49px;
                      top: 156px;
                  }

                  .note1 {
                      left: 190px;
                      top: 240px;
                  }

                  .note2 {
                      left: 12px;
                      top: 398px;
                  }
              }

              @media(max-width: 991px) {
                  .disappear {
                      display: none;
                  }

                  .table-bordered {
                      margin-top: 10px;
                  }

                      .table-bordered > tbody > tr > th, .table-bordered > tbody > tr > td {
                          border: 1px solid #000;
                      }

                      .table-bordered > tbody > tr > th {
                          background-color: #FFF;
                      }
              }

              @media(min-width: 992px) {
                  .mobileShow {
                      display: none;
                  }
              }
          </style>
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <img class="disappear" src="image/index/arrow-right.png" style="position: absolute;top: 275px; left: 48%;"/>
        <img class="disappear" src="image/index/arrow-bottom.png" style="position: absolute; top: 575px;  left: 19.5%;"/>
      <asp:Panel ID="Panel2" runat="server" >

    	<div class="OneShot row" style="margin-bottom:0px">

             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                     <div id="divProgress" style="padding:20px;background-color:White; text-align:center; display: none; position: fixed; top: 50%;  left: 50%;" >
                      <img src="image/Loading.gif" />
            <br />
                <font color="#1B3563" size="2px">資料處理中，請稍後...</font>
            </div>
                  <div id="divMaskFrame" style="background-color: #CCCCCC; display: none; left: 0px;
                    position: absolute; top: 0px;">
            </div>
											<div class="mapbox col-md-6">
												<div class="detailTitle row">
													測站位置圖
												</div>
                                               <span style="font-size:14px"> 點擊園區範圍圖可以放大，在點擊圖示可以返回原圖</span>
												<div class="TwoShot">
                                                    <a>
                                                   
                                                     
                                                        <asp:Panel ID="Panel1" runat="server" class="map" style="background: url(image/index/map_v6.svg) no-repeat center;z-index: -3;background-size:100%;background-color:#fff7d7;border-width:5px;border-color:#333333" OnClick="document.getElementById('ContentPlaceHolder1_Button4').click();" title="點擊放大">                      
                                                    
                                                      

                                                             <asp:Image ID="site8" runat="server"  Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_D_01.png" ToolTip="新營區_EPA"
                                                            title="1" data-trigger="hover"  class="site8"/>
                                                     
                                                            <asp:Image ID="site6" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_B_01.png" ToolTip="安南站_EPA"
                                                            title="1" data-trigger="hover" class="site6"/>    
                                                           <asp:Image ID="site5" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_A_01.png" ToolTip="台南站_EPA"
                                                            title="1" data-trigger="hover" class="site5"/>          
                                                    
                                                    
                                                            <asp:Image ID="site4" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_2_01.png" ToolTip="公19_南科"
                                                            title="1" data-trigger="hover" class="site4"/>   
                                                           
                                                     
                                                            <asp:Image ID="site7" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_C_01.png" ToolTip="善化站_EPA"
                                                            title="1" data-trigger="hover" class="site7"/>   

                                                    
                                                            <asp:Image ID="site1" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_1_01.png" ToolTip="南科實中_南科"
                                                            title="1" data-trigger="hover"  class="site1" /> 
                                                           <p style="margin-bottom:0px;font-size:14px;color:black;position: relative;" class="note1"> 點我放大</p>
                                                            <asp:Image ID="site9" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_3_01.png" ToolTip="公13_南科"
                                                            title="1" data-trigger="hover"   class="site9"/>   
                                                            <asp:Image ID="site10" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_4_01.png" ToolTip="公29_南科"
                                                            title="1" data-trigger="hover" class="site10"/>   
                                                            
                                                        </asp:Panel>
                                                          
                                                    <asp:Panel ID="Panel3" runat="server" class="map" style="background: url(image/index/Big_map.svg) no-repeat center;z-index: -3;background-size:100%;background-color:#D6FCFF;border-width:5px;border-color:#333333" OnClick="document.getElementById('ContentPlaceHolder1_Button4').click();"  title="點擊還原" Visible="false">                      
                                                        <asp:Image ID="site4_1" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                        ImageUrl="image/circle/circleMAP_2_01.png" ToolTip="公19_南科"
                                                        title="1" data-trigger="hover" class="site4_1" />   
                                                        <asp:Image ID="site1_1" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                        ImageUrl="image/circle/circleMAP_1_01.png" ToolTip="南科實中_南科"
                                                        title="1" data-trigger="hover"  class="site1_1" /> 
                                                        <p style="margin-bottom:0px;font-size:14px;color:black;position: relative;" class="note2"> 點我返回</p>
                                                        <asp:Image ID="site3_1" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_3_01.png" ToolTip="公13_南科"
                                                            title="1" data-trigger="hover"   class="site3_1"/> 
                                                        <asp:Image ID="site2_1" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_4_01.png" ToolTip="公29_南科"
                                                            title="1" data-trigger="hover"  class="site2_1" />   
                                                       </asp:Panel>
                                                      
                                                 </a>
												</div>
                                               
                                                 <asp:Button ID="Button4" runat="server" Text="Button" style="visibility:hidden" OnClick="Button4_Click" OnClientClick="ShowProgressBar();"/>		
											</div>
                 </ContentTemplate>
                 </asp:UpdatePanel>
         
											<div class="col-md-6">
												<div class="detailTitle row">
													園區測站
													<div class="MonitoringData pull-right">
														<h5>數據發布時間：<asp:Literal ID="examtime" runat="server" Text=""></asp:Literal></h5>
													</div>
												</div>

                                                <div class="disappear" style="height:20px;">
                                                 <a href="javascript:showModal2()" style="margin-bottom:0px;font-size:14px;text-decoration:underline;color:#337ab7;float:left"> AQI圖示說明</a>
                                                     <p style="margin-bottom:0px;font-size:14px;color:black;margin-left:20px;float:left"> 園區微型感測器  <asp:Literal ID="pm25_4" runat="server"></asp:Literal></p>
													</div>

												<div class="TwoShot">
												<!--	<div class="littleShot">
                                                        <table><tr><td>
														<ul>
															<li><a href="index5.aspx">看平均值</a></li>
															<li><span style="color:blue">看各測站</span></li>
														</ul>	</td><td>
                                                          	</td></tr></table>								
													</div>littleShot-->	
                                                    
                                                    <div class="row">
                                                        	<div class="col-md-12">
															<div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal1" runat="server" Text="style='text-align:center'  "></asp:Literal>>

                                                                	<div class="col-md-6">
                                                                        <div>
                                                                        
                                                                            <div style="width:100%;display:inline-block">
                                                                                 <p style="margin-bottom:0px;"><asp:Image ID="sitebg1" runat="server" style="margin-top:5px;margin-right:10px;height:26px;"/>測點：南科實中</p>
                                                                            </div>
                                                                        </div>
                                                                         <div>
                                                                              <p style="margin-bottom:0px"> <asp:Literal ID="wind1" runat="server"></asp:Literal></p>
                                                                             <p style="margin-bottom:0px"> <asp:Literal ID="pm25_1" runat="server" Visible="False"></asp:Literal></p>
                                                                               <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                               <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv1" runat="server" Text=""></asp:Label></p>
                                                                                <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI1" runat="server" Text=""></asp:Label></p>
                                                                                <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item1" runat="server" Text=""></asp:Label><a href="http://einfo.stsp.gov.tw/FrontEnd/AutoMonitor.aspx?ST=Nankeshizhong&ch=2#" style="padding-left:20px"><img src="image/index/trendPic.png" onmouseover="this.src='image/index/trendPic_W.png';" onfocus="this.src='image/index/trendPic_W.png';" onmouseout="this.src='image/index/trendPic.png';" /></a></p>
                                                                                 <asp:Image ID="siteimg1" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															            </div>
                                                            </div>
                                                            <div class="col-md-6 disappear"  style="padding-left:0px">

                                                                <table class="table">
                                                                    <tr><td style="border-top:none">懸浮微粒</td><td style="border-top:none"> <asp:Literal ID="data1_1" runat="server"></asp:Literal>μg/m<sup>3</sup></td></tr>
                                                                     <tr><td>二氧化硫</td><td><asp:Literal ID="data1_2" runat="server"></asp:Literal>ppb</td></tr>
                                                                     <tr><td>一氧化碳</td><td><asp:Literal ID="data1_3" runat="server"></asp:Literal>ppm</td></tr>
                                                                     <tr><td>臭氧</td><td><asp:Literal ID="data1_4" runat="server"></asp:Literal>ppb</td></tr>
                                                                     <tr><td>二氧化氮</td><td><asp:Literal ID="data1_5" runat="server"></asp:Literal>ppb</td></tr>
                                                                     <tr><td>細懸浮微粒</td><td><asp:Literal ID="data1_6" runat="server"></asp:Literal>μg/m<sup>3</sup></td></tr>

                                                                </table>
                                                            </div>
                                                            </div>															
														</div>
														
														<div class="col-md-6" style="display:none">
															<div class="NankeDashboard"
                                                                <asp:Literal ID="Literal2" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                 <p style="margin-bottom:0px"> <asp:Image ID="sitebg2" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：公29</p>
                                                               <p style="margin-bottom:0px"> <asp:Literal ID="wind2" runat="server"></asp:Literal></p>
                                                                 <%--  <p style="margin-bottom:20px"></p>--%>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv2" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI2" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item2" runat="server" Text=""></asp:Label><a href="http://einfo.stsp.gov.tw/FrontEnd/AutoMonitor.aspx?ST=Gong_29&ch=2#" style="padding-left:20px"><img src="image/index/trendPic.png" onmouseover="this.src='image/index/trendPic_W.png';" onfocus="this.src='image/index/trendPic_W.png';" onmouseout="this.src='image/index/trendPic.png';" /></a></p>
                                                                  <asp:Image ID="siteimg2" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>														
														</div>														
													</div>
													<div class="row">
													
														<div class="col-md-6"  style="display:none">
                                                            <div class="NankeDashboard" 
                                                            <asp:Literal ID="Literal3" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg3" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：公13</p>
                                                                    <p style="margin-bottom:0px"> <asp:Literal ID="wind3" runat="server"></asp:Literal></p>
                                                               <%--   <p style="margin-bottom:20px"></p>--%>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv3" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI3" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item3" runat="server" Text=""></asp:Label><a href="http://einfo.stsp.gov.tw/FrontEnd/AutoMonitor.aspx?ST=Gong_13&ch=2#" style="padding-left:20px"><img src="image/index/trendPic.png" onmouseover="this.src='image/index/trendPic_W.png';" onfocus="this.src='image/index/trendPic_W.png';" onmouseout="this.src='image/index/trendPic.png';" /></a></p>
                                                                  <asp:Image ID="siteimg3" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>			
																												
														</div>	
                                                        <div class="col-md-12">
															<div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal4" runat="server" Text="style='text-align:center'  "></asp:Literal> >
                                                                <div class="col-md-6">
                                                                    <p style="margin-bottom:0px">   <asp:Image ID="sitebg4" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：公19</p>
                                                                    <p style="margin-bottom:0px"> <asp:Literal ID="wind4" runat="server"></asp:Literal></p>
                                                                         <p style="margin-bottom:0px"> <asp:Literal ID="pm25_2" runat="server" Visible="False"></asp:Literal></p>
                                                                      <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                       <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv4" runat="server" Text=""></asp:Label></p>
                                                                       <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI4" runat="server" Text=""></asp:Label></p>
                                                                       <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item4" runat="server" Text=""></asp:Label><a href="http://einfo.stsp.gov.tw/FrontEnd/AutoMonitor.aspx?ST=Gong_19&ch=2#" style="padding-left:20px"><img src="image/index/trendPic.png" onmouseover="this.src='image/index/trendPic_W.png';" onfocus="this.src='image/index/trendPic_W.png';" onmouseout="this.src='image/index/trendPic.png';" /></a></p>
                                                                   
                                                                       <asp:Image ID="siteimg4" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
                                                                    </div>		
                                                                <div class="col-md-6 disappear" style="padding-left:0px">

                                                                      <table class="table">
                                                                    <tr><td style="border-top:none">懸浮微粒</td><td style="border-top:none"> <asp:Literal ID="data2_1" runat="server"></asp:Literal>μg/m<sup>3</sup></td></tr>
                                                                     <tr><td>二氧化硫</td><td><asp:Literal ID="data2_2" runat="server"></asp:Literal>ppb</td></tr>
                                                                     <tr><td>一氧化碳</td><td><asp:Literal ID="data2_3" runat="server"></asp:Literal>ppm</td></tr>
                                                                     <tr><td>臭氧</td><td><asp:Literal ID="data2_4" runat="server"></asp:Literal>ppb</td></tr>
                                                                     <tr><td>二氧化氮</td><td><asp:Literal ID="data2_5" runat="server"></asp:Literal>ppb</td></tr>
                                                                     <tr><td>細懸浮微粒</td><td><asp:Literal ID="data2_6" runat="server"></asp:Literal>μg/m<sup>3</sup></td></tr>

                                                                </table>
                                                                     </div>		
															</div>														
														</div>													
													</div>
												  </div><!--TwoShot-->
											</div>										
										</div><!--OneShot row-->
            
										<div class="OneShot row">
											<div class="col-md-12">
												<div class="detailTitle row">
													環保署測站
													<div class="MonitoringData pull-right">
														<h5>數據發布時間：<asp:Literal ID="examtime2" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
													</div>
												</div>
												<div class="TwoShot">
                                                  <div class="row">
														<div class="col-md-3">
													
                                                            	<div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal5" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg5" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：台南站</p>
                                                                 <p style="margin-bottom:0px"> <asp:Literal ID="wind5" runat="server"></asp:Literal></p>
                                                                   <%--   <p style="margin-bottom:20px"></p>--%>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv5" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI5" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item5" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimg5" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>															
														</div>
														<div class="col-md-3">
														
                                                            	<div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal6" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg6" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：安南站</p>
                                                                      <p style="margin-bottom:0px"> <asp:Literal ID="wind6" runat="server"></asp:Literal></p>
                                                                  <%--    <p style="margin-bottom:20px"></p>--%>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv6" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI6" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item6" runat="server" Text=""></asp:Label></p>
                                                                     <asp:Image ID="siteimg6" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>														
														</div>
														<div class="col-md-3">
														
                                                            <div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal7" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg7" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：善化站</p>
                                                                      <p style="margin-bottom:0px"> <asp:Literal ID="wind7" runat="server"></asp:Literal></p>
                                                                  <p style="margin-bottom:0px"> <asp:Literal ID="pm25_3" runat="server" Visible="False"></asp:Literal></p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv7" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI7" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item7" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimg7" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>															
														</div>
														<div class="col-md-3">
																
                                                            <div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal8" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg8" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：新營站</p>
                                                                  <p style="margin-bottom:0px"> <asp:Literal ID="wind8" runat="server"></asp:Literal></p>
                                                                 <%-- <p style="margin-bottom:20px"></p>--%>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv8" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI</a>：<asp:Label ID="AQI8" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center"><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">指標物</a>：<asp:Label ID="item8" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimg8" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>													
														</div>
														<div class="littleShot"><%-- pull-right--%>
															<ul>
																<li><a href="AQI_Detail.aspx">查詳細監測資料＞＞</a></li>
															</ul>															
														</div><!--littleShot-->	


                                                 
														<div class="littleList"><%-- style="padding-top:300px"--%>
															<ul>
																<li>無資料時為設備維護(測站例行維護、儀器異常維修、監測數據不足)</li>
																<li><a href="javascript:showModal()">免責聲明</a> (使用本網站數據請先詳閱)</li>
																<li><a href="https://airtw.epa.gov.tw" target="_blank" style="text-decoration:underline;color:#337ab7">AQI(空氣品質)</a>圖示說明<br><img class="disappear" src="image/index/PIC02.PNG"></li>
															</ul>
                                                             <table class="table table-bordered mobileShow" style="width:90%;">
                                                            <tr>
                                                                <th>良好</th>
                                                                <td style="background-color:#00e800;">0~50</td>
                                                            </tr>
                                                            <tr>
                                                                <th>普通</th>
                                                                <td style="background-color:#ffff00;">51~100</td>
                                                            </tr>
                                                            <tr>
                                                                <th>對敏感族群不健康</th>
                                                                <td style="background-color:#ff7e00;">101~150</td>
                                                            </tr>
                                                            <tr>
                                                                <th>對所有族群不健康</th>
                                                                <td style="background-color:#ff0000;">151~200</td>
                                                            </tr>
                                                            <tr>
                                                                <th>非常不健康</th>
                                                                <td style="color:#FFF;background-color:#8f3f97;">201~300</td>
                                                            </tr>
                                                            <tr>
                                                                <th>危害</th>
                                                                <td style="color:#FFF;background-color:#7e0023;">301~500</td>
                                                            </tr>
                                                        </table>
														</div>		
                                                         									
													 </div>
                                                     												
												</div><!--TwoShot-->
											</div>
										</div><!--OneShot row-->
          </asp:Panel>

           <div class="modal fade bs-reply2-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
          
                      <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        
                         </div>
                     <div class="modal-body">
                        <div class="MainClass">
              <div role="form" class="form-horizontal">
              <div class="form-group">
              
                <div class="col-sm-8">
                  
                   <img src="image/index/PIC02.PNG">

                </div>
            </div>
            </div>
            </div>
            </div>
            </div>
            </div>
          </div>



       <div class="modal fade bs-reply-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
          
                      <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        
                         </div>
                     <div class="modal-body">
                        <div class="MainClass">
              <div role="form" class="form-horizontal">
              <div class="form-group">
              
                <div class="col-sm-8">
                  
                    <img src="img/statement.png" />

                </div>
            </div>
            </div>
            </div>
            </div>
            </div>
            </div>
          </div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="index.master" AutoEventWireup="true" CodeFile="index5.aspx.cs" Inherits="index_index5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
     <script>
         $(function () {
             $("#home").attr("class", "slip");
         });
    </script>
    <script>
        $(function () { $('html, body').animate({ scrollTop: 500 }, 1000); });
    </script>
              <script src="js/bootstrap.min.js"></script>
        <script>
            function showModal() {
                $('.bs-reply-modal-lg').modal('show');
            }
            function hideModal() {
                $('.bs-reply-modal-lg').modal('hide');
            }

    </script>
     <style type="text/css">
         .siteA {
           left: 330px; top: 230px;
                }
              .site7 {
             left: -55px; top: 95px;
                }
              .site8 {
               left: -30px; top: 20px;
                }

               .site1 {
               left: 170px; top: 200px;
                }
              .site2 {
              left: 60px; top: 170px;
                }
              .site3 {
              left: 155px; top: 230px;
                }
               .site4 {
               left: 30px; top: 165px;
                }
              .site6 {
              left: -135px; top: 295px;
                }
             .site5 {
             left: -170px; top: 370px;
                }
              .site1_1 {
              left: 160px; top: 190px;
                }
             .site2_1 {
             left: -45px; top: 200px;
                }
              .site3_1 {
              left: 145px; top: 320px;
                }
            .site4_1 {
            left: -90px; top: 65px;
                }
              @media(max-width: 1024px) {
                   .siteA {
           left: 250px; top: 190px;
                }
                   .site7 {
                     left: -35px; top: 105px;
                  }
                  .site8 {
                      left: -40px;
                      top: 70px;
                  }
                  .site1 {
                     left: 130px;
                     top: 180px;
                  }
                  .site3 {
                      left: 130px;
                     top: 200px;
                  }
                     .site6 {
                  left: -115px; top: 285px;
                }
                  .site5 {
                 left: -120px; top: 340px;
                }
                   .site1_1 {
                    left: 130px; top: 200px;
                    }
                    .site2_1 {
                    left: -40px; top: 190px;
                    }
                    .site3_1 {
                    left: 105px; top: 290px;
                    }
                    .site4_1 {
                    left: -80px; top: 85px;
                    }
              }
               
        }



           </style>
     <img src="image/index/arrow-right.png" style="position: absolute;top: 275px; left: 48%;"/>
        <img src="image/index/arrow-bottom.png" style="position: absolute; top: 575px;  left: 19.5%;"/>
      <asp:Panel ID="Panel2" runat="server" >
    	<div class="OneShot row">
											<div class="mapbox col-md-6">
												<div class="detailTitle row">
													測站位置圖
												</div>
												<div class="TwoShot">

                                                     <asp:Panel ID="Panel1" runat="server" class="map" style="background: url(image/index/map_v6.svg) no-repeat center;z-index: -3;background-size:100%;background-color:#fff7d7;border-width:5px;border-color:#333333" >                      
                                                        <asp:Image ID="site8" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_D_01.png" ToolTip="新營區_EPA"
                                                            title="1" data-trigger="hover" class="site8"/>
                                                        <asp:Image ID="site6" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_B_01.png" ToolTip="安南站_EPA"
                                                            title="1" data-trigger="hover" class="site6"/>    
                                                        <asp:Image ID="site5" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_A_01.png" ToolTip="台南站_EPA"
                                                            title="1" data-trigger="hover" class="site5"/>          
                                                     <asp:ImageButton ID="siteA" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_1_01.png" ToolTip="平均值" OnClick="site1_Click"
                                                            title="1" data-trigger="hover" class="siteA"/> 
                                                  
                                                           
                                                     <asp:Image ID="site7" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_C_01.png" ToolTip="善化站_EPA"
                                                            title="1" data-trigger="hover" class="site7"/>   

                                               </asp:Panel>

												</div>
											</div>
											<div class="col-md-6">
												<div class="detailTitle row">
													園區測站
													<div class="MonitoringData pull-right">
														<h5>數據發布時間：<asp:Literal ID="examtime" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
													</div>
												</div>
												<div class="TwoShot" style="height:485px">
												<div class="littleShot">
														<ul>
															<li><span style="color:blue">看平均值</span></li>
															<li><a href="index1.aspx">看各測站</a></li>
														</ul>															
													</div><!--littleShot-->
													<div class="row"  >
                                                        	<div class="col-md-12" >
															<div class="NankeDashboard" 
                                                                 <asp:Literal ID="LiteralA" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                <p style="margin-top:20px;margin-bottom:40px;font-size:24px"><asp:Image ID="sitebgA" runat="server" style="margin-top:0px;margin-right:10px;"/>測點：平均值</p>
                                                           <%--       <p style="margin-bottom:0px;font-size:24px"> <asp:Literal ID="windA" runat="server"></asp:Literal></p>--%>
                                                                   <p style="width:100%;font-size:24px;position:absolute;padding-right:25px;margin-top:85px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:125px;text-align:center;font-size:20px"><asp:Label ID="lvA" runat="server" Text="" style="font-size:24px;font-weight:bold"></asp:Label></p>
                                                                    <p style="width:100%;font-size:24px;position:absolute;padding-right:25px;margin-top:220px;text-align:center">AQI：<asp:Label ID="AQIA" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;font-size:24px;position:absolute;padding-right:25px;margin-top:260px;text-align:center">指標物：<asp:Label ID="itemA" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimgA" runat="server" ImageUrl="image/index/board/DashboardPic_2_00.png" style="margin-top:-5px;margin-bottom:55px;"/>
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
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv5" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center">AQI：<asp:Label ID="AQI5" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center">指標物：<asp:Label ID="item5" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimg5" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>															
														</div>
														<div class="col-md-3">
														
                                                            	<div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal6" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg6" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：安南站</p>
                                                                      <p style="margin-bottom:0px"> <asp:Literal ID="wind6" runat="server"></asp:Literal></p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv6" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center">AQI：<asp:Label ID="AQI6" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center">指標物：<asp:Label ID="item6" runat="server" Text=""></asp:Label></p>
                                                                     <asp:Image ID="siteimg6" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>														
														</div>
														<div class="col-md-3">
														
                                                            <div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal7" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg7" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：善化站</p>
                                                                      <p style="margin-bottom:0px"> <asp:Literal ID="wind7" runat="server"></asp:Literal></p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv7" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center">AQI：<asp:Label ID="AQI7" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center">指標物：<asp:Label ID="item7" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimg7" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>															
														</div>
														<div class="col-md-3">
																
                                                            <div class="NankeDashboard" 
                                                                <asp:Literal ID="Literal8" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                  <p style="margin-bottom:0px"><asp:Image ID="sitebg8" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：新營區</p>
                                                                  <p style="margin-bottom:0px"> <asp:Literal ID="wind8" runat="server"></asp:Literal></p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:25px;margin-top:65px;text-align:center;font-size:20px"><asp:Label ID="lv8" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:90px;text-align:center">AQI：<asp:Label ID="AQI8" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:25px;margin-top:130px;text-align:center">指標物：<asp:Label ID="item8" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimg8" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:15px;"/>
															</div>													
														</div>
														<div class="littleShot pull-right">
															<ul>
																<li><a href="AQI_Detail.aspx">查更多監測資料＞＞</a></li>
															</ul>															
														</div><!--littleShot-->	
														<div class="littleList">
															<ul>
																<li>無資料時為設備維護(測站例行維護、儀器異常維修、監測數據不足)</li>
																<li><a href="javascript:showModal()">免責聲明</a> (使用本網站數據請先詳閱)</li>
																<li>AQI(空氣品質)圖示說明<br><img src="image/index/PIC02.PNG"></li>
															</ul>
														</div>													
													
                                                      </div>												
												</div><!--TwoShot-->
											</div>
										</div><!--OneShot row-->
          </asp:Panel>

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


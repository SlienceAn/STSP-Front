<%@ Page Title="" Language="C#" MasterPageFile="index.master" AutoEventWireup="true" CodeFile="index3.aspx.cs" Inherits="index_index3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <script>
            $(function () { $('html, body').animate({ scrollTop: 500 }, 1000); });
    </script>
      <script>
          function showModal2() {
              $('.bs-reply2-modal-lg').modal('show');
          }
          function hideModal2() {
              $('.bs-reply2-modal-lg').modal('hide');
          }

    </script>
      <style type="text/css">
          .site {
              left: 130px;
              top: 160px;
          }

          @media(max-width: 1024px) {
              .site {
                  left: 100px;
                  top: 180px;
              }
          }

          @media(max-width: 991px) {
              .disappear {
                  display: none;
              }

              .OneShot {
                  margin-bottom: 0px;
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
              display:none;
              }
          }
      </style>
     <img class="disappear" src="image/index/arrow-right.png" style="position: absolute;top: 275px; left: 48%;"/>
       
   <asp:Panel ID="Panel2" runat="server" >
    <div class="OneShot row">
											<div class="mapbox col-md-6">
												<div class="detailTitle row">
													測站位置圖
												</div>
												<div class="TwoShot">

                                                     <asp:Panel ID="Panel1" runat="server" class="map" style="background: url(image/index/map_v7.svg) no-repeat center;z-index: -3;background-size:100%;background-color:#fff7d7;border-width:5px;border-color:#333333" >                      
                                                        <asp:ImageButton ID="siteA" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_1_01.png" ToolTip="橋頭站"
                                                            title="1" data-trigger="hover" class="site"/>
                                                               
                                                        </asp:Panel>





												</div>
											</div>
											<div class="col-md-6">
												<div class="detailTitle row">
													環保署測站
													<div class="MonitoringData pull-right">
														<h5>數據發布時間：<asp:Literal ID="examtime" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
													</div>
												</div>
												<div class="TwoShot">
													<!--<div class="littleShot">
														<ul>
															<li><a href="#">看平均值</a></li>
															<li><a href="#">看平均值</a></li>
														</ul>															
													</div>littleShot-->
                                                     <a class="disappear" href="javascript:showModal2()" style="margin-bottom:0px;font-size:14px;text-decoration:underline;color:#337ab7;"> AQI圖示說明</a>
												<div class="row"  >
                                                        	<div class="col-md-6" >
															<div class="NankeDashboard" 
                                                                 <asp:Literal ID="LiteralA" runat="server" Text="style='text-align:center'  "></asp:Literal>>
                                                                <p style="margin-top:20px"><asp:Image ID="sitebgA" runat="server" style="margin-top:5px;margin-right:10px;"/>測點：橋頭站</p>
                                                                  <p style="margin-bottom:0px"> <asp:Literal ID="windA" runat="server"></asp:Literal></p>
                                                                   <p style="width:100%;position:absolute;padding-right:35px;margin-top:45px;text-align:center">空氣品質</p>
                                                                   <p style="width:100%;position:absolute;padding-right:35px;margin-top:65px;text-align:center;"><asp:Label ID="lvA" runat="server" Text="" ></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:35px;margin-top:90px;text-align:center">AQI：<asp:Label ID="AQIA" runat="server" Text=""></asp:Label></p>
                                                                    <p style="width:100%;position:absolute;padding-right:35px;margin-top:130px;text-align:center">指標物：<asp:Label ID="itemA" runat="server" Text=""></asp:Label></p>
                                                                    <asp:Image ID="siteimgA" runat="server" ImageUrl="image/index/board/DashboardPic00.png" style="margin-top:-5px;margin-bottom:55px;"/>
															</div>															
														</div>
														
																							
													</div>
												  </div><!--TwoShot-->
											</div>										
										</div><!--OneShot row-->
        </asp:Panel>
										<div class="OneShot row">
											<div class="col-md-12">
												
												<div class="TwoShot">
													<div class="row">
														
													<!--	<div class="littleShot pull-right">
															<ul>
																<li><a href="#">查更多監測資料＞＞</a></li>
															</ul>															
														</div>littleShot-->	
													<div class="littleList">
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
</asp:Content>


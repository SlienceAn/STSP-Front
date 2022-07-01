<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="sitemap.aspx.cs" Inherits="index_sitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        $(function () {
            $("#byHand").attr("class", "slip");
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<ol class="breadcrumb"><!--現在位置導覽列-->
				  <li class="breadcrumb-item"><a href="index5.aspx">首頁</a></li>
				  <li class="breadcrumb-item active"><a href="#">人工批次檢測</a></li>
            </ol>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
      </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
            
      <div class="content-inside">
                <div class="Subtxt">
                    <div class="subTitle">
                        <h3>人工批次監測</h3>
                    </div>
                </div><!--Subtxt-->
           <div class="softwareText">
               <div class="col-md-8">
               <div class="form-group row">
	            <label for="inputEmail3" class="col-sm-2 col-form-label">選擇園區</label>
                <div class="col-sm-10">
                   <asp:DropDownList ID="area" runat="server" DataSourceID="SqlDataSource1" DataTextField="area_name" DataValueField="area_id" OnDataBound="area_DataBound" AutoPostBack="True" OnSelectedIndexChanged="area_SelectedIndexChanged"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT DISTINCT [area_id], [area_name] FROM [C_Detect_Area]"></asp:SqlDataSource>
                </div>
                </div>
                     <div class="form-group row">
        	<label for="inputEmail3" class="col-sm-2 col-form-label">選擇類別</label>
        <div class="col-sm-10">
                                <asp:DropDownList ID="cclass" runat="server" DataSourceID="SqlDataSource2" DataTextField="class_name" DataValueField="class_id" AutoPostBack="True" OnDataBound="eid_DataBound"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT '0' as [class_id],'全部' as  [class_name] union SELECT DISTINCT [class_id], [class_name] FROM [C_Detect_Class]"></asp:SqlDataSource>
          </div>
           </div>
              



                     <div class="form-group row">
          	<label for="inputEmail3" class="col-sm-2 col-form-label">選擇項目</label>
       <div class="col-sm-10">
           <asp:DropDownList ID="item" runat="server" DataSourceID="SqlDataSource3" DataTextField="itemName" DataValueField="item_id" OnDataBound="item_DataBound"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT '0' as item_id,'全部' as  [itemName] union SELECT DISTINCT t1.[item_id], [itemName] FROM [Detect_Item] as t1 
                                                                                                                             inner join [Detect_ClassItmeMapping] as t2
                                                                                                                             on t1.item_id=t2.item_id
                                                                                                                             where t2.class_id=@class_id ">
            <SelectParameters>
                <asp:ControlParameter ControlID="cclass" Name="class_id" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
             </div>
                          </div>
                <div class="form-group row">
            
           <label for="inputEmail3" class="col-sm-2 col-form-label">選擇時間</label>
           
               <div class="col-sm-10">
                   <p style="float:left;margin-top:5px">最近</p>
         <asp:RadioButtonList ID="time" runat="server" RepeatDirection="Horizontal"  style="margin-left:0px"
                         AutoPostBack="True" onselectedindexchanged="time_SelectedIndexChanged" RepeatColumns="3">
             <asp:ListItem Value="1"  Selected="True" style="padding-left: 5px"> 1年</asp:ListItem>
             <asp:ListItem Value="2"  style="padding-left: 5px">2年</asp:ListItem>
             <asp:ListItem Value="3" style="padding-left: 5px">3年</asp:ListItem>
             <asp:ListItem Value="0" style="padding-left: 5px">自訂：</asp:ListItem>
         </asp:RadioButtonList>
      
        <div style="position:absolute;left:150px;top:40px">
             <asp:DropDownList ID="year1" runat="server" 
             DataSourceID="SqlDataSource4" DataTextField="Column1" DataValueField="Column1" 
                         Enabled="False" AutoPostBack="True" 
                         onselectedindexchanged="year1_SelectedIndexChanged">
             </asp:DropDownList>年~
                  <asp:DropDownList ID="year2" runat="server" 
             DataSourceID="SqlDataSource4" DataTextField="Column1" DataValueField="Column1"  
                         Enabled="False" AutoPostBack="True" 
                         onselectedindexchanged="year2_SelectedIndexChanged" AppendDataBoundItems="True">
                      
             </asp:DropDownList>年 (限定範圍為3年)
         <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
             ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT  distinct SUBSTRING( CONVERT(VARCHAR(10), [time], 121),0,5) as Column1
    
  FROM  [Data] where time>'2013' and time<'2020'  order by Column1 desc"></asp:SqlDataSource>
                 </div>
                


                       </div>
             </div>
                   <div class="btnBox">
              			   <asp:Button ID="search" runat="server" Text="查詢" class="btn btn-warning pull-right" OnClick="search_Click" />
              			</div>
    

             </div>
     
                       	<div class="col-md-4">
						 <div class="bs-example" style="min-height: 200px">
							 <p>
								<ul class="listtalk">
									<%--<li>
										綠圈符合法規標準，紅圈不符合法規標準。
									</li>--%>
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
                	</div>
                </div><!--softwareText-->
             
          <p style="color:black;" class="col-md-12">點選測點即可查詢監測數據趨勢圖。</p>
      <iframe src="Default.aspx" frameborder="0" height="500" width="100%"></iframe>

  </div>
               </ContentTemplate>   
         </asp:UpdatePanel>    
</asp:Content>


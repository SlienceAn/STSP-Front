<%@ Page Title="" Language="C#" MasterPageFile="~/index/MasterPage.master" AutoEventWireup="true" CodeFile="onlimitdata.aspx.cs" Inherits="index_onlimitdata" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="content-inside">
                <div class="Subtxt">
                    <div class="subTitle">
                      超標資料查詢
                    </div>
                </div><!--Subtxt-->
    <div class="softwareText">
               <div class="col-md-8">
               <div class="form-group row">
	            <label for="inputEmail3" class="col-sm-3 col-form-label">測項</label>
                      <div class="col-sm-9">
    <asp:DropDownList ID="item" runat="server" DataSourceID="SqlDataSource1" DataTextField="itemNameSys" DataValueField="item_id" OnSelectedIndexChanged="item_SelectedIndexChanged"  AutoPostBack="True"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="SELECT '0' as item_id,'0' as [class],'全部' as  [itemNameSys] union
SELECT distinct t2.item_id
       ,[class]
      ,t2.itemNameSys
  FROM [Data] as t1
  inner join Detect_Item as t2
  on t1.item = t2.item_id and background is null   and t2.[createTime]>'2017-09-01'
 ">
       
      </asp:SqlDataSource>
              </div>
         	</div>
                 <div class="form-group row">
            
           <label for="inputEmail3" class="col-sm-3 col-form-label"> 時間</label>
           
               <div class="col-sm-9">
                   <p style="float:left;margin-top:5px">最近</p>
         <asp:RadioButtonList ID="time" runat="server" RepeatDirection="Horizontal"  style="margin-left:0px"
                         AutoPostBack="True" onselectedindexchanged="time_SelectedIndexChanged" RepeatColumns="3">
             <asp:ListItem Value="1" style="padding-left: 5px"> 1年</asp:ListItem>
             <asp:ListItem Value="2" Selected="True" style="padding-left: 5px">2年</asp:ListItem>
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
    
  FROM  [Data] where time>'2013' order by Column1 desc"></asp:SqlDataSource>
                 </div>
                


                       </div>
             </div>
                   <div class="btnBox">
              			   <asp:Button ID="search" runat="server" Text="查詢" class="btn btn-warning pull-right" OnClick="search_Click" />
              			</div>
                   	</div>
    <hr>







         <div class="MainClass">
   <div id="up" runat="server" class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups" style="margin:5px">
      
                      <div class="btn-group pull-right" role="group" aria-label="First group">
             
                 <div class="NumberOfPages" style="float:left"> 第  <asp:Label ID="lblPageIndex" runat="server" Text="0" CssClass="Number"></asp:Label>  頁    </div>
             
                 <div class="NumberOfPages" style="float:left"> 總計 <asp:Label ID="lblDataCount" runat="server" Text="0" CssClass="Number"></asp:Label> 筆    </div>
                 <div class="NumberOfPages" style="float:left">跳至</div>
              
                
             <asp:DropDownList ID="ddlPageIndex" runat="server" AutoPostBack="True"  style="width: auto;float:left"  onselectedindexchanged="ddlPageIndex_SelectedIndexChanged" >
                </asp:DropDownList>
                <div class="NumberOfPages" style="float:left">頁 </div>
                <div class="NumberOfPages" style="float:left"><asp:LinkButton ID="lkbPagePrev" runat="server" onclick="lkbPagePrev_Click">上一頁</asp:LinkButton>
                <asp:LinkButton ID="lkbPageNext" runat="server" onclick="lkbPageNext_Click" >下一頁</asp:LinkButton></div>
                <div class="NumberOfPages" style="float:left">每頁顯示</div>
                
                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True"   style="width: auto;float:left" onselectedindexchanged="ddlPageSize_SelectedIndexChanged" >
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem >10</asp:ListItem>
                    <asp:ListItem Selected="True">50</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                </asp:DropDownList>
                 <div class="NumberOfPages" style="float:left">筆</div>

                  </div>
            </div>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource5"  ondatabound="GridView1_DataBound"
        class="table table-condensed MisTable" style="width:100%"
      AllowPaging="True" AllowSorting="True" DataKeyNames="data_id" PageSize="50">
       <EmptyDataTemplate>
                      該測項無資料
                  </EmptyDataTemplate>
         <HeaderStyle  ForeColor="#FFFFFF" BackColor="#0079A8" />
        <RowStyle  BackColor="#FFFFFF"  />
        <AlternatingRowStyle  BackColor="#E6E6E6"  />
        <Columns>
            <asp:BoundField DataField="data_id" HeaderText="data_id"  SortExpression="data_id"  Visible="False" />
            <asp:BoundField DataField="class_name" HeaderText="監測類別" SortExpression="class_name" />
            <asp:BoundField DataField="siteName" HeaderText="測點" SortExpression="siteName" />
            <asp:BoundField DataField="itemNameSys" HeaderText="監測項目" SortExpression="itemNameSys" />
            <asp:BoundField DataField="time" HeaderText="採樣日期" SortExpression="time" />
            <asp:BoundField DataField="val" HeaderText="監測測值" SortExpression="val" />
            <asp:BoundField DataField="unit" HeaderText="單位" SortExpression="unit" />
            <asp:BoundField DataField="up_limit" HeaderText="上限值" SortExpression="up_limit" />
            <asp:BoundField DataField="down_limit" HeaderText="下限值" SortExpression="down_limit" />
        </Columns>
    </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sin %>" 
        SelectCommand="SELECT t1.[data_id]
      ,[excel_id]
      ,t2.area_name
      ,[cause]
      ,t3.class_name
      ,t4.siteName
      ,t5.itemNameSys
      , CONVERT(VARCHAR(10),[time],121) as [time]
      ,[val] ,[val_num] 
	  ,t5.unit
	  ,t6.up_limit
	  ,t6.down_limit
  FROM [Data] as t1
  left join [C_Detect_Area] as t2
  on t1.area = t2.area_id
   left join C_Detect_Class as t3
  on t1.class = t3.class_id
  left join DetectSite_A as t4
  on t1.class = t4.class_id and t1.site=t4.site_id
  left join tV_ItemClass as t5
  on t1.class = t5.class_id  and t1.item = t5.item_id 
  left join law_data as t6
  on t6.CIM_id=t5.CIM_id
 -- inner join DataExlaw as t7
--  on t1.data_id=t7.data_id
  where 1=1 and t5.background is  null ">
               
    </asp:SqlDataSource>

            <div id="down" runat="server" class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
                      <div class="btn-group pull-right" role="group" aria-label="First group">
             
                 <div class="NumberOfPages" style="float:left"> 第  <asp:Label ID="lblPageIndex2" runat="server" Text="0" CssClass="Number"></asp:Label>  頁    </div>
             
                 <div class="NumberOfPages" style="float:left"> 總計 <asp:Label ID="lblDataCount2" runat="server" Text="0" CssClass="Number"></asp:Label> 筆    </div>
                 <div class="NumberOfPages" style="float:left">跳至</div>
              
                
                  <asp:DropDownList ID="ddlPageIndex2" runat="server" AutoPostBack="True"   style="width: auto;float:left"
                    onselectedindexchanged="ddlPageIndex_SelectedIndexChanged" >
                </asp:DropDownList>
                <div class="NumberOfPages" style="float:left">頁 </div>
                <div class="NumberOfPages" style="float:left"><asp:LinkButton ID="lkbPagePrev2" runat="server" onclick="lkbPagePrev_Click">上一頁</asp:LinkButton>
                <asp:LinkButton ID="lkbPageNext2" runat="server" onclick="lkbPageNext_Click">下一頁</asp:LinkButton></div>
                <div class="NumberOfPages" style="float:left">每頁顯示</div>
                
                <asp:DropDownList ID="ddlPageSize2" runat="server" AutoPostBack="True"  style="width: auto;float:left"                                                                              onselectedindexchanged="ddlPageSize2_SelectedIndexChanged">
                         <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem >10</asp:ListItem>
                    <asp:ListItem Selected="True">50</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                </asp:DropDownList>
                 <div class="NumberOfPages" style="float:left">筆</div>

                  </div>
            </div>
                  </div>

        	</div>
</asp:Content>


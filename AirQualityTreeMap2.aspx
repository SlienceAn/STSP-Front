<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AirQualityTreeMap2.aspx.cs" Inherits="index_AirQualityTreeMap2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  
    <script type="text/javascript" src="js/d3.js" charset="utf-8"></script>
    <script type="text/javascript" src="js/d3.layout.js" charset="utf-8"></script>
    <style type="text/css">

.chart {
  display: block;
  margin: auto;
  margin-top: 40px;
}

text {
  font-size: 11px;
}

rect {
  fill: none;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        
     
      <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
     <contenttemplate>--%>

      
              <%-- <div class="content container" >--%>
            <ol class="breadcrumb"><!--現在位置導覽列-->
				  <li class="breadcrumb-item"><a href="#">首頁</a></li>
				  <li class="breadcrumb-item active"><a href="#">筆數變化</a></li>
            </ol>
	        <div class="content-inside">
                <div class="Subtxt">
                    <div class="subTitle">
                        <h3>筆數變化</h3>
                    </div>
                </div><!--Subtxt-->
                  <div class="softwareText">
             基於效果，統計資料每天深夜一點開始運算。
         <br> <br>
          <table style=" margin: 0px;">
      <tr>
      <td ><p style=" padding: 10px; background-color: #e34724; "></p></td>
      <td >高雄</td>
       <td ><p style=" padding: 10px; background-color: #ffb200; "></p></td>
      <td >台南</td>
     <%--  <td ><p style=" padding: 10px; background-color: #4bbb41; "></p></td>
      <td >七星農場</td>
       <td ><p style=" padding: 10px; background-color: #0063db; "></p></td>
      <td >二林園區</td>
       <td ><p style=" padding: 10px; background-color: #00d8e1; "></p></td>
      <td >高等園區</td>
       <td ><p style=" padding: 10px; background-color: #30874d; "></p></td>
      <td >台中擴建</td>--%>
     

      </tr>
    
      </table>

           	<div class="row" style="overflow: auto">
      <div id="body" style="min-height:600px">
    
    </div>
      </div>
  </div>

      </div>
      

    <script type="text/javascript" charset="utf-8">

        var w = 900,
    h = 465,
    x = d3.scale.linear().range([0, w]),
    y = d3.scale.linear().range([0, h]),
    color = d3.scale.category20c(),
    root,
    node;

        var treemap = d3.layout.treemap()
    .round(false)
    .size([w, h])
    .sticky(true)
    .value(function (d) { return d.size; });

        var svg = d3.select("#body").append("div")
    .attr("class", "chart")
    .style("width", w + "px")
    .style("height", h + "px")
  .append("svg:svg")
    .attr("width", w)
    .attr("height", h)
  .append("svg:g")
    .attr("transform", "translate(.5,.5)");

        d3.json("flare.txt", function (data) {
            node = root = data;

            var nodes = treemap.nodes(root)
      .filter(function (d) { return !d.children; });

            var cell = svg.selectAll("g")
      .data(nodes)
    .enter().append("svg:g")
      .attr("class", "cell")
      .attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")"; })
      .attr("alt", function (d) { return d.parent.name })
    
      .on("click", function (d) { return zoom(node == d.parent ? root : d.parent); });

            cell.append("svg:rect")
      .attr("width", function (d) { return d.dx - 1; })
      .attr("height", function (d) { return d.dy - 1; })

      .style("fill", function (d) {

          if (d.parent.name == '高雄') {
              return '#e34724'
          }
          else if (d.parent.name == '台南') {
              return '#ffb200'
          }
         


          else
              return color(d.parent.name);
      });

            cell.append("svg:text")
      .attr("x", function (d) { return d.dx / 2; })
      .attr("y", function (d) { return d.dy / 2; })
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")
      .attr("alt", function (d) { return d.parent.name })
      .text(function (d) { return d.name; })
      .attr("fill", "#FFFFFF")
      .style("opacity", function (d) { d.w = this.getComputedTextLength(); return d.dx > d.w ? 1 : 0; });

            d3.select(window).on("click", function () { zoom(root); });

            d3.select("select").on("change", function () {
                treemap.value(this.value == "size" ? size : count).nodes(root);
                zoom(node);
            });
        });

        function size(d) {
            return d.size;
        }

        function count(d) {
            return 1;
        }

        function zoom(d) {
            var kx = w / d.dx, ky = h / d.dy;
            x.domain([d.x, d.x + d.dx]);
            y.domain([d.y, d.y + d.dy]);

            var t = svg.selectAll("g.cell").transition()
      .duration(d3.event.altKey ? 7500 : 750)
      .attr("transform", function (d) { return "translate(" + x(d.x) + "," + y(d.y) + ")"; });

            t.select("rect")
      .attr("width", function (d) { return kx * d.dx - 1; })
      .attr("height", function (d) { return ky * d.dy - 1; })

            t.select("text")
      .attr("x", function (d) { return kx * d.dx / 2; })
      .attr("y", function (d) { return ky * d.dy / 2; })
      .style("opacity", function (d) { return kx * d.dx > d.w ? 1 : 0; });

            node = d;
            d3.event.stopPropagation();
        }

    </script>
     

</asp:Content>


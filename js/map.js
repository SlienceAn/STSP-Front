
var points = [];
var p_points = [];
var p_infowindow;
var p_marker;
function map() {

    var options = {
        enableHighAccuracy: true,
        maximumAge: 3600000
    }



    var mapOptions = {
        center: new google.maps.LatLng('23.120609', '120.271422'),
        scaleControl: false, //比例尺
        mapTypeControl: false,
        streetViewControl: false,
        zoomControl: false,

        zoomControlOptions: {
            position: google.maps.ControlPosition.LEFT_BOTTOM
        },
        zoom: 13,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        fullscreenControl: false,
        styles: [
           {
               "featureType": "poi",
               "stylers": [
                 { "visibility": "off" }
               ]
           }
        ]
    };


    map = new google.maps.Map(document.getElementById("map"), mapOptions);


   

    var georssLayer = new google.maps.KmlLayer({
        url: 'http://einfo.stsp.gov.tw/FrontEnd/KML/STSPArea.kml',
        suppressInfoWindows: true,
        map: map,
        preserveViewport: true

    });
  //  georssLayer.setMap(map);
    
    google.maps.event.addListener(map, "click", function (event) {//
        var latitude = event.latLng.lat();
        var longitude = event.latLng.lng();
    });


    var result = document.getElementById('ContentPlaceHolder1_site').value;

    var res = result.split(',');

    points = [];

    if (res.length != 1) {

        try {
            var colorcount = 0;
            for (var i = 0 ; i < res.length - 10; i = i + 11) {
                var image = 'image/InquirePic05.png';



                var m = new google.maps.LatLng(res[i + 6], res[i + 5]);




                var point = new google.maps.Marker({
                    position: m,
                    //map: map,
                    icon: {
                        url: image, //指定標示圖案為image
                        labelOrigin: new google.maps.Point(15, 30),
                        anchor: new google.maps.Point(10, 30),
                        //  size: new google.maps.Size(20, 26)
                    },

                    label: res[i + 3],
                    draggable: false,
                    animation: google.maps.Animation.DROP,
                    target_link: res[i] + ',' + res[i + 7] + ',' + res[i + 8],
                    //  target_link: 'site_data.aspx?item_name=' + res[i + 5] + '&site_name=' + res[i + 1] + '&site_no=' + res[i + 4] + '',

                    infowindow_text: '園區：' + res[i + 1] + '<br/>類別：' + res[i + 2] + '<br> 測點名稱：' + res[i + 3] + '<br> 監測項目：' + res[i + 7].replace('_', ',') + '<br> 法規標準：' + res[i + 9] + res[i + 10] + '<br> <span style="color:red">紅色圈為ND值</span> <br/><canvas id="chart-legend-normal" style="position: relative;width:470px"></canvas>'

                });
                points.push(point);
                colorcount++;

                if (res[i + 4] == '高雄') {

                    map.setCenter(new google.maps.LatLng('22.822784', '120.283674'), 5);
                    map.setZoom(13);
                }
            }

            put_in_all_points();

            var bounds = new google.maps.LatLngBounds();
            for (var i = 0; i < points.length; i++) {
                bounds.extend(points[i].getPosition());
                //   alert(i);
            }

            //  map.fitBounds(bounds);




        } catch (err) {
            alert(err.message);

        }
    }
}

function put_in_all_points() {
    for (i = 0; i < points.length; i++) {
        var data = points[i];


        var t_marker = new google.maps.Marker({
            position: data.position,
            icon: data.icon,
            label: data.label,
            map: map,
            draggable: false,
            animation: google.maps.Animation.DROP,
            target_link: data.target_link,
            infowindow_text: data.infowindow_text
        });

        p_points.push(t_marker);
        // p_points.push(t_marker2);
        (function (t_marker, data) {
            google.maps.event.addListener(t_marker, "click", function (e) {
                //window.open(t_marker.target_link, t_marker.target_link, config = 'resizable=yes,height=500,width=1500');

                document.getElementById('ContentPlaceHolder1_HiddenField4').value = t_marker.target_link.split(',')[0];
                document.getElementById('ContentPlaceHolder1_HiddenField5').value = t_marker.target_link.split(',')[1] + t_marker.target_link.split(',')[2];


                setTimeout("document.getElementById('ContentPlaceHolder1_data').click()", 0);
                var infowindow = new google.maps.InfoWindow(
      {
          content: t_marker.infowindow_text,
          size: new google.maps.Size(10, 500)
      });
                try {
                    p_infowindow.close();
                } catch (ex) { }
                infowindow.open(map, t_marker);
                p_infowindow = infowindow;
            });
        })(t_marker, data);
    }
}

var color = Chart.helpers.color;
function createConfig() {
    return {
        type: 'line',
        data: {
            labels: document.getElementById('ContentPlaceHolder1_HiddenField1').value.split(','),
            datasets: [{
                label: '', //
                data: stringatoint(document.getElementById('ContentPlaceHolder1_HiddenField2').value.split(',')),
                //   backgroundColor: 'rgb(5, 55, 155,0.5)',
                // backgroundColor: 'rgb(0, 0, 0,0.0)',
                pointBorderColor: document.getElementById('ContentPlaceHolder1_HiddenField6').value.split(','),
                borderColor: 'rgb(0, 0, 0)',
                borderWidth: 1,
                pointStyle: 'rectRot',
                pointRadius: 5,
                //pointBorderColor: 'rgb(0, 0, 0)'
            }]
        },
        
        options: {
            responsive: true,
            
            legend: {
                display: false,
                labels: {

                    usePointStyle: false
                }
            },
            scales: {
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,
                        labelString: document.getElementById('ContentPlaceHolder1_HiddenField3').value
                    }
                }],
                yAxes: [{
                    display: true,
                    ticks: {
                        beginAtZero: true
                        
                    },
                    scaleLabel: {
                        display: true,
                        labelString: document.getElementById('ContentPlaceHolder1_HiddenField5').value
                    }
                }]
            },
            title: {
                display: true,
                text: '監測結果'
            }
        }
    };
}
function test() {
    var ctx = document.getElementById('chart-legend-normal').getContext('2d');
   
        ctx.canvas.height = 250;

    new Chart(ctx, createConfig());
}
function stringatoint(arry) {
    var newarry = new Array();
    for (var i = 0; i < arry.length; i++) {
        newarry[i] = parseFloat(arry[i]);
    }
    return newarry;
}
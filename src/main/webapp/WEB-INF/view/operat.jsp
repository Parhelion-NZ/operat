<!DOCTYPE html>
<html>
<head>
<title>Place Autocomplete Address Form</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-104411886-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-104411886-3');
</script>
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<style>
#locationField, #controls {
	position: relative;
	width: 480px;
}

#autocomplete {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 99%;
}

.label {
	text-align: right;
	font-weight: bold;
	width: 100px;
	color: #303030;
}

#address {
	border: 1px solid #000090;
	background-color: #f0f0ff;
	width: 480px;
	padding-right: 2px;
}

#address td {
	font-size: 10pt;
}

.field {
	width: 99%;
}

.slimField {
	width: 80px;
}

.wideField {
	width: 200px;
}

#locationField {
	height: 20px;
	margin-bottom: 2px;
}
</style>
</head>

<body>
	<div id="locationField">
		<input id="autocomplete" placeholder="Enter your address"
			onFocus="geolocate()" type="text"></input>
	</div>

	<div id="map" style="height: 80vh;"></div>


	<div id="addresses"></div>
	<script>

      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

      var placeSearch, autocomplete;
      var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
      };

      function initAutocomplete() {
    	  initMap();
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
            {
            	types: ['geocode'],
	         	componentRestrictions: {country:'nz'}   
            }
        );

        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', fillInAddress);
      }

      function fillInAddress() {
        // Get the place details from the autocomplete object.
        var place = autocomplete.getPlace();

        map.setCenter(place.geometry.location);
        map.setZoom(12);

        getMesh(place.geometry.location.lat(), place.geometry.location.lng());
/*         jQuery.ajax({
        	url: 'meshblock?lat='+place.geometry.location.lat()+'&lng='+place.geometry.location.lng(),
        	success : function(response) {
        		console.log(response);
        		drawMeshblock(response.wkt);
        		$('#addresses').text(response.addresses);
        	}
        }); */

      }
      
      function getMesh(lat, lng) {
          jQuery.ajax({
          	url: 'meshblock?lat='+lat+'&lng='+lng,
          	success : function(response) {
          		drawMeshblock(response.wkt);
          		$('#addresses').text(response.addresses);
          	}
          });
      }


      // Bias the autocomplete object to the user's geographical location,
      // as supplied by the browser's 'navigator.geolocation' object.
      function geolocate() {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var geolocation = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
          
            var circle = new google.maps.Circle({
              center: geolocation,
              radius: position.coords.accuracy
            });
            autocomplete.setBounds(circle.getBounds());
          });
        } else {
        	var geolocation = {
				lat: -41.2953037,
                lng: 174.7561219
            };
        	var circle = new google.maps.Circle({
                center: geolocation,
                radius: 1000
            });
            autocomplete.setBounds(circle.getBounds());
        }
        
      }
      
      var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -41.2953037, lng: 174.7561219},
          zoom: 8
        });
        
        
      	map.addListener('click', function(e) {
            getMesh(e.latLng.lat(),e.latLng.lng());
        });
			  

      }

        
      function placeMarkerAndPanTo(latLng, map) {
    	  var marker = new google.maps.Marker({
    	    position: latLng,
    	    map: map
    	  });
    	  map.panTo(latLng);
    	}
      
      var ptsArray=[];
      
      var existingPolys = [];
      
      function removeExistingPolys() {
    	  if (existingPolys.length > 0) {
        	  existingPolys[0].setMap(null);
        	  existingPolys = [];
    	  }
    	  ptsArray = [];
      }
      
      function drawMeshblock(wkt) {
    	  removeExistingPolys();
		//using regex, we will get the indivudal Rings
      	var regex = /\(([^()]+)\)/g;
      	var Rings = [];
      	var results;
      	while( results = regex.exec(wkt) ) {
			Rings.push( results[1] );
      	}

      	

      	var polyLen=Rings.length;

      	//now we need to draw the polygon for each of inner rings, but reversed
      	for(var i=0;i<polyLen;i++){
          AddPoints(Rings[i]);
      	}

		var poly = new google.maps.Polygon({
		    paths: ptsArray,
		    strokeColor: '#1E90FF',
		    strokeOpacity: 0.8,
		    strokeWeight: 2,
		    fillColor: '#1E90FF',
		    fillOpacity: 0.35
		});
		
		poly.setMap(map);
		map.fitBounds(getPolyBounds(poly));
		existingPolys.push(poly);
		
      }

      function getPolyBounds(poly) {
		var bounds = new google.maps.LatLngBounds();
  	    var paths = poly.getPaths();
	  	var path;        
  	    for (var i = 0; i < paths.getLength(); i++) {
  	        path = paths.getAt(i);
  	        for (var ii = 0; ii < path.getLength(); ii++) {
  	            bounds.extend(path.getAt(ii));
  	        }
  	    }
  	    return bounds;
      }

      //function to add points from individual rings
      function AddPoints(data){
    	 
          //first spilt the string into individual points
          var pointsData=data.split(", ");
          
          
          //iterate over each points data and create a latlong
          //& add it to the cords array
          var len=pointsData.length;
          for (var i=0;i<len;i++) {
               var xy=pointsData[i].split(" ");

              var pt=new google.maps.LatLng(xy[1],xy[0]);
              ptsArray.push(pt);
          }


      }
      
    </script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBB22BIjIweQfxWedQtJnYuIWJCN7-LpK0&libraries=places&callback=initAutocomplete"
		async defer></script>
	<script src="resources/js/jquery.min.js"></script>
</body>
</html>
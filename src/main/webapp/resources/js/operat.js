/**
 * 
 */

/*! loadJS: load a JS file asynchronously. Originally based on [c]2014 @scottjehl, Filament Group, Inc. (Based on http://goo.gl/REQGQ by Paul Irish). Licensed MIT. */
(function( w ){
	var loadJS = function( src, cb ){
		"use strict";
		var ref = w.document.getElementsByTagName( "script" )[ 0 ];
		var script = w.document.createElement( "script" );
		script.src = src;
		script.async = true;
		ref.parentNode.insertBefore( script, ref );
		if (cb && typeof(cb) === "function") {
			script.onload = cb;
		}
		return script;
	};
	// commonjs
	if( typeof module !== "undefined" ){
		module.exports = loadJS;
	}
	else {
		w.loadJS = loadJS;
	}
}( typeof global !== "undefined" ? global : this ));

var Operat = (function() {

	var reloadOperatData = function(el, dataID) {
		$(".container--dataentry").addClass("js-hide");
		$(".container--datacontent").removeClass("js-hide");
		$.ajax({
			url: contextRoot + "/meshblock/" + dataID,
			processData: false,
			method: "post",
			dataType: "json",
			success: function( data, textStatus, jqXHR ){
				showOperatData( el, data );
			},
			error: function( jqXHR, textStatus, errorThrown ){
				showOperatData( el, 'Unfortunately your request failed; we could not retrieve the data.' );
			}
		});
	}
	
	var showOperatData = function( el, data ){
		
		$(".container--homecontent").addClass( "js-hide" );

		if ($(".container--datacontent").is(":visible")){
			$(".container--datacontent").html( formatOperatData( data ) );
		} else {
			$(".container--datacontent").html( formatOperatData( data ) );
			$(".container--datacontent").removeClass( "js-hide" ).fadeIn(200, function(){
				// Done
			});
		}
	}

	var formatOperatData = function( data, options ){

		var str = '<div id="actualResults">';
			
		str += '<h1>Showing results for <br />' + data.meshblockId/* + ', ' + data.added*/ + '</h1>';

		str += '<table class="table--results">';

		
		str += '<tr><th class="tal">Natural Elements</th><td class="tar">' + data.naturalElementsScore.toFixed(1) + '</td></tr>';
		str += '<tr><th class="tal">Incivilities and Nuisance</th><td class="tar">' + data.incivilitiesScore.toFixed(1) + '</td></tr>';
		str += '<tr><th class="tal">Territorial Functioning</th><td class="tar">' + data.territorialScore.toFixed(1) + '</td></tr>';
		str += '<tr><th class="tal">Navigation and Mobility</th><td class="tar">' + data.navigationScore.toFixed(1) + '</td></tr>';
		str += '<tr><th class="divider" colspan="2">&nbsp;</td></tr>';
		str += '<tr><th class="tal">Overall Domain Score</th><td class="tar">' + data.operatScore.toFixed(1) + '</td></tr>';
		
		str += '</table><div>';

		return str;
	}
	
	var initMap = function() {
		if (!document.getElementById("map")){
			console.log("initMap should not be called without a map!");
			return;
		}

		resizeMap(960);
		var self = Operat;
		
		loadJS( "https://maps.googleapis.com/maps/api/js?key=AIzaSyBB22BIjIweQfxWedQtJnYuIWJCN7-LpK0&libraries=visualization,places", function(){

			var heatmapData = [];

			var autocomplete = new google.maps.places.Autocomplete((document.getElementById('location')),
					{
				types: ['geocode'],
				componentRestrictions: {country:'nz'}   
					}
			);


			var customLocation = 'wellington, new zealand';
			// Set default location, just in case
			var latLng = new google.maps.LatLng( -41.286460, 174.776236 );

			var geocoder = new google.maps.Geocoder();
			geocoder.geocode({ 'address': customLocation }, function(results, status) {

				if (status == google.maps.GeocoderStatus.OK){

					latLng = new google.maps.LatLng(-41.286460, 174.776236);

					var heatmap = null;

					var styles = [
						{
							"featureType": "administrative",
							"stylers": [
								{
									"visibility": "off"
								}
								]
						},
						{
							"featureType": "administrative.country",
							"elementType": "geometry",
							"stylers": [
								{
									"color": "#EEEEEE"
								},
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "administrative.country",
							"elementType": "labels.text",
							"stylers": [
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "administrative.land_parcel",
							"elementType": "geometry.fill",
							"stylers": [
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "administrative.land_parcel",
							"elementType": "geometry.stroke",
							"stylers": [
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "administrative.land_parcel",
							"elementType": "labels.text",
							"stylers": [
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "administrative.locality",
							"elementType": "labels",
							"stylers": [
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "landscape",
							"stylers": [
								{
									"color": "#E9EBE7"
								}
								]
						},
						{
							"featureType": "landscape.man_made",
							"stylers": [
								{
									"visibility": "off"
								}
								]
						},
						{
							"featureType": "landscape.man_made",
							"elementType": "geometry.fill",
							"stylers": [
								{
									"color": "#d169cf"
								}
								]
						},
						{
							"featureType": "landscape.man_made",
							"elementType": "geometry.stroke",
							"stylers": [
								{
									"color": "#ffeb3b"
								}
								]
						},
						{
							"featureType": "landscape.natural.terrain",
							"stylers": [
								{
									"visibility": "off"
								}
								]
						},
						{
							"featureType": "poi",
							"stylers": [
								{
									"visibility": "off"
								}
								]
						},
						{
							"featureType": "poi.park",
							"elementType": "geometry.fill",
							"stylers": [
								{
									"color": "#dcdcdc"
								},
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "road.highway",
							"elementType": "geometry.fill",
							"stylers": [
								{
									"color": "#e1e1e1"
								},
								{
									"visibility": "on"
								}
								]
						},
						{
							"featureType": "transit",
							"stylers": [
								{
									"visibility": "off"
								}
								]
						},
						{
							"featureType": "water",
							"stylers": [
								{
									"color": "#C5C5C5"
								}
								]
						}
						];			

					self.map = new google.maps.Map(document.getElementById('map'), {
						zoom: 14,
						minZoom: 9,
						center: latLng,
						mapTypeId: google.maps.MapTypeId.ROADMAP,
						disableDefaultUI: true,
						zoomControl: true,
						styles: styles,
						gestureHandling: 'greedy'
					});		
					var map = self.map;

					self.map.addListener('click', function(e) {
						Operat.drawMesh(e.latLng, self.map);
					});


					google.maps.event.addListener(self.map, "bounds_changed", function() {

						var sw = map.getBounds().getSouthWest();
						var url = contextRoot + '/results/'+sw.lng()+','+sw.lat()+'/';
						var ne = map.getBounds().getNorthEast();
						url += ne.lng() + ','+ne.lat() + '/';
					});

					autocomplete.addListener('place_changed', function() {
						var place = autocomplete.getPlace();
						self.drawMesh(place.geometry.location, map);
					});

					/* CSJM Markers start */

					jQuery.ajax({
						url: contextRoot + '/results',
						success : function(response) {

							MapUtils.drawHeatMap(response, map);

						}
					});

					/* CSJM Markers end */

				} else {
					console.log(' > Error: we could not load the geoLocation ' + status );
				}
			});

		});		//end loadjs

	};			//end initMap

	
	
	
	var drawMesh = function(location, map) {
		var self = this;
		map.setCenter(location);

		jQuery.ajax({
			url: contextRoot + '/meshblock?lat='+location.lat()+'&lng='+location.lng(),
			success : function(response) {
				MapUtils.drawMeshblock(response.wkt, map);

				var hasAddresses = response.addresses.length;
				var content = "<h2>Selected meshblock "+response.id+"</h2>";
				if (hasAddresses) {
					content += "<p>This meshblock has "+response.addresses.length+" properties. <a href=\""+contextRoot+"/assessPdf/"+response.id+".pdf\">Display a pre-populated form</a> which can be saved or printed.</p>";

					content += '<p>Instructions on how to carry out an OPERAT assessment are available <a href="https://www.operat.co.uk/getfile/documents/manuals/OPERAT-Manual-New-Zealand.pdf">here</a>.</p>';
					content += '<p>When you have completed your assessments you can enter your results <a href="'+contextRoot+'/assessForm/">here</a>.  The computer will add up the scores and send them to us. Or post your completed forms to: ';
					content += '<address style="padding-left: 5px;">Christine Stephens<br/>Freepost 86<br/>School of Psychology<br/>Massey University, PB 11 222<br/>Palmerston North, 4442</address>';
				} else {
					content += "<p>We do not have a record of any properties in this location.  This could be because the local authority has not supplied this data, or there are no residential properties. Please contact us to request that this is populated.</p>";
				}

				$(".container--homecontent").addClass( "js-hide" );

				if ($(".container--datacontent").is(":visible")){
					$('.container--datacontent').html(content);
				} else {
					$('.container--datacontent').html(content);
					$(".container--datacontent").removeClass( "js-hide" ).fadeIn(200, function(){
						// Done
					});
				}
			}
		});

	};
	
	
	return {
		initMap: initMap,
		drawMesh: drawMesh,
		reloadOperatData : reloadOperatData
	};

})(); 			//end operat

var MapUtils = {
	
	ptsArray : [],
	
	existingPolys : [],
	
	heatmaps : {}, 
	
	removeExistingPolys : function() {
		if (this.existingPolys.length > 0) {
			this.existingPolys[0].setMap(null);
			this.existingPolys = [];
		}
		this.ptsArray = [];
	},

	
	drawMeshblock : function(wkt, map) {
		this.removeExistingPolys();
		//using regex, we will get the indivudal Rings
		var regex = /\(([^()]+)\)/g;
		var rings = [];
		var results;
		while( results = regex.exec(wkt) ) {
			rings.push( results[1] );
		}

		var polyLen=rings.length;

		//now we need to draw the polygon for each of inner rings, but reversed
		for(var i=0;i<polyLen;i++){
			MapUtils.addPoints(rings[i]);
		}

		var poly = new google.maps.Polygon({
		    paths: this.ptsArray,
		    strokeColor: '#1E90FF',
		    strokeOpacity: 0.8,
		    strokeWeight: 2,
		    fillColor: '#1E90FF',
		    fillOpacity: 0.35
		});

		poly.setMap(map);
		map.fitBounds(MapUtils.getPolyBounds(poly));
		this.existingPolys.push(poly);
		
	},
	
	//function to add points from individual rings
	addPoints : function(data){
		 
	    //first spilt the string into individual points
	    var pointsData=data.split(",");
	    
	    
	    //iterate over each points data and create a latlong
	    //& add it to the cords array
	    var len=pointsData.length;
	    for (var i=0;i<len;i++) {
	    	var xy=pointsData[i].trim().split(" ");

	        var pt=new google.maps.LatLng(xy[1],xy[0]);
	        this.ptsArray.push(pt);
	    }
	},
	
	getPolyBounds : function(poly) {
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
	},
	
	drawHeatMap : function(results, map) {
		var self = this;
		
		var locations = [];
		
		this.heatmaps.shapes = [];
		
		var regex = /\(([^()]+)\)/g;
			
		results.forEach(function(val) {
			
			var green = "rgb(0,200,0)";
			var orange = "rgb(200,160,0)";
			var red = "rgb(255,0,0)";
			var colourOverall;
			if (val.operatScore < 33) {
				colourOverall = green;
			} else if (val.operatScore < 66) {
				colourOverall = orange;
			} else {
				colourOverall = red;
			}
			
			if (val.naturalElementsScore < 7) {
				colourNaturalElements = green;
			} else if (val.naturalElementsScore < 14) {
				colourNaturalElements = orange;
			} else {
				colourNaturalElements = red;
			}
			
			if (val.incivilitiesScore < 7) {
				colourIncivilities = green;
			} else if (val.incivilitiesScore < 14) {
				colourIncivilities = orange;
			} else {
				colourIncivilities = red;
			}

			if (val.territorialScore < 7) {
				colourTerritorial = green;
			} else if (val.territorialScore < 14) {
				colourTerritorial = orange;
			} else {
				colourTerritorial = red;
			}
			
			if (val.navigationScore < 13) {
				colourNavigation = green;
			} else if (val.navigationScore < 27) {
				colourNavigation = orange;
			} else {
				colourNavigation = red;
			}
			
			var Rings = [];
			MapUtils.ptsArray = [];
			var parsed;
			while( parsed = regex.exec(val.geom) ) {
				Rings.push( parsed[1] );
			}
			var polyLen=Rings.length;
			
			//now we need to draw the polygon for each of inner rings, but reversed
			for(var i=0;i<polyLen;i++){
		    	self.addPoints(Rings[i]);
			}

			var poly = new google.maps.Polygon({
			    paths: MapUtils.ptsArray,
			    strokeColor: colourOverall,
			    strokeOpacity: 0.8,
			    strokeWeight: 2,
			    fillColor: colourOverall,
			    fillOpacity: 0.35
			});

			self.heatmaps.shapes.push({
				poly: poly, 
				overall: colourOverall, 
				naturalElements: colourNaturalElements, 
				incivilities: colourIncivilities,
				territorial: colourTerritorial,
				navigation: colourNavigation
			});
			
			poly.setMap(map);
			locations.push({ position: { lat: val.lat, lng: val.lng }, title: val.meshblockId, meshblockId: val.meshblockId, dataid: val.resultId });
		});
		var markers = locations.map(function(location, i) {
			return new google.maps.Marker({
		        position: location.position,
		        // label: location.title,
		        title: ""+location.title,
		        dataID: location.meshblockId,
		        icon: contextRoot + "/resources/img/map-pin.png"
			});
		});

		for (m = 0; m < markers.length; m++){

			markers[m].setMap(map);

			markers[m].addListener( "click", function() {
				Operat.reloadOperatData( "#container--datacontent", parseInt( this.dataID ) );
				map.panTo( this.getPosition() )
			});

		}
			
		$("#js-mapfilter").on("submit", function(e){

			e.preventDefault();

			var customLocation = $("#location").val();

			if (geocoder && map && (customLocation != "")){
				geocoder.geocode({ 'address': customLocation }, function(results, status) {

					if (status == google.maps.GeocoderStatus.OK){
						map.panTo(
							new google.maps.LatLng( results[0].geometry.location.lat(), results[0].geometry.location.lng() )
						);
	
						$("#js-newpostcode").val( customLocation );
					}
	
				});
			}
	
		});
		
	}
}


function resizeMap( minWidth ){
	if (parseInt($(window).width()) > minWidth){
		if ($(".lo-home").length > 0){
			var header = $(".region--header").outerHeight();
			var footer = $(".region--footer").outerHeight();
			var mapHeight = parseFloat($(window).height()) - parseFloat(header) - parseFloat(footer);
			$(".region--content, .region--map, .map").css( "height", mapHeight + "px" );
		} else {
			var header = $(".region--header").outerHeight();
			var footer = $(".region--footer").outerHeight();
			var mapHeight = parseFloat($(window).height()) - parseFloat(header) - parseFloat(footer);
	
			if ( parseFloat($(".region--content").height()) < parseFloat(mapHeight)){
				$(".region--content").css( "min-height", mapHeight + "px" );
			}
		}
	}
}

$(function() {
	$(".js-toggle").each(function(){
		$(this).on("click", function( e ){
			e.preventDefault();
			$( $(this).attr("data-target") ).toggleClass( $(this).attr("data-toggleclass") );
		});
	});
});
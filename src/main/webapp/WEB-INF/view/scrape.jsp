
<!DOCTYPE html>

<html lang="en">

<head>
  


<meta charset="utf-8" />



<title>Welcome</title>



<!-- Meta information-->
<meta name="keywords" content="operat, environment, Older Peoples External Residential Assessment Tool, Older People, External Residential Assessment, Residential Assessment Tool, assessment centre for ageing, ageing, research, OPAN, wales, cymru, older people, health, social care, CADR" />
<meta name="description" content="Welcome. " />
<meta name="author" content="Waters Creative Ltd (www.waters-creative.co.uk)" />
<meta name="robots" content="INDEX, FOLLOW" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />



<!-- Facebook OpenGraph elements -->  
<meta property="og:title" content="Welcome" />
<meta property="og:description" content="Welcome. " />
<meta property="og:image" content="https://www.operat.co.uk/getfile/design/social.png" />
<meta property="og:url" content="https://www.operat.co.uk/" />



<!-- stylesheets -->
<link rel="stylesheet" href="resources/styles/operatuk.css" type="text/css" media="all" />


<!-- other icons -->
<link rel="icon" type="image/png" href="https://www.operat.co.uk/getfile/design/favicon.png" />
<link rel="image_src" href="https://www.operat.co.uk/getfile/design/social.png" />



<!-- URL handling -->
<link rel="canonical" href="https://www.operat.co.uk" />



<!-- Include scripting -->
<script type="text/javascript">

// ----------------------------------------------------------------------
// Set variables
// ----------------------------------------------------------------------

// Test as to whether the DOM ready script has been run yet or not
var domReadyRun = false;

// ----------------------------------------------------------------------
// Worker function definitions
// ----------------------------------------------------------------------

// Ensure the console calls do something:
if(typeof window.console == 'undefined'){ window.console = { log: function (msg) {  } }; }

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

// Function for testing if we are using IE, and the version being used:
function isIE() { var myNav = navigator.userAgent.toLowerCase(); return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false; }

// Wrapper function for console calls:
function consoleWrapper(msg){ console.log(msg); }

</script>

<script type="text/javascript">

// ----------------------------------------------------------------------
// Customisable functions and variables
// ----------------------------------------------------------------------

var debug = false;
var isCycleLoading = false;
var isDocumentReady = false;

function consoleDebug(message){
	if(debug == true){
		consoleWrapper(message);
	}
}

document.addEventListener("DOMContentLoaded", function(event) { isDocumentReady = true; console.log("DOM has loaded"); });

window.onload = function(){ console.log("Document has loaded.."); };


// List of files which should always be loaded by this page.
var jsFiles = [  
	"https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
]; 



// Conditional loading of additional scripts, depending on browser 
// version. Typically, load polyfills for pre-IE9 browsers
if (isIE() && isIE() < 9){
	jsFiles.push("/js/libs/html5shiv.min.js");
	jsFiles.push("/js/libs/selectivizr-min.js");
	jsFiles.push("/js/libs/respond.min.js");
	jsFiles.push("/js/libs/picturefill.min.js");
}



// Function used to test if critical scripts have loaded. This is 
// required in the case where one or more scripts depend on each 
// other
function isReady(){
	
	// Check whether critical functions have been loaded and if so, 
	// trigger post-loading scripts. For example, check if jQuery, 
	// or other dependency has loaded yet.
	if (window.jQuery && !domReadyRun){ 			

		// Message to console:
		consoleWrapper("Critical JS functionality has loaded.");

		// Set flag to ensure this proceedure is only run once:
		domReadyRun = true;

		if (isDocumentReady == false){
			document.addEventListener("DOMContentLoaded", function(event) { 
				consoleWrapper("isReadyJS called via document ready");
				isReadyJS( jQuery ); 
			});
		} else {
			consoleWrapper("isReadyJS called manually");
			isReadyJS( jQuery ); 
		}

	}

}



// Function used to perform the custom actions once the page has loaded
// e.g. trigger actions, slideshows etc etc.
// We pass in the document manipulation API as "$" for interoperability 
// reasons, for example shoestring has the same core DOM functionality 
// as jQuery and have the same
function isReadyJS( $ ){

	// Message to console
	consoleWrapper("Running custom actions...");

	// Image Dependant Plugins

	$( window ).on( "load", function() { 

		// Cycle2
if ($(".js-cycle-slideshow").length > 0){
	loadJS( "/js/libs/jquery.cycle2.js", function(){ 
		
		consoleWrapper("Loaded jquery.cycle2.js."); 

		if ($(".js-cycle-slideshow").children().length > 1){
			$(".js-cycle-slideshow").cycle();
		}
		
		// loadJS( "js/libs/jquery.cycle2.carousel.js", function(){ 
		// 	consoleWrapper("Loaded jquery.cycle2.carousel.js."); 
		// 	$(".js-cycle-slideshow").cycle();
		// })
	});
}


if($(".js-image").length > 0){
	loadJS( "/js/libs/js-image.js", function(){
		consoleWrapper("Loaded JS Image");
	});	
}		

		// Also resizes other areas, so call, even if we're 
		// not a map page.
		resizeMap( 960 );


		// If the map is present.. load it.
		if (document.getElementById("map")){

			

	var npctimer = false;
	$("#js-newpostcode").on("keyup", function(){
		clearTimeout(npctimer);
		npctimer = setTimeout( function(){ verifyStep1() }, 750 );
	});

	var valtimer = false;
	$(".js-input-val").on("keyup", function(){
		clearTimeout(valtimer);
		valtimer = setTimeout( function(){
			allOkay = true;
			$(".js-input-val").each(function(){
				var v = parseFloat($(".js-input-val").val());
				if (v == 0){
					allOkay = false;
				}
			});
			if (allOkay){
				$("#js-submitbutton").removeProp("disabled");
			} else {
				$("#js-submitbutton").prop("disabled", "disabled");
			}
		}, 1000 );
	});

	$("body").on("click", ".js-uploadbuttom", function( ev ){
		ev.preventDefault();
		$(".container--homecontent").removeClass("js-show").addClass("js-hide");
		$(".container--datacontent").removeClass("js-show").addClass("js-hide");
		$(".container--dataentry").removeClass("js-hide").addClass("js-show");
	
		if ($("#js-newpostcode").val() != ""){
			clearTimeout(npctimer);
			npctimer = setTimeout( function(){ verifyStep1() }, 250 );
		}
	

	});


	$("#js-newbutton").on("click", function(e){
		e.preventDefault();
		$(this).parents(".step").removeClass("js-show").addClass("js-hide");
		$(".step--2").removeClass("js-hide").addClass("js-show");
	});


	$("#form--newdata").on("submit", function(ev){
		ev.preventDefault();
		var formData = $(this).serialize();
		$.ajax({
			url: "/?ajax=submitdata",
			data: formData,
			method: "POST",
			dataType: "text"
		}).done(function( result ) {
			if (result[0] == "1"){
				window.location = 'thank-you?postcode=' + $("form--newdata").find("#js-newpostcode").val()
			} else {
				var msg = result.substring(2, result.length );
				console.log("[OPERAT] Saved data: " + msg );
				alert("Failed: " + msg);
			}
		}).fail(function( jqXHR, textStatus  ) {
			alert( "success" );
		})
	});

	$('#js-mapfilter').on("submit", function(ev) {
		ev.preventDefault();
	});

	function formatOperatData( data, options ){

		var str = '';

		str += '<h1>Showing results for <br />' + data.location + ', ' + data.added + '</h1>';

		str += '<table class="table--results">';

		if (data.components){
			for(c = 0; c < data.components.length; c++){
				if (data.components[c].field == "divider"){
					str += '<tr><th class="divider" colspan="2">&nbsp;</td></tr>';
				} else {
					str += '<tr><th class="tal">' + data.components[c].field + '</th><td class="tar">' + data.components[c].value + '</td></tr>';
				}
			}
		}
		
		str += '</table>';

		// str += '<p><a href="#" onclick="alert(\'Coming soon\'); return false;" class="btn  btn--full  t--teal"><i class=" [ i--vac--right  pad ]  i--arrow--right"></i> Update the score</a></p>';

		str += '<p><a href="#" class="btn  btn--full  btn--primary  js-uploadbuttom"><i class="  [ i--vac--right  pad ] i--upload"></i> Upload Results Here</a></p>';

		return str;
	}





	function showOperatData( el, data ){
		
		// $(".container--dataentry").addClass( "js-hide" );
		// $(".container--datacontent").addClass( "js-hide" );

		// if ($(el).is(":visible")){
		// 	$(el).html( formatOperatData( data ) );
		// } else {
		// 	$(el).html( formatOperatData( data ) );
		// 	$(el).removeClass( "js-hide" ).fadeIn(200, function(){
		// 		// Done
		// 	});
		// }

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





	function reloadOperatData( el, dataID ){
		$(".container--dataentry").addClass("js-hide");
		$(".container--datacontent").removeClass("js-hide");
		$.ajax({
			url: "?ajax=operatdata&id=" + dataID,
			processData: false,
			method: "post",
			dataType: "json",
			success: function( data, textStatus, jqXHR ){
				showOperatData( el, data );
			},
			error: function( jqXHR, textStatus, errorThrown ){
				showOperatData( el, 'Unfortunately your request failed; we could not retrieve the data.' );
			}
		})
	}





	loadJS( "https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js", function(){ 

		console.log('Loaded markerclusterer.js');

		loadJS( "https://maps.googleapis.com/maps/api/js?key=AIzaSyBB22BIjIweQfxWedQtJnYuIWJCN7-LpK0&libraries=visualization,places", function(){

				console.log('Loaded Google Maps API');

				var heatmapData = [];
				
				var autocomplete = new google.maps.places.Autocomplete((document.getElementById('location')),
		            {
		            	types: ['geocode'],
			         	componentRestrictions: {country:'nz'}   
		            }
		        );


				var customLocation = 'wellington, new zealand';
				// Set default location, just in case
				// var latLng = new google.maps.LatLng( 52.435482, -4.055578 );

				var geocoder = new google.maps.Geocoder();
				geocoder.geocode({ 'address': customLocation }, function(results, status) {

					if (status == google.maps.GeocoderStatus.OK){

						latLng = new google.maps.LatLng( results[0].geometry.location.lat(), results[0].geometry.location.lng() );

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

						map = new google.maps.Map(document.getElementById('map'), {
							zoom: 14,
							minZoom: 5,
							center: latLng,
							mapTypeId: google.maps.MapTypeId.ROADMAP,
							disableDefaultUI: true,
							zoomControl: true,
							styles: styles
						});		
						

				      	map.addListener('click', function(e) {
				            drawMesh(e.latLng, map);
				        });
				      	
						autocomplete.addListener('place_changed', function() {
							var place = autocomplete.getPlace();
							drawMesh(place.geometry.location, map);
						});

					} else {
						console.log(' > Error: we could not load the geoLocation ' + status );
					}
				});

			});

		});

		}

	});


	if ($('.js-twitter-feed').length > 0) { 
	$.ajax({
		url: '/scripts/twitter-code.php',
		success: function(data) {
			$('.js-twitter-feed').html(data);			
		},
		error: function(xhr, textStatus, errorThrown){
		   console.log(errorThrown);
	    }
	});
}

if ($('.js-facebook-feed').length > 0) { 
	$.ajax({
		url: '/scripts/facebook-code.php',
		success: function(data) {
			$('.js-facebook-feed').html(data);			
		},
		error: function(xhr, textStatus, errorThrown){
		   console.log(errorThrown);
	    }
	});
}

// Fancybox
if ($('.js-fancybox').length > 0){
	loadJS( "/js/libs/fancybox2/jquery.fancybox.js", function(){
		$('.js-fancybox').fancybox();
	});
}


// DoubleTapToGo
if ($(".nav").length > 0){
	loadJS( "/js/libs/doubletaptogo.js", function(){ 
		consoleWrapper("Loaded js/libs/doubletagtogo.js"); 
		$('.nav li:has(ul)').doubleTapToGo();
	});
}


// Google Recaptcha
if ($(".g-recaptcha").length > 0){
	loadJS( "https://www.google.com/recaptcha/api.js", function(){
		consoleWrapper("Loaded Google Recapatcha");
	});
}

if($(".grid").length > 0){
		loadJS( "/js/header-scripts/pods.js", function(){ 
			consoleWrapper("Loaded Pods JS");
			var podTimer = 0;
				handlePods(podTimer, ".grid", ".pod");
		});
}

if($(".concertina").length > 0){
	loadJS( "/js/header-scripts/concertina.js", function(){
		handleConcertina('.concertina');
		consoleWrapper("Loaded Concertina JS");
	});
}


if($(".js-date").length > 0){
	loadJS( "/js/libs/jquery-ui/jquery-ui.min.js", function(){
		consoleWrapper("Loaded JQuery UI");
		$(".js-date").datepicker({ minDate: 0, dateFormat : "dd/mm/yy" });
	});	
}

if($(".js-checkbox").length > 0){
	loadJS( "/js/header-scripts/js-checkbox.js", function(){
		consoleWrapper("Loaded JS checkbox");
		setupJScheckbox(".js-checkbox");
	});	
}

if($(".js-label").length > 0){
	loadJS( "/js/header-scripts/placeholder.js", function(){
		consoleWrapper("Loaded JS Placeholder");
		HandleInputPlaceholder(".js-label");
	});	
}

if($(".js-fancylabel").length > 0){
	loadJS( "/js/header-scripts/fancyLabel.js", function(){
		consoleWrapper("Loaded JS Fancy Label");
		$(".js-fancylabel").fancyLabel();
	});	
}

if($(".js-select").length > 0){
	loadJS( "/js/header-scripts/js-select.js", function(){
		consoleWrapper("Loaded JS Select");
	});	
}

	
var listTmp = Array();
var listTmp2 = Array();
var running = false;


function adjustListRowSpacing(els, innerels){

	listTmp = Array();
	$(els).each(function(){

		if(innerels != undefined){
			listTmp.push($(this).find(innerels).first());
		} else {
			listTmp.push($(this));
		}
		
		if ($(this).css("margin-right") == "0px"){
			// Loop over the objects in listTmp and get tallest height.
			var tallest = 0;
			var h = 0;
			for(var c = 0; c < listTmp.length; c++){
				/* Need to reset their height each time to their calculated value */
				$(listTmp[c]).css("height", "");
				h = parseInt($(listTmp[c]).height()) + parseInt($(listTmp[c]).css("padding-top")) + parseInt($(listTmp[c]).css("padding-bottom"));
				if (parseInt(h) > tallest){
					tallest = parseInt(h);
				}
			}

			// Apply tallest height to all in listTmp
			for(var c = 0; c < listTmp.length; c++){
				$(listTmp[c]).css("height", tallest + "px");
			}

			// reset the array
			listTmp = Array();
		}

		if(listTmp.length > 0){
			for(var c = 0; c < listTmp.length; c++){
				$(listTmp[c]).css("height", "");
			}			
		}
	});


	// If there are still items in the list, we need to loop over them performing a resize
	if(listTmp.length > 0){

		var tallest = 0;
		var h = 0;
		for(var c = 0; c < listTmp.length; c++){
			/* Need to reset their height each time to their calculated value */
			$(listTmp[c]).css("height", "");
			h = parseInt($(listTmp[c]).height()) + parseInt($(listTmp[c]).css("padding-top")) + parseInt($(listTmp[c]).css("padding-bottom"));
			if (parseInt(h) > tallest){
				tallest = parseInt(h);
			}
		}

		// Apply tallest height to all in listTmp
		for(var c = 0; c < listTmp.length; c++){
			$(listTmp[c]).css("height", tallest + "px");
		}

		// reset the array
		listTmp = Array();
	}
}


function handleListRowSpacing(timer, element, delay, innerelement){
	if( $(element).length ) {

		adjustListRowSpacing(element, innerelement);

		$(window).resize( function() {
		    clearTimeout( timer );
		    timer = setTimeout( function() {
		        adjustListRowSpacing(element, innerelement);

		    }, delay );
		});
	}
}


	/*handleSameHeight(".col--custom-left, .col--custom-right", 720);
var heightTimer = 0;*/

var heightTimer = 0;
function handleSameHeight(element, minWidth){

	if (typeof minWidth == "undefined"){
		minWidth = 0;
	}

	if($(element).length){
		sameHeight(element, minWidth);
		$(window).resize( function() {
		    clearTimeout( heightTimer );
		    heightTimer = setTimeout( function() {
		        sameHeight(element, minWidth);
		    }, 200 );
		});
	}
}

function sameHeight(els, minWidth){
	listTmp = Array();
	var tallest = 0;
	var w = parseInt($(document).width());
	if (w > minWidth){
		$(els).each(function(){
			$(this).css("min-height", "");
			//if ($(this).css("float") == "left"){
				listTmp.push($(this));
				var h = 0;
				h = $(this).outerHeight();
				if(h > tallest){
					tallest = Math.floor(h);
				}
			//}
		});
		for(var c = 0; c < listTmp.length; c++){
			$(listTmp[c]).css("min-height", tallest + "px");
		}
	} else {
		$(els).each(function(){
			$(this).css("min-height", "");
		});
	}
}


//	handleSameHeight( ".header--col", 960 );


	// Set up event handling
	setupEvents();



	// Custom code here
	consoleWrapper("Finished custom actions...");
}





function submitForm(){
	success = true;
	
	var requiredElements = $('input[data-required], textarea[data-required]');

	var requiredTxtFields = Array();

	requiredElements.each(function(){
		requiredTxtFields.push($(this).attr("id"));
	});

	for (f=0;f < requiredTxtFields.length; f++){

		var requiredField = "#" + requiredTxtFields[f];

		if($(requiredField).attr('data-required') == ""){
			if ($(requiredField).val() == ""){
				$(requiredField).addClass("fm-field-error");
				success = false;
			} else {
				$(requiredField).removeClass("fm-field-error");	
			}				
		} else {

			var dataValidation = $(requiredField).attr('data-required');
			var regex = "";

			switch(dataValidation){
				case "email":
					regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
					break;

				case "phone":
					regex = /^[- +()]*[0-9][- +()0-9]*$/;
					break;

				case "postcode":
					regex = /^[A-Z]{1,2}[0-9]{1,2} ?[0-9][A-Z]{2}$/i;
					break;
			}

			regex = new RegExp(regex);

			if(!regex.test($(requiredField).val()) || $(requiredField).val() == "" ){
            	$(requiredField).addClass("fm-field-error");
				success = false;
            } else {
            	$(requiredField).removeClass("fm-field-error");	
            }
		}

	}

	var response = grecaptcha.getResponse();

	if(response.length == 0){
		if(success == true){
			alert("Please ensure the Google Capatcha is complete");
		} else {
			alert("Please ensure the Google Capatcha, and application is complete");
		}
		
		success = false;
	} 

	if (success == false && response.length != 0){
		alert('Please ensure all of the required fields are completed. Thank you.');
	}

	return success;
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


function setupEvents(){

	consoleWrapper("Attaching events...");

	// Toggle the navigation class
	// $("#js-nav__toggle").on("click", function(){
	// 	$('.nav').toggleClass("menu__show");
	// });


	$(".js-toggle").each(function(){
		$(this).on("click", function( e ){
			e.preventDefault();
			$( $(this).attr("data-target") ).toggleClass( $(this).attr("data-toggleclass") );
		});
	});


	$(".domain-option").on("click", function(e){
		e.preventDefault;
		var postcode = $("#location").val();
		var link = $(this).attr("href")
		if (postcode != ""){
			window.location = link + "&location=" + postcode;
		} else {
			window.location = link;
		}
		return false;
	});
	


	// Handle the resizing of the object
	//var widget_timer = 0;
	//handleListRowSpacing(widget_timer, ".widget", 20);


	$(window).on("resize", function(){
		
		console.log("resizing..");

		resizeMap( 960 );

	});


	consoleWrapper("Finished attaching events...");
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

function drawMeshblock(wkt, map) {
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

function drawMesh(location, map) {

	map.setCenter(location);
    //map.setZoom(12);

    jQuery.ajax({
    	url: '${pageContext.request.contextPath}/meshblock?lat='+location.lat()+'&lng='+location.lng(),
    	success : function(response) {
    		console.log(response);
    		drawMeshblock(response.wkt, map);
    		console.log(response.addresses);
//    		$('#addresses').text(response.addresses);

			var hasAddresses = response.addresses.length;
			var content = "<h2>Selected meshblock "+response.id+"</h2>";
			if (hasAddresses) {
				content += "<p>This meshblock has "+response.addresses.length+" properties. <a href=\"assessPdf/"+response.id+"\">Display a pre-populated form</a> which can be saved or printed.</p>";
			} else {
				content += "<p>We do not have a record of any properties in this location.  This could be because the local authority has not supplied this data, or there are no residential properties. Please contact us to request that this is populated.</p>";
			}
			$('#resultsPlaceholder').html(content);
    	}
    });

  }


</script>

<script type="text/javascript">

// ----------------------------------------------------------------------
// Loop over files, calling the loadJS function. Specify callback function so 
// that we can test for critical path JavaScript and trigger post-load scripting
// ----------------------------------------------------------------------

for(c = 0; c < jsFiles.length; c++){ 
	consoleWrapper("Loaded file..." + jsFiles[c]); 
	loadJS( jsFiles[c], function(){ 
		consoleWrapper("Loaded file."); isReady(); 
	}); 
}

// ----------------------------------------------------------------------
	
</script>




<script src="https://www.google.com/recaptcha/api.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<!--  script async src="https://www.googletagmanager.com/gtag/js?id=UA-108192006-1"></script -->
<!--  script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-108192006-1');
</script -->





<!-- Include header-specific material -->



<!-- 
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBYwkH9mSeKDxPVUsBkEq0AliZASxydPVo&libraries=visualization" async defer>
</script> 
-->


</head>

<body class="lo-singlepage lo-home" itemscope itemtype="http://schema.org/WebPage">



	<a href="#main-content" class="hide-visually">jump to content</a>



	<header class="region  region--header">
		
<div class="container  container--header  operat-row">

	<div class="operat-row">

		<div class="header--col  header--logo  tal">


			<a class="logo  logo--operat" href="/operat/">
				<img class="logo__image" src="https://www.operat.co.uk/getfile/design/operat-logo.png" 
					 alt="OPERAT" 
					 title="OPERAT (Home)" />
			</a>

		</div>

		<div class="header--col  header--partners  tar">
			<a class="logo  logo--swansea-uni" href="https://massey.ac.nz/" target="_blank">
				<img class="logo__image" src="resources/img/massey-white-72.png" 
					 alt="Massey University" 
					 title="Massey University (opens in new window)" />
			</a>
			<a class="logo  logo--swansea-uni" href="https://www.operat.co.uk/" target="_blank">
				<img class="logo__image" src="https://www.operat.co.uk/getfile/design/swansea-uni-logo.png" 
					 alt="Swansea University / Prifysgol Abertawe" 
					 title="Swansea University / Prifysgol Abertawe (opens in new window)" />
			</a>

		</div>

	</div>
	
</div>


<div class="container  container--nav">

	<nav class="nav region region--nav">

		<a href="#" class="nav__toggle  js-toggle" data-target="nav"  data-toggleclass="js-show">
			<i class="i--right i--nav i--more"></i> <span class="nav__toggle__label">Menu</span>
		</a>
		<ul class="lvl-0"><li class="lvl-0-item selected" >
                    <a href="/operat/"  class="lvl-0-link"  >Map</a></li><li class="lvl-0-item has-child" >
                    <a href="https://www.operat.co.uk/background"  class="lvl-0-link" aria-haspopup="true"  >Background</a><ul class="lvl-1"><li class="lvl-1-item" >
                    <a href="${pageContext.request.contextPath}/faqs"  class="lvl-1-link"  >Frequently Asked Questions</a></li></ul></li><li class="lvl-0-item has-child" >
                    <a href="#"  class="lvl-0-link" aria-haspopup="true"  >Using the Tool</a><ul class="lvl-1"><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-properties"  class="lvl-1-link"  >OPERAT Environmetrics</a></li><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-scoring-tool-and-manual"  class="lvl-1-link"  >OPERAT Manual, Tool and Scoring</a></li><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-for-commerce-and-business"  class="lvl-1-link"  >OPERAT for Commerce and Business</a></li></ul></li><li class="lvl-0-item has-child" >
                    <a href="#"  class="lvl-0-link" aria-haspopup="true"  >Resources</a><ul class="lvl-1"><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-translations"  class="lvl-1-link"  >OPERAT Translations</a></li><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-publications"  class="lvl-1-link"  >OPERAT Publications</a></li><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-app-and-training-resources"  class="lvl-1-link"  >OPERAT Training Resources</a></li><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-application"  class="lvl-1-link"  >OPERAT App</a></li><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/external-resources"  class="lvl-1-link"  >External Resources</a></li></ul></li><li class="lvl-0-item has-child" >
                    <a href="#"  class="lvl-0-link" aria-haspopup="true"  >For Researchers</a><ul class="lvl-1"><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/operat-syntax"  class="lvl-1-link"  >OPERAT Syntax</a></li><li class="lvl-1-item" >
                    <a href="https://www.operat.co.uk/study-links"  class="lvl-1-link"  >Study Links</a></li></ul></li><li class="lvl-0-item has-child" >
                    <a href="https://www.operat.co.uk/news-and-events"  class="lvl-0-link" aria-haspopup="true"  >News & Events</a><ul class="lvl-1"><li class="lvl-1-item" >
                    <a href="https://www.twitter.com/cadrprogramme" target="_blank" class="lvl-1-link"  >Twitter (external link)</a></li></ul></li><li class="lvl-0-item" >
                    <a href="${pageContext.request.contextPath}/contact"  class="lvl-0-link"  >Contact Us</a></li></ul>	</nav>

</div>

	</header><!-- header -->



	<div class="region  region--content" id="main-content" itemprop="mainContentOfPage">
		
<div class="region  region--homecontent ">

	<div class="container  container--homecontent js-show">

		<h1><span class="subtitle">Welcome</span></h1>

		<p>To display ares within New Zealand please enter the address or the name of the area you are interested in into the box above, select the action required, and click on the search icon.</p>
		<p>Instructions on how to carry out an OPERAT assessment are available <a href="https://www.operat.co.uk/getfile/documents/manuals/OPERAT-Manual-New-Zealand.pdf">here</a>.</p>
		<p>Or you can enter your results <a href="assessForm/">here</a>.
		<div id="resultsPlaceholder">
		
		</div>

		<!-- p>
			<a href="/upload" class=" [ btn  btn--full  btn--primary ] js-uploadbuttom">
				<i class=" [ i--vac--right  pad ] i--upload  "></i>
				Upload Results Here
			</a>
		</p -->

	</div>

	<div class="container  container--datacontent  js-hide">
		<div class="content">
			<h1>Please select a location..</h1>
		</div>
	</div>

	<div class="container  container--dataentry  container--homecontent  js-hide" id="container--datacontent">
		<div class="content">

			<script type="text/javascript">
	
function showError( msg ){
	console.log("[OPERAT] Error: " + msg);
	$(".js-newpostcodemessage").removeClass("js-hide").html('<p class="error">' + msg + '</p>');
}

function enableControls(){
	//
	console.log("[OPERAT] Enabling controls...");
	$("#js-newbutton").removeProp("disabled");
	$("#js-newbutton").addClass("btn--primary");
	$("#js-newbutton").removeClass("btn--plain");
}

function disableControls(){
	//
	console.log("[OPERAT] Disabling controls...");
	$("#js-newbutton").prop("disabled", "disabled");
	$("#js-newbutton").removeClass("btn--primary");
	$("#js-newbutton").addClass("btn--plain");
}

function verifyPostcode( postcode = '' ){
	if (typeof postcode != "undefined" && postcode != ""){

		showLoading();

		$("#js-newpostcode").val(postcode);

		$.ajax({
			url: "/?ajax=validatepostcode",
			data: {
				postcode: postcode
			},
			method: "POST",
			dataType: "text"
		}).done(function( result ) {

			if (result[0] == "1"){

				var location = result.substring(2, result.length );
				var coords = location.split(",");
				$("#js-latitude").val( coords[0] );
				$("#js-longitude").val( coords[1] );

				console.log("[OPERAT] Found: " + coords[0] + " (latitude), " + coords[1] + " (longitude)" );

				$(".js-newpostcodemessage").removeClass("js-hide").html('<p class="message">Looks good. Please press "Continue", below</p>');

				enableControls();

			} else {

				disableControls();
				// $("#js-newpostcode").val("");
				showError( result.substring(2, result.length ) );

			}
			finishLoading()

		}).fail(function( jqXHR, textStatus  ) {

			alert( "Failed" );
			// $("#js-newpostcode").val("");
			finishLoading();


		})
	}
}

function showLoading(){	
	$("#js-loading").show();
}

function finishLoading(){
	$("#js-loading").hide();	
}

function verifyStep1(){
	var success = false;
	var postcode = $("#js-newpostcode").val();
	// $(".js-newpostcodemessage").addClass("js-hide").html("");
	disableControls();
	if (typeof postcode != "undefined" && postcode != ""){
		verifyPostcode( postcode );
	}
}

function verifyStep2(){
	var success = false;
	disableControls();




	return success;
}


</script>


<h1>Upload New Data..</h1>
<form action="/" method="post" class="form  form--contact" id="form--newdata">

	<fieldset class="step step--1">

		<legend class="hide-visually">Submission details</legend>
		<div class="row">
			<label for="js-newname" class="col lg-5-16">Name</label>
			<span class="col lg-11-16">
				<input type="text" name="newname" value="" class="col" id="js-newname" />
			</span>
		</div>
		<div class="row">
			<label for="js-newemail" class="col lg-5-16">Email</label>
			<span class="col lg-11-16">
				<input type="text" name="newemail" value="" class="col" id="js-newemail" />
			</span>
		</div>
		<div class="row">
			<label for="js-newpostcode" class="col lg-5-16">Postcode</label>
			<span class="col lg-5-16">
				<input type="text" name="postcode" value="" class="col" id="js-newpostcode" />
			</span>
		</div>
		<div class="js-newpostcodemessage  js-hide">
		</div>
		<div>
			<button disabled="disabled" class=" [ btn  btn--full  btn--plain ] " id="js-newbutton">
				Continue...
			</button>
		</div>

	</fieldset>


	<fieldset class="step step--2 js-hide">
		<legend class="hide-visually">Submission details</legend>

		<div class="row">
			<label for="data_ne" class="col lg-13-16">Natural Elements</label>
			<span class="col lg-3-16">
				<input type="text" name="data_ne" id="data_ne" value="0.0" class="col  js-input-val" />
			</span>
		</div>
		<div class="row">
			<label for="data_in" class="col lg-13-16">Incivilities and Nuisance</label>
			<span class="col lg-3-16">
				<input type="text" name="data_in" id="data_in" value="0.0" class="col  js-input-val" />
			</span>
		</div>
		<div class="row">
			<label for="data_tfn" class="col lg-13-16">Territorial Functioning and Navigation</label>
			<span class="col lg-3-16">
				<input type="text" name="data_tfn" id="data_tfn"  value="0.0" class="col  js-input-val" />
			</span>
		</div>
		<div class="row">
			<label for="data_m" class="col lg-13-16">Mobility</label>
			<span class="col lg-3-16">
				<input type="text" name="data_m" id="data_m" value="0.0" class="col  js-input-val" />
			</span>
		</div>
		<div class="row">
			<label for="data_o" class="col lg-13-16">Overall Domain Score</label>
			<span class="col lg-3-16">
				<input type="text" name="data_o" id="data_o" value="0.0" class="col  js-input-overall" />
			</span>
		</div>
		<div>
			<button type="submit" disabled="disabled" class=" [ btn  btn--full  btn--primary ] " id="js-submitbutton">
				Submit
			</button>

		</div>
	</fieldset>


	<input type="hidden" name="latitude" id="js-latitude" value="" />
	<input type="hidden" name="longitude" id="js-longitude" value="" />

	<input type="hidden" name="newdata" value="true" />
	<input type="hidden" name="submitted" value="true" />

</form>







		</div>
	</div>

</div>



<div class="region  region--map">


	<div class="map" id="map">
		Loading...
	</div>


	<div class="map-filter">
		<form action="/" method="get" class="form  form--mapfilter  js-mapfilter  row" id="js-mapfilter">
			<fieldset class="primaryoptions  col  lg-7-16  md-7-16  sm-7-16">

				<div class="form-row  form-row--withborder">
					<div class="input-group">
						<label for="location" class="hide-visually">Address</label>
						<input type="text" name="location" id="location" value="" placeholder="Address" />
						<button type="submit">
							<i class="i--left  i--search">
								<span class="hide-visually">Search</span>
							</i>
						</button>
					</div>
				</div>

				<div class="form-row  form-row--toggleoption" >
					Type an address, or click on the map to select a meshblock.				
				</div>

			</fieldset>

			<fieldset class="col  lg-9-16  md-9-16  sm-9-16  extraoptions  js-hide" id="js-extraoptions">

				<div class="form-row  form-row--filters  row">
					<span class="col  lg-5-16  md-5-16  sm-5-16">
						See breakdown scores:
											</span>
					<div class="col  lg-11-16  md-11-16  sm-11-16  domain-options">		

						<a href="?mode=nat_ele" class="domain-option">Natural Elements</a>

						<a href="?mode=inc_nui" class="domain-option">Incivilities and Nuisance</a>

						<a href="?mode=terr_fun" class="domain-option">Territorial Functioning</a>

						<a href="?mode=nav_mob" class="domain-option">Navigation and Mobility</a>
						
					</div>

				</div>
			</fieldset>
		</form>

	</div>
</div>


	</div>



	<footer class="region  region--footer">
		
<div class="container  container--footer  row">


	<div class="footer-details [ col  lg-10-16 md-10-16 ] ">

		<div class="footer-nav">

					<ul class="footer-lvl-0">
						<li class="footer-lvl-0-item"><a
							href="https://www.operat.co.uk/terms-and-conditions"
							class="footer-lvl-0-link">Terms and Conditions</a></li>
						<li class="footer-lvl-0-item"><a
							href="${pageContext.request.contextPath}/faqs"
							class="footer-lvl-0-link">FAQs</a></li>
						<li class="footer-lvl-0-item"><a
							href="${pageContext.request.contextPath}/contact"
							class="footer-lvl-0-link">Contact Us</a></li>
					</ul>
		</div>

		<a href="https://twitter.com/cadrprogramme" target="_blank" class="btn  btn--twitter  t-twitter">
			<i class="i--vac--right  i--twitter--clear"></i>
			Follow us on Twitter
		</a>

	</div>


	<div class="copyright [ col  lg-6-16 md-6-16 ] ">
		<p>Copyright &copy; OPERAT 2017. All rights reserved.</p>
		<p><a href="http://www.waters-creative.co.uk" target="_blank">Website look & feel by WATERS</a></p>
		<p>New Zealand version by <a href="http://www.furzehill.co.nz" target="_blank">Furzehill</a> and <a href="http://www.parhelion.co.nz" target="_blank">Parhelion</a></p>
	</div>

</div>




	</footer><!-- .region-footer -->	



</body>
</html>

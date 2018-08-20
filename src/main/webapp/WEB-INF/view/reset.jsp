<%@taglib prefix="operat" tagdir="/WEB-INF/tags"
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<operat:head-tag title="Test"/>
</head>

<body class="lo-singlepage lo-home" itemscope itemtype="http://schema.org/WebPage">

	<operat:header/>





	<div class="region  region--content" id="main-content" itemprop="mainContentOfPage">
		
<div class="region  region--homecontent ">

	<div class="container  container--homecontent js-show">

		<h1><span class="subtitle">Welcome</span></h1>

		<p>To display areas within New Zealand please enter the address or the name of the area you are interested in into the box above, select the action required, and click on the search icon.</p>
		<div id="resultsPlaceholder">
		
		</div>
		<p>Instructions on how to carry out an OPERAT assessment are available <a href="https://www.operat.co.uk/getfile/documents/manuals/OPERAT-Manual-New-Zealand.pdf">here</a>.</p>
		<p>When you have completed your assessments you can enter your results <a href="assessForm/">here</a>.  The computer will add up the scores and send them to us.
Or post your completed forms to: 
<address style="padding-left: 5px;">
Christine Stephens<br/>
                                        Freepost 86<br/>
                                        School of Psychology<br/>
                                        Massey University, PB 11 222<br/>
                                        Palmerston North, 4442
 </address>


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


<script>

$(function() {
	$(".js-toggle").each(function(){
		$(this).on("click", function( e ){
			e.preventDefault();
			$( $(this).attr("data-target") ).toggleClass( $(this).attr("data-toggleclass") );
		});
	});

});


</script>
</body>
</html>

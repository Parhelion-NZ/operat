<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<style>
.form-row {
	padding-bottom: 20px;
}
</style>
<% boolean prepopulated = request.getAttribute("block") != null; %>

	<div class="region  region--content" id="main-content" itemprop="mainContentOfPage">
	
	<div class="container">
		<form id="assessmentForm" method="POST" action="${pageContext.request.contextPath}/submitResults">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="meshblockId">Meshblock</label> 
						
						<input type="text" name="meshblockId"
							class="form-control" id="meshblockId" required="required"
							aria-describedby="meshblockHelp" placeholder="Enter meshblock"
							<% if (prepopulated) { %>value="${block.id }"<% } %>> <small id="meshblockHelp"
							class="form-text text-muted">The meshblock is the
							smallest geographic unit for which statistical data is reported
							by Stats NZ. <% if (!prepopulated) {%>							
							If you don't know the meshblock id, use our <a href="${pageContext.request.contextPath}/app">map</a> to look it up.<% } %></small>
							<div class="invalid-feedback">Invalid meshblock number. Please use our <a href="${pageContext.request.contextPath}/app">map</a> to look this up.</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="meshblockId">Number of properties</label> <input name="numberOfProperties"
							type="text" class="form-control" id="numProperties" required="required"
							aria-describedby="meshblockHelp" placeholder="Enter number of properties assessed"
							<% if (prepopulated) { %>value="${addresses.size() }"<% } %>>

					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						Is assessment for the whole area?
						<div class="form-group row pt-2">
						<label class="col-auto col-form-label" for="wholeAreaYes">Yes</label>
						<div class="col-auto pt-2">
						<input type="radio" name="wholeArea" value="true" id="wholeAreaYes" checked="checked"/>
						</div>
						
						<label class="col-auto col-form-label" for="wholeAreaNo">No</label>
						<div class="col-auto mt-2">
						<input type="radio" name="wholeArea" value="false" id="wholeAreaNo"/>
						</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-3">Is there public grass or verges?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q1" type="radio" required="required" value="true" data-weighting="2" data-domain="natural">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q1" type="radio" required="required" value="false" data-weighting="2" data-domain="natural" >No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-3">Are there sounds of nature (e.g. birdsong, water)?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q2" type="radio" required="required" value="true" data-weighting="4" data-domain="natural">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q2" type="radio" required="required" value="false" data-weighting="4" data-domain="natural">No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-3">Are there clear and easy to read road name signs?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q3" type="radio" required="required" value="true">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q3" type="radio" required="required" value="false">No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-3">Are there street lights?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q4" type="radio" required="required" value="true">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q4" type="radio" required="required" value="false">No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-3">Are there any unlit streets or alleyways?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q5" type="radio" required="required"value="true">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q5" type="radio" required="required"value="false">No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-3">Are there instances of littering, dog fouling or broken glass?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q6" type="radio" required="required"value="true">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q6" type="radio" required="required"value="false">No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-3">Are there loud traffic, industrial or other noises?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q7" type="radio" required="required"value="true">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q7" type="radio" required="required"value="false">No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			
			<div class="form-row">
				<div class="col-md-3">Approximate number of vehicles that drove past during assessment?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q8" type="radio" required="required"value="NONE">None</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q8" type="radio" required="required"value="ONE_TO_ELEVEN">One to eleven</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q8" type="radio" required="required"value="TWELVE_OR_MORE">Twelve or more</label></div>
				</div>
			</div>

			<div class="form-row">
				<div class="col-md-3">What is the nature of parking on the street?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q9" type="radio" required="required"value="NOT_RESIDENTS">Not residents only</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q9" type="radio" required="required"value="RESIDENTS">Residents only</label></div>
				</div>
			</div>

			<div class="form-row">
				<div class="col-md-3">Is there a continuous pavement, that is wide enough for 2 people or a wheelchair and is well maintained?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q10" type="radio" required="required"value="NO_PAVEMENT">No pavement</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q10" type="radio" required="required"value="NOT_CONTINUOUS">Yes, but not continuous, narrow or not well maintained</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q10" type="radio" required="required"value="CONTINUOUS">Yes, continuous, wide/moderately wide, well maintained</label></div>
				</div>
			</div>
			
			<div class="form-row">
				<div class="col-md-3">How steep is the pavement and/or road?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q11" type="radio" required="required"value="FLAT">Flat</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q11" type="radio" required="required"value="MEDIUM">Medium &mdash; Slight incline, not troublesome to walk up</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q11" type="radio" required="required"value="STEEP">Steep &mdash; Substantial incline, taxing to walk up</label></div>
				</div>
			</div>
			
			<div class="form-row">
				<div class="col-md-3">How well is the road maintained? </div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q12" type="radio" required="required"value="WELL">Well &mdash; Good condition, no maintenance required</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q12" type="radio" required="required"value="MODERATE">Moderately &mdash; Only minor repairs required</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q12" type="radio" required="required"value="POOR">Poorly &mdash; Lots of pot holes, trip risks, no evidence of repair</label></div>
				</div>
			</div>

			<div class="form-row">
				<div class="col-md-3"> What is the main outlook? </div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q13" type="radio" required="required"value="RESIDENTIAL">Residential</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q13" type="radio" required="required"value="GREEN">Green or sea</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q13" type="radio" required="required"value="INDUSTRIAL">Agricultural industrial, industrial or commercial</label></div>
				</div>
			</div>
			
			<div class="form-row">
				<div class="col-md-3">I feel safe in this area</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q14" type="radio" required="required" value="true" data-weighting="2" data-domain="natural">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q14" type="radio" required="required" value="false" data-weighting="2" data-domain="natural" >No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			
			<div class="form-row">
				<div class="col-md-3">Most people in this area are friendly</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q15" type="radio" required="required" value="true" data-weighting="2" data-domain="natural">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q15" type="radio" required="required" value="false" data-weighting="2" data-domain="natural" >No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			
			<div class="form-row">
				<div class="col-md-3">I can talk to people in this area</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q16" type="radio" required="required" value="true" data-weighting="2" >Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q16" type="radio" required="required" value="false" data-weighting="2">No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>
			
			<div class="form-row">
				<div class="col-md-3">Are there any bus stops or railway stations within the meshblock?</div>
				<div class="col-md-6">
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q17" type="radio" required="required" value="true" data-weighting="2" data-domain="natural">Yes</label></div>
					<div class="form-check"><label class="form-check-label"><input class="form-check-input" name="q17" type="radio" required="required" value="false" data-weighting="2" data-domain="natural" >No</label></div>
					<div class="invalid-feedback">An answer is required.</div>
				</div>
			</div>

			<ul class="nav nav-tabs" id="detailsSelect" role="tablist">
				<li class="nav-item">
					<a class="nav-link active" id="summary-tab" data-toggle="tab" href="#summary" role="tab" aria-controls="summary" aria-selected="true">Summary</a>
				</li>
				<!-- li class="nav-item">
    				<a class="nav-link" id="details-tab" data-toggle="tab" href="#details" role="tab" aria-controls="details" aria-selected="false">Detailed</a>
				</li -->
			</ul>
			<div class="tab-content" id="detailsSelectContent">
  				<div class="tab-pane fade " id="details" role="tabpanel" aria-labelledby="details-tab">

<c:forEach items="${addresses }" var="address">
	<p>${address }</p>
</c:forEach>

				</div>
				<div class="tab-pane fade show active" id="summary" role="tabpanel" aria-labelledby="summary-tab">
					<b>In this section, please enter the number of properties that fit the criteria</b>
					<div class="form-row align-items-center" id="q18row">
						<div class="col-md-3">
						<p class="mt-4 pt-3">Are there trees in their garden</p>
						</div>
						<div class="col-md-1">
							<label for="q18">Yes</label>
							<input type="number" class="form-control" id="numberTrees" name="q18" />
						</div>
						<div class="col-md-1">
							<label for="q18No">No</label>
							<input type="number" class="form-control" id="numberTreesNo" name="q18No"  />
						</div>
					</div>
					<div class="form-row invalid-feedback" id="q18bad">
						<div class="col-md-3"></div>
						<div class="col-md-9">
							These must add to the total number of properties
						</div>
					</div>
					
					<div class="form-row align-items-center" id="q19row">
						<div class="col-md-3">
						<p class="mt-4 pt-3">Is there any external beautification</p>
						</div>
						<div class="col-md-2">
							<label for="q19">Yes</label>
							<input type="number" class="form-control" id="numberPretty" name="q19"  />
						</div>
						<div class="col-md-2">
							<label for="q19No">No</label>
							<input type="number" class="form-control" id="numberPrettyNo" name="q19No"  />
						</div>
						<div class="col-md-2">
							<label for="q19Na">N/A</label>
							<input type="number" class="form-control" id="numberPrettyNa" name="q19Na"  />
						</div>
					</div>
					<div class="form-row invalid-feedback" id="q19bad">
						<div class="col-md-3"></div>
						<div class="col-md-9">
							These must add to the total number of properties
						</div>
					</div>
					
					<div class="form-row align-items-center" id="q20row">
						<div class="col-md-3">
						<p class="mt-4 pt-3">How well maintained is the garden</p>
						</div>
						<div class="col-md-2">
							<label for="q20">Well</label>
							<input type="number" class="form-control" id="numberGarden" name="q20"  />
						</div>
						<div class="col-md-2">
							<label for="q20Mod">Moderate</label>
							<input type="number" class="form-control" id="numberGardenMod" name="q20Mod"  />
						</div>
						<div class="col-md-2">
							<label for="q20Poor">Poor</label>
							<input type="number" class="form-control" id="numberGardenPoor" name="q20Poor"  />
						</div>
						<div class="col-md-2">
							<label for="q20Na">N/A</label>
							<input type="number" class="form-control" id="numberGardenNa" name="q20Na"  />
						</div>
					</div>
					<div class="form-row invalid-feedback" id="q20bad">
						<div class="col-md-3"></div>
						<div class="col-md-9">
							These must add to the total number of properties
						</div>
					</div>
					
					<div class="form-row align-items-center" id="q21row">
						<div class="col-md-3">
							<p class="mt-4 pt-3">How well maintained is the outside of the property</p>
						</div>
						<div class="col-md-2">
							<label for="q21">Well</label>
							<input type="number" class="form-control" id="numberPrettyOutside" name="q21"  />
						</div>
						<div class="col-md-2">
							<label for="q21Mod">Moderate</label>
							<input type="number" class="form-control" id="numberPrettyOutsideMod" name="q21Mod"  />
						</div>
						<div class="col-md-2">
							<label for="q21Poor">Poor</label>
							<input type="number" class="form-control" id="numberPrettyOutsidePoor" name="q21Poor"  />
						</div>
					</div>
					<div class="form-row invalid-feedback" id="q21bad">
						<div class="col-md-3"></div>
						<div class="col-md-9">
							These must add to the total number of properties
						</div>
					</div>
				</div>
			</div>
		
		<div class="row"><div class="col-sm-12">
				<h3>OPERAT Score:</h3>
		</div></div>
		<div class="row">
			<div class="col-sm-6 col-md-3">Natural Elements Score:</div>
			<div class="col-sm-3" id="natualElementsScore"></div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-3">Incivilities Score:</div>
			<div class="col-sm-3" id="incivilitiesScore"></div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-3">Navigation Score:</div>
			<div class="col-sm-3" id="navigationScore"></div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-3">Territorial Score:</div>
			<div class="col-sm-3" id="territorialScore"></div>
		</div>

		<button id="formSubmitButton" type="submit" class="btn btn-primary">Submit Results</button>

		</form>


	</div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>

	<script>
	
	$('#meshblockId').change(function(e) {
		$('#meshblockId').removeClass('is-invalid');
	});

	
	jQuery("#assessmentForm").submit(function(e) {
		
		e.preventDefault();
		
		var okay = checkTotals();
		if (!okay) {
			return;
		}
		
		$('#successMessage').remove();
	
		var data = objectifyForm($("#assessmentForm").serializeArray());

		$('#formSubmitButton').prop('disabled', true);
		$('#formSubmitButton').text('Submitting results ...');
		
		jQuery.ajax({
			type: "POST",
			url: document.getElementById('assessmentForm').action,
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function(responseJSON, status, xhr) {
				
				document.getElementById('assessmentForm').reset();
				
				$('#assessmentForm').append('<div id="successMessage" class="alert alert-success alert-dismissible fade show" role="alert">'
					+ '<strong>Form submitted.</strong> Thank you. You can now enter details for another meshblock, or close this form.'
				  	+ '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
				  	+ '</div>');				
			},
			error: function(jqxhr, status, bob) {
				var response = jqxhr.responseJSON;
				if (response.invalidMeshblock) {
					$('#meshblockId').addClass('is-invalid');
					 $('html, body').animate({
					        scrollTop: $("#meshblockId").offset().top
					 }, 1000);
				}
			},
			complete: function(jqxhr, status) {
				console.log('completed ', jqxhr, status);
				if (status == '400') {
					console.log('complete, status is 400');
					console.log(jqxhr);
				}
				$('#formSubmitButton').prop('disabled', false);
				$('#formSubmitButton').text('Submit results');
			}
		
		});
		

	});	
	
	jQuery("#assessmentForm").change(function(e) {
		var form = document.getElementById('assessmentForm');
		
		//checkTotals();
		
		$('#natualElementsScore').text(calculateNaturalElements(form).toFixed(2));
		$('#incivilitiesScore').text(calculateIncivilities(form).toFixed(2));
		$('#navigationScore').text(calculateNavigation(form).toFixed(2));
		$('#territorialScore').text(calculateTerritorial(form).toFixed(2));
	});
	
	function checkTotals() {
 		var total = parseInt($("#numProperties").val());

 		if (isNaN(total)) {
 			alert('Please specify the number of properties assessed');
 			$("#numProperties").focus();
 			return false;
 		}
 		if (total === 0) {
 			alert('You must assess at least one property!');
 			$("#numProperties").focus();
 			return false;
 		}
 		
 		var bad = false;
 		
 		$('#summary input').each(function(idx, el) {
			if (el.value === '') {
				el.value = 0;
			}
			
		});
 		
 		var q18total = parseInt($('#numberTrees').val()) + parseInt($('#numberTreesNo').val());
 		if (q18total === total) {
 			$('#q18row').removeClass('invalid');	
 			$('#q18bad').removeClass('invalid');
 		} else {
 			bad = true;
 			$('#q18row').addClass('invalid');	
 			$('#q18bad').addClass('invalid');
 		}
 		
 		var q19total = 
 			parseInt($('#numberPretty').val()) + 
 			parseInt($('#numberPrettyNo').val()) + 
 			parseInt($('#numberPrettyNa').val());
 		if (q19total === total) {
 			$('#q19row').removeClass('invalid');	
 			$('#q19bad').removeClass('invalid');
 		} else {
 			bad = true;
 			$('#q19row').addClass('invalid');	
 			$('#q19bad').addClass('invalid');
 		}
 		
 		var q20total = 
 			parseInt($('#numberGarden').val()) + 
 			parseInt($('#numberGardenMod').val()) + 
 			parseInt($('#numberGardenPoor').val()) +
 			parseInt($('#numberGardenNa').val());
 		if (q20total === total) {
 			$('#q20row').removeClass('invalid');	
 			$('#q20bad').removeClass('invalid');
 		} else {
 			bad = true;
 			$('#q20row').addClass('invalid');	
 			$('#q20bad').addClass('invalid');
 		}
 		
 		var q21total = 
 			parseInt($('#numberPrettyOutside').val()) + 
 			parseInt($('#numberPrettyOutsideMod').val()) + 
 			parseInt($('#numberPrettyOutsidePoor').val());
 		if (q21total === total) {
 			$('#q21row').removeClass('invalid');	
 			$('#q21bad').removeClass('invalid');
 		} else {
 			bad = true;
 			$('#q21row').addClass('invalid');	
 			$('#q21bad').addClass('invalid');
 		}
 		
 		
 		
 		return !bad;
 		
 		/* 
		$('#summary input').each(function(idx, el) {
			if (el.value === '') {
				el.value = 0;
			}
			
		});
		
		
		
		console.log(total); */
		
	}
	
	function objectifyForm(formArray) {		//serialize data function

		var returnArray = {};
		for (var i = 0; i < formArray.length; i++) {
			returnArray[formArray[i]['name']] = formArray[i]['value'];
		}
		return returnArray;
	}
	
	function submit() {

		var naturalElements = assessmentForm.q1.value * 2;
		naturalElements += assessmentForm.q2.value * 4;

	}
	
	
	

	function calculateTerritorial(form) {
		var parking = form.q9.value == "NOT_RESIDENTS" ? 2 : 0;
		var outlook = form.q13.value == "INDUSTRIAL" ? 3 : 0;
		
		var beautificationPercentage = form.q19.value / form.numberOfProperties.value;
		var gardenPercentage = form.q20.value / form.numberOfProperties.value;
		var propertyPercentage = form.q21.value / form.numberOfProperties.value;
		
		var beautification = 0;
		if (beautificationPercentage <= .2) {
			beautification = 1;
		} else if (beautificationPercentage <= .99) {
			beautification = 0.5;
 		} 
		beautification *= 3;
		
		var garden = 0;
		if (gardenPercentage < 0.01) {
			garden = 1;
		} else if (gardenPercentage < .8) {
			garden = 0.5;
		}
		garden *= 3;
		
		var property = 0;
		if (propertyPercentage <= 0.1) {
			property = 1;
		} else if (propertyPercentage <= .99) {
			property = 0.5;
		}
		property *= 3;
		
		var domain = (parking + outlook + beautification + garden + property) / 14;
		
		return domain * 20;
		
	}
	
	
	
	

	function calculateNavigation(form) {
		var legibleSigns = form.q3.value === "true" ? 0 : 2;
		var lighting = form.q4.value === "true" ? 0 : 1;
		var alleys = form.q5.value === "true" ? 1 : 0;
		
		var lightingAndAlleys = lighting + alleys == 0 ? 0 : 3;
		
		var pavement = form.q10.value == "NO_PAVEMENT" ? 1 : form.q10.value == "NOT_CONTINUOUS" ? 0.5 : 0;
		pavement *= 3;
		
		var gradient = form.q11.value == "FLAT" ? 0 : form.q11.value == "MEDIUM" ? 0.5 : 1;
		gradient *= 2;
		
		var roadMaintenance = form.q12.value == "WELL" ? 0 : form.q12.value == "MODERATE" ? 0.5 : 1;
		roadMaintenance *= 3;
		
		var domain = (legibleSigns + lightingAndAlleys + pavement + gradient + roadMaintenance) / 13;
		return domain * 40;
	}

	function calculateIncivilities(form) {
		var litter = form.q6.value === "true" ? 4 : 0;
		var noise = form.q7.value === "true" ? 3 : 0;
		var vehicles = form.q8.value == "NONE" ? 0 : form.q8.value == "ONE_TO_ELEVEN" ? 0.5 : 1;
		vehicles *= 3;
		
		var domain = (litter + noise + vehicles) / 10;
		return domain * 20;
	}

	function calculateNaturalElements(form) {
		var treePercentage = form.q18.value / form.numberOfProperties.value;
		
		var grass = form.q1.value == "true" ? 0 : 2;
		var nature = form.q2.value == "true" ? 0 : 4;
		var trees = 0;
		if (treePercentage < .02) {
			trees = 1;
		} else if (treePercentage <= 0.99) {
			trees = .5;
		}
		trees *= 3;
		
		var domainScore = (grass + nature + trees) / 9;
		domainScore *= 20;
		
		return domainScore;
	}
	</script>

	</div>


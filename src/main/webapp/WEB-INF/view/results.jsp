<div class="region  region--content" id="main-content"
	itemprop="mainContentOfPage">

	<div class="region  region--homecontent ">

		<div class="container  container--homecontent js-show">

			<h1>
				<span class="subtitle">Welcome</span>
			</h1>

			<p>To display areas within New Zealand please enter the address
				or the name of the area you are interested in into the box above,
				select the action required, and click on the search icon.</p>
			<div id="resultsPlaceholder"></div>
			<p>
				Instructions on how to carry out an OPERAT assessment are available
				<a
					href="https://www.operat.co.uk/getfile/documents/manuals/OPERAT-Manual-New-Zealand.pdf">here</a>.
			</p>
			<p>
				When you have completed your assessments you can enter your results
				<a href="assessForm/">here</a>. The computer will add up the scores
				and send them to us. Or post your completed forms to:
			<address style="padding-left: 5px;">
				Christine Stephens<br /> Freepost 86<br /> School of Psychology<br />
				Massey University, PB 11 222<br /> Palmerston North, 4442
			</address>


		</div>

		<div class="container  container--datacontent  js-hide">
			<div class="content">
				<h1>Please select a location..</h1>
			</div>
		</div>
	</div>
	<div class="region  region--map">

		<div class="map" id="map">Loading...</div>


		<div class="map-filter">
			<form action="/" method="get"
				class="form  form--mapfilter  js-mapfilter  row" id="js-mapfilter">
				<fieldset class="primaryoptions  col  lg-7-16  md-7-16  sm-7-16">


					<div class="form-row  form-row--toggleoption">Type an
						address, or click on the map to select a meshblock.</div>
					<div class="form-row  form-row--withborder">
						<div class="input-group">
							<label for="location" class="hide-visually">Address</label> <input
								type="text" name="location" id="location" value=""
								placeholder="Address" />
							<button type="submit">
								<i class="i--left  i--search"> <span class="hide-visually">Search</span>
								</i>
							</button>
						</div>
					</div>


					<div class="form-row  form-row--toggleoption" style="width: 250px;">
						<a href="#" class="js-toggle  filterexpand"
							data-target="#js-extraoptions" data-toggleclass="js-hide"> <i
							class="i--vac--right  i--plus"> <span class="hide-visually">Toggle</span>
						</i> <span style="font-size: 0.9em">Displaying all results for
								<br /> <span id="showingScore">Overall Domain Score</span>
						</span>
						</a>
					</div>

				</fieldset>

				<fieldset
					class="col  lg-9-16  md-9-16  sm-9-16  extraoptions  js-hide"
					id="js-extraoptions">

					<div class="form-row  form-row--filters  row">
						<span class="col  lg-5-16  md-5-16  sm-5-16"> See breakdown
							scores:<br> <small><a href="?mode=operat"
								class="domain-option" data-option="overall">Back to overall
									score</a></small>
						</span>
						<div class="col  lg-11-16  md-11-16  sm-11-16  domain-options">

							<a href="?mode=nat_ele" class="domain-option"
								data-option="naturalElements">Natural Elements</a> <a
								href="?mode=inc_nui" class="domain-option"
								data-option="incivilities">Incivilities and Nuisance</a> <a
								href="?mode=terr_fun" class="domain-option"
								data-option="territorial">Territorial Functioning</a> <a
								href="?mode=nav_mob" class="domain-option"
								data-option="navigation">Navigation and Mobility</a>

						</div>

					</div>
				</fieldset>
			</form>

		</div>
	</div>


</div>

<script>
		$(function() {
			Operat.initMap();
			resizeMap(720);
		});
		$(window).on("resize", function() {
			resizeMap(720);
		});
		$(".domain-option").on("click", function(e) {
			var self = this;
			e.preventDefault;

			var showingWhat = 'Overall Domain Score';
			if (self.dataset.option === 'incivilities') {
				showingWhat = 'Incivilities and Nuisance';
			} else if (self.dataset.option === 'naturalElements') {
				showingWhat = 'Natural Elements';
			} else if (self.dataset.option === 'navigation') {
				showingWhat = 'Navigation and Mobility';
			} else if (self.dataset.option === 'territorial') {
				showingWhat = 'Territorial Functioning';
			}

			$('#showingScore').text(showingWhat);
			MapUtils.heatmaps.shapes.forEach(function(shape) {
				shape.poly.setOptions({
					strokeColor : shape[self.dataset.option],
					fillColor : shape[self.dataset.option]
				});
			});
			return false;
		});
	</script>
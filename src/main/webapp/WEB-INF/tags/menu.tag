<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="operat" %>
<div class="px5  container--nav">
	<nav class="nav region region--nav">
		<a href="#" class="nav__toggle  js-toggle" data-target="nav"  data-toggleclass="js-show">
			<i class="i--right i--nav i--more"></i> <span class="nav__toggle__label">Menu</span>
		</a>
		<ul class="lvl-0">
			<li class="lvl-0-item selected" ><a href="${pageContext.request.contextPath}/"  class="lvl-0-link"  >Map</a></li>
			<li class="lvl-0-item has-child" ><a href="https://www.operat.co.uk/background"  class="lvl-0-link" aria-haspopup="true"  >Background</a>
				<ul class="lvl-1">
					<li class="lvl-1-item" ><a href="${pageContext.request.contextPath}/faqs"  class="lvl-1-link"  >Frequently Asked Questions</a></li>
				</ul>
			</li>
			<li class="lvl-0-item has-child" >
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
				<a href="${pageContext.request.contextPath}/contact"  class="lvl-0-link"  >Contact Us</a>
			</li>
		</ul>
	</nav>
</div>
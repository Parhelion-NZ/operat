<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="operat" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>OPERAT
		<tiles:importAttribute name="title" scope="page" ignore="true"/>
    	<c:choose>
		  <c:when test="${not empty pageTitle}"> :: ${pageTitle }</c:when>
		  <c:when test="${not empty title }"> :: ${title }</c:when>
		  <c:otherwise> :: Older People's External Residential Assessment Test</c:otherwise>
		</c:choose>
    </title>
		<operat:head-tag title="Test"/>
	</head>
    <body class="lo-singlepage lo-home" itemscope itemtype="http://schema.org/WebPage">
		<operat:header/>
	
		<tiles:insertAttribute name="body" />

		<tiles:insertAttribute name="footer" />
    </body>
</html>
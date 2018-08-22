<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="operat" %>
<%@ attribute name="title" required="true" type="java.lang.String"%>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-104411886-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-104411886-3');
</script>  

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<script src="${pageContext.request.contextPath}/resources/js/operat.js"></script>
 
<script>
var contextRoot = '${pageContext.request.contextPath}';
</script>
<meta charset="utf-8" />

<title>${title }</title>

<!-- Meta information-->
<meta name="keywords" content="operat, environment, Older Peoples External Residential Assessment Tool, Older People, External Residential Assessment, Residential Assessment Tool, assessment centre for ageing, ageing, research, OPAN, wales, cymru, older people, health, social care, CADR" />
<meta name="description" content="Welcome. " />
<meta name="author" content="Furzehill Consultancy Ltd (www.furzehill.co.nz)" />
<meta name="robots" content="INDEX, FOLLOW" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!-- Facebook OpenGraph elements -->  
<meta property="og:title" content="OPERAT NZ" />
<meta property="og:description" content="New Zealand Older Person's External Residential Assessment Tool" />
<meta property="og:image" content="${pageContext.request.contextPath}/resources/img/social.png" />
<meta property="og:url" content="https://www.operat.co.nz/" />



<!-- stylesheets -->
<link rel="stylesheet" href="resources/styles/operat.css" type="text/css" media="all" />


<!-- other icons -->
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/img/favicon.png" />
<link rel="image_src" href="${pageContext.request.contextPath}/resources/img/social.png" />



<!-- URL handling -->
<link rel="canonical" href="https://www.operat.co.nz/${path }" />

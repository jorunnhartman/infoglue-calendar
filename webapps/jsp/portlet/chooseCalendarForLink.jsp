<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Events" scope="page"/>
<c:set var="activeEventSubNavItem" value="NewEvent" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>

<%@ include file="eventSubFunctionMenu.jsp" %>

<div class="mainCol">
    <div class="portlet_margin">
        <p class="instruction"><ww:property value="this.getLabel('labels.internal.application.chooseCalendarForLinkIntro')"/></p>
    </div>
    
    <div class="columnlabelarea row clearfix">
        <div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.calendar.name')"/></p></div>
        <div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.calendar.description')"/></p></div>
    </div>
    
    <ww:set name="eventId" value="eventId" scope="page"/>
    <portlet:actionURL var="createEventUrl">
        <portlet:param name="action" value="CreateEvent!link"/>
    </portlet:actionURL>
    
    
    <form name="linkForm" method="POST" action="<c:out value="${createEventUrl}"/>">
        <input type="hidden" name="calendarId" id="calendarId" value="">
        <input type="hidden" name="eventId" value="<c:out value="${eventId}"/>">
    </form>
    
    <ww:iterator value="calendars" status="rowstatus">
        
        <ww:set name="calendarId" value="id" scope="page"/>
        <ww:set name="eventId" value="eventId" scope="page"/>
        <portlet:actionURL var="createEventUrl">
            <portlet:param name="action" value="CreateEvent!link"/>
            <portlet:param name="calendarId" value='<%= pageContext.getAttribute("calendarId").toString() %>'/>
            <portlet:param name="eventId" value='<%= pageContext.getAttribute("eventId").toString() %>'/>
        </portlet:actionURL>
        
		<div class="row clearfix">
        
			<a href="javascript:linkEvent('<ww:property value="id"/>');" title="Välj '<ww:property value="name"/>'">    
				<div class="columnLong">
					<p class="portletHeadline">
					<ww:property value="name"/>
					</p>
				</div>
				<div class="columnMedium">
					<p><ww:property value="description"/></p>
				</div>
			</a>
            <div class="columnEnd">
            </div>
        </div>
            
    </ww:iterator>
    
    <ww:if test="calendars == null || calendars.size() == 0">
        <div class="row clearfix">
            <div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
            <div class="columnMedium"></div>
            <div class="columnEnd"></div>
        </div>
    </ww:if>
    
</div>

<%@ include file="adminFooter.jsp" %>

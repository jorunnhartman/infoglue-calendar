<%@page import="java.text.MessageFormat"%>
<%@page import="org.infoglue.calendar.actions.CalendarAbstractAction"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Events" scope="page"/>
<c:set var="activeEventSubNavItem" value="EventSearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>
<%@ include file="eventSubFunctionMenu.jsp" %>

<div class="mainCol">
    <div class="portlet_margin">
        <h1>
            <ww:property value="this.getLabel('labels.internal.event.searchResult')"/>
    
            <ww:if test="events != null && events.size() > 0">
                <ww:if test="searchResultFiles != null && searchResultFiles.size() > 0">
                    <ww:iterator value="searchResultFiles">
                       <a href="<ww:property value="value"/>" title="<ww:property value="key"/>"><img src="<%=request.getContextPath()%>/images/excelIcon.jpg" border="0"/></a>
                    </ww:iterator>
                </ww:if>
            </ww:if>		
        
        </h1>
    </div>
    
    <div class="columnlabelarea row clearfix">
        <div class="columnShort"><p><ww:property value="this.getLabel('labels.internal.event.name')"/></p></div>
        <div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.event.description')"/></p></div>
        <div class="columnShort"><p><ww:property value="this.getLabel('labels.internal.event.owningCalendar')"/></p></div>
        <div class="columnShort"><p><ww:property value="this.getLabel('labels.internal.event.state')"/></p></div>
        <div class="columnDate"><p><ww:property value="this.getLabel('labels.internal.event.startDate')"/></p></div>
    </div>
    
    <portlet:renderURL var="viewListUrl">
        <portlet:param name="action" value="ViewEventSearch"/>
        <c:if test="${searchEventId != null}">
            <ww:iterator value="searchEventId">
                <ww:if test="top != null">
                    <ww:set name="currentSearchEventId" value="top" scope="page"/>
                    <portlet:param name="searchEventId" value='<%= pageContext.getAttribute("currentSearchEventId").toString() %>'/>
                </ww:if>
            </ww:iterator>
        </c:if>
        <c:if test="${searchFirstName != null}">
            <portlet:param name="searchFirstName" value='<%= pageContext.getAttribute("searchFirstName").toString() %>'/>
        </c:if>
        <c:if test="${searchLastName != null}">
            <portlet:param name="searchLastName" value='<%= pageContext.getAttribute("searchLastName").toString() %>'/>
        </c:if>
        <c:if test="${searchEmail != null}">
            <portlet:param name="searchEmail" value='<%= pageContext.getAttribute("searchEmail").toString() %>'/>
        </c:if>
    </portlet:renderURL>
    
    <script type="text/javascript">
        function submitDelete(okUrl, confirmMessage)
        {
            document.confirmForm.okUrl.value = okUrl;
            document.confirmForm.confirmMessage.value = confirmMessage;
            document.confirmForm.submit();
        }
        
        function changeSlot(slotId)
        {
            document.slotForm.currentSlot.value = slotId;
            document.slotForm.submit();
        }
    </script>
    <form name="confirmForm" action="<c:out value="${confirmUrl}"/>" method="post">
        <input type="hidden" name="confirmTitle" value="Radera - bekr&#228;fta"/>
        <input type="hidden" name="confirmMessage" value="Fixa detta"/>
        <input type="hidden" name="okUrl" value=""/>
        <input type="hidden" name="cancelUrl" value="<c:out value="${viewListUrl}"/>"/>	
    </form>
    
    <portlet:renderURL var="slotUrl">
        <portlet:param name="action" value="ViewEventSearch"/>
    </portlet:renderURL>
    
    <form name="slotForm" action="<c:out value="${slotUrl}"/>" method="POST">
        <ww:if test="name != null || name != ''"><input type="hidden" name="name" value="<ww:property value="name"/>"/></ww:if>
        <ww:if test="organizerName != null || organizerName != ''"><input type="hidden" name="organizerName" value="<ww:property value="organizerName"/>"/></ww:if>
        <ww:if test="lecturer != null || lecturer != ''"><input type="hidden" name="lecturer" value="<ww:property value="lecturer"/>"/></ww:if>
        <ww:if test="customLocation != null || customLocation != ''"><input type="hidden" name="customLocation" value="<ww:property value="customLocation"/>"/></ww:if>
        <ww:if test="alternativeLocation != null || alternativeLocation != ''"><input type="hidden" name="alternativeLocation" value="<ww:property value="alternativeLocation"/>"/></ww:if>
        <ww:if test="contactName != null || contactName != ''"><input type="hidden" name="contactName" value="<ww:property value="contactName"/>"/></ww:if>
        <ww:if test="startDateTime != null || startDateTime != ''"><input type="hidden" name="startDateTime" value="<ww:property value="startDateTime"/>"/></ww:if>
        <ww:if test="startTime != null || startTime != ''"><input type="hidden" name="startTime" value="<ww:property value="startTime"/>"/></ww:if>
        <ww:if test="endDateTime != null || endDateTime != ''"><input type="hidden" name="endDateTime" value="<ww:property value="endDateTime"/>"/></ww:if>
        <ww:if test="endTime != null || endTime != ''"><input type="hidden" name="endTime" value="<ww:property value="endTime"/>"/></ww:if>
        <ww:if test="categoryId != null || categoryId != ''"><input type="hidden" name="categoryId" value="<ww:property value="categoryId"/>"/></ww:if>
        <input type="hidden" name="currentSlot" value=""/>
    </form>
    
    <ww:set name="eventList" value="events" scope="page"/>
    
    <c:set var="eventsItems" value="${eventList}"/>
    <ww:if test="events != null && events.size() > 0">
        <ww:set name="numberOfItems" value="numberOfItems" scope="page"/>
        <ww:set name="itemsPerPage" value="itemsPerPage" scope="page"/>
        <%
			try
			{
				String numberOfItems = (String)pageContext.getAttribute("numberOfItems");
				pageContext.setAttribute("numberOfItems", Integer.parseInt(numberOfItems));
			}
			catch (Exception ex)
			{
				pageContext.setAttribute("numberOfItems", 50);
			}
        %>
        <c:if test="${itemsPerPage != null && itemsPerPage != ''}">
            <c:set var="numberOfItems" value="${itemsPerPage}"/>
        </c:if>
        <c:set var="currentSlot" value="${param.currentSlot}"/>
        <c:if test="${currentSlot == null}">
            <c:set var="currentSlot" value="1"/>
        </c:if>
        <c:choose>
            <c:when test="${numberOfItems != -1}">
                <calendar:slots visibleElementsId="eventsItems" visibleSlotsId="indices" lastSlotId="lastSlot" elements="${eventList}" currentSlot="${currentSlot}" slotSize="${numberOfItems}" slotCount="10"/>
            </c:when>
            <c:otherwise>
                <c:set var="eventsItems" value="${eventList}"/>
            </c:otherwise>
        </c:choose>
    </ww:if>
    
    <ww:iterator value="#attr.eventsItems" status="rowstatus">
    
        <ww:set name="eventId" value="id" scope="page"/>
        <ww:set name="event" value="top"/>
        <ww:set name="eventVersion" value="this.getMasterEventVersion('#event')"/>
        <ww:set name="eventVersion" value="this.getMasterEventVersion('#event')" scope="page"/>
        
        <ww:set name="eventName" value="name" scope="page"/>
        <portlet:renderURL var="eventUrl">
            <portlet:param name="action" value="ViewEvent"/>
            <portlet:param name="eventId" value='<%= pageContext.getAttribute("eventId").toString() %>'/>
        </portlet:renderURL>
        
        <portlet:actionURL var="deleteUrl">
            <portlet:param name="action" value="DeleteEvent"/>
            <portlet:param name="eventId" value='<%= pageContext.getAttribute("eventId").toString() %>'/>
        </portlet:actionURL>
            
        <div class="row clearfix">
			<a href="<c:out value="${eventUrl}"/>" title="<ww:property value="this.getParameterizedLabel('labels.internal.general.list.title', #eventVersion.name)"/>">
				<div class="columnShort">
					<p class="portletHeadline"><ww:property value="#eventVersion.name"/></p>
				</div>
				<div class="columnMedium">
					<p class="eventDescription"><ww:property value="#eventVersion.shortDescription"/>&nbsp;</p>
				</div>
				<div class="columnShort">
					<p><ww:property value="owningCalendar.name"/>&nbsp;</p>
				</div>
				<div class="columnShort">
					<p><ww:property value="this.getState(stateId)"/>&nbsp;</p>
				</div>
				<div class="columnDate">
					<p><ww:property value="this.formatDate(startDateTime.time, 'yyyy-MM-dd')"/>&nbsp;</p>
				</div>
			</a>
            <div class="columnEnd">
                <ww:if test="this.getIsEventOwner(top)">
                    <a href="javascript:submitDelete('<c:out value="${deleteUrl}"/>', '&#196;r du s&#228;ker p&#229; att du vill radera &quot;<ww:property value="#eventVersion.name"/>&quot;');" title="Radera '<ww:property value="#eventVersion.name"/>'" class="delete"></a>
                </ww:if>
                <a href="<c:out value="${eventUrl}"/>" title="<ww:property value="this.getParameterizedLabel('labels.internal.general.list.edit.title', #eventVersion.name)"/>" class="edit"></a>
            </div>

        </div>
    </ww:iterator>
    
    <ww:if test="events != null && events.size() > 0">
        <br/>

		<ww:set name="thisObject" value="this" scope="page"/>
		<%
			String currentSlot = (String)pageContext.getAttribute("currentSlot");
			Integer lastSlot = (Integer)pageContext.getAttribute("lastSlot");
			CalendarAbstractAction caa = (CalendarAbstractAction)pageContext.getAttribute("thisObject");
			
			String paginationLabel = caa.getLabel("labels.internal.event.pagination");
			Object[] arguments = {currentSlot, lastSlot};
		
			pageContext.setAttribute("paginationLabelFormatted", MessageFormat.format(paginationLabel, arguments));
		%>

		<div class="prev_next">
			<p><strong><c:out value="${paginationLabelFormatted}"/></strong>&nbsp;</p>
		</div>

        <c:if test="${lastSlot != 1}">
            <div class="prev_next">
                <p>
                <c:if test="${currentSlot gt 1}">
                    <c:set var="previousSlotId" value="${currentSlot - 1}"/>
                    <a href="javascript:changeSlot(1);" class="number" title="<ww:property value="this.getLabel('labels.internal.event.pagination.firstTitle')"/>"><ww:property value="this.getLabel('labels.internal.event.pagination.first')"/></a>
                    <a href="javascript:changeSlot(<c:out value='${previousSlotId}'/>);" title="<ww:property value="this.getLabel('labels.internal.event.pagination.previousTitle')"/>" class="number">&laquo;</a>
                </c:if>
                <c:forEach var="slot" items="${indices}" varStatus="count">
                    <c:if test="${slot == currentSlot}">
                        <span class="number"><c:out value="${slot}"/></span>
                    </c:if>
                    <c:if test="${slot != currentSlot}">
                        <a href="javascript:changeSlot(<c:out value="${slot}"/>);" title="<ww:property value="this.getParameterizedLabel('labels.internal.event.pagination.pageTitle', #attr.slot)"/>" class="number"><c:out value="${slot}"/></a>
                    </c:if>
                </c:forEach>
                <c:if test="${currentSlot lt lastSlot}">
                    <c:set var="nextSlotId" value="${currentSlot + 1}"/>
                    <a href="javascript:changeSlot(<c:out value="${nextSlotId}"/>);" title="<ww:property value="this.getLabel('labels.internal.event.pagination.nextTitle')"/>" class="number">&raquo;</a>
                </c:if>
                </p>
            </div>
        </c:if>
    
        <p>
        <ww:if test="events != null && events.size() > 0">
            <ww:if test="searchResultFiles != null && searchResultFiles.size() > 0">
                <ww:property value="this.getLabel('labels.internal.soba.exportHitList')"/></label>
                <ww:iterator value="searchResultFiles">
                   <a href="<ww:property value="value"/>"><ww:property value="key"/></a>
                </ww:iterator>
            </ww:if>
        </ww:if>		
        </p>	
    
    </ww:if>
    <ww:else>
    
        <ww:if test="events == null || events.size() == 0">
            <div class="row clearfix">
                <div class="columnLong">
					<p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p>
				</div>
                <div class="columnMedium"></div>
                <div class="columnEnd"></div>
            </div>
        </ww:if>
    
    </ww:else>
</div>

<%@ include file="adminFooter.jsp" %>
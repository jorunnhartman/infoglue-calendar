<!---------- Jorunns testmeny -------------------->

<portlet:renderURL var="viewAuthorizationSwitchManagementUrl">
	<portlet:param name="action" value="ViewAuthorizationSwitchManagement!input"/>
</portlet:renderURL>

<portlet:renderURL var="viewApplicationStateUrl">
	<portlet:param name="action" value="ViewApplicationState"/>
</portlet:renderURL>

<portlet:renderURL var="viewSettingsUrl">
	<portlet:param name="action" value="ViewSettings"/>
</portlet:renderURL>

<portlet:renderURL var="viewLabelsUrl">
	<portlet:param name="action" value="ViewLabels"/>
</portlet:renderURL>

<calendar:hasRole id="calendarSuperUser" roleName="CalendarSuperUser"/>
<calendar:hasRole id="calendarAdministrator" roleName="CalendarAdministrator"/>
<calendar:hasRole id="calendarOwner" roleName="CalendarOwner"/>
<calendar:hasRole id="eventPublisher" roleName="EventPublisher"/>

<c:if test="${calendarSuperUser == true}">	
   <nav class="subfunctionarea clearfix">
		<div class="subfunctionarea-content">
			<a href="<c:out value="${viewSettingsUrl}"/>" <c:if test="${activeEventSubNavItem == 'Settings'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationAdministerSettings')"/></a>	
			<a href="<c:out value="${viewAuthorizationSwitchManagementUrl}"/>" <c:if test="${activeEventSubNavItem== 'AuthorizationSwitchManagement'}">class="current"</c:if>>Auth transfer</a> 
			<a href="<c:out value="${viewApplicationStateUrl}"/>" <c:if test="${activeEventSubNavItem== 'ViewApplicationState'}">class="current"</c:if>>AppState</a>
			<a href="<c:out value="${viewLabelsUrl}"/>" <c:if test="${activeEventSubNavItem == 'Labels'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationAdministerLabels')"/></a>
		</div>
	</nav>
</c:if>
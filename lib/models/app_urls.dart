class AppUrl {
  static String baseURL = "http://g6ca9akm8spg3fs7m2n4j3l.dyn-o-saur.com:8078/";

  // static String shiftURL = "http://91.74.105.110:8078/";

  get shifturl => baseURL;
  set shifturl(val) {
    baseURL = val;
  }

  static String loginToken = baseURL + "event/request/token";

  static String loginStaff = baseURL + "event/user-login";

  static String logout = baseURL + "event/user-logout";
  static String uploadImage = baseURL + "event/update-profile-photo";

  static String eventByUser = baseURL + "event/event-list-by-user";
  static String eventByClient = baseURL + "event/event-list-by-client";
  static String getServiceProduct = baseURL + "event/get-service-product";
  static String getEventService = baseURL + "event/get-event-service";
  static String createEventTeam = baseURL + "event/create-event-team";
  static String createEventTeamManager =
      baseURL + "event/event/create-event-team-Manager";
  static String createEventTeamSupervisor =
      baseURL + "event/event/create-event-team-supervisor";
  // static   String createEventTeamGaurd =
  //     "http://control-e.dyndns.org:8078/event/create-event-team-guard";
  static String createEvent = baseURL + "event/create-event";
  static String eventDashboardStats = baseURL + "event/event-dashboard-stats";
  static String eventDashboardStatsSupervisor =
      baseURL + "event/event-dashboard-stats-supervisor";
  static String eventDashboardStatsManager =
      baseURL + "event/event-dashboard-stats-manager";
  static String eventDashboardStatsClient =
      baseURL + "event/event-dashboard-stats-client";
  static String teamDetails = baseURL + "event/team-details";
  static String liveTracking = baseURL + "event/live-tracking";
  static String userGeolocation = baseURL + "event/user-geolocation";
  static String postActivity = baseURL + "event/post-activity";
  static String eventActivityList = baseURL + "event/event-activity-list";
  static String eventActivityLogs = baseURL + "event/event-activity-logs";
  static String chatThreads = baseURL + "event/chat-threads";
  static String chatThreadMessages = baseURL + "event/chat-thread-messages";
  static String postChatMessage = baseURL + "event/post-chat-message";
  static String postChatMedia = baseURL + "event/post-chat-media";
  static String timesheetDetail = baseURL + "event/timesheet-details";
  static String timesheetDetailsByEventByDate =
      baseURL + "event/timesheet-details-Daily-sheet-by-event_users_bydate";
  static String timesheetDetailsSummaryByEventAllUser =
      baseURL + "event/timesheet-details-summary-time-sheet-by-event_allusers";
  static String timesheetDetailsFullByEventAllUser =
      baseURL + "event/timesheet-details-full-time-sheet-by-event_allusers";
  static String eventIncidentStats = baseURL + "event/event-incident-stats";
  static String createIncidentReport = baseURL + "event/create-incident-report";
  static String incidentReport = baseURL + "event/incident-report";
  static String updateIncidentReport = baseURL + "event/update-incident-report";
  static String uploadEventDoc = baseURL + "event/upload-event-document";
  static String userDocList = baseURL + "event/event-document-list";
  static String getInvoiceDetail = baseURL + "event/get-invoice-details";
  static String eventInvoiceVendorPdf =
      baseURL + "event/event-Invoice-vendor-pdf";
  static String eventInvoiceCompanyPdf =
      baseURL + "event/event-Invoice-company-pdf";
  static String eventSpecialInstruction =
      baseURL + "event/event-special-instruction";
  static String postSpecialInstruction =
      baseURL + "event/post-special-instructions";
  static String getFeedback = baseURL + "event/get-feedback";
  static String postFeedback = baseURL + "event/post-feedback";
  static String membershipList = baseURL + "event/membership-list";
  static String helpdeskList = baseURL + "event/helpdesk-list";
  static String postHelpdeskReport = baseURL + "event/post-helpdesk-report";
  static String getAssigned = baseURL + "event/get-assigned";
  static String getTags = baseURL + "event/get-tags";
}

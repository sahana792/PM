package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import database.dbconfig;

public final class admindashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/adminheader.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<!--\n");
      out.write("To change this license header, choose License Headers in Project Properties.\n");
      out.write("To change this template file, choose Tools | Templates\n");
      out.write("and open the template in the editor.\n");
      out.write("-->\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("    <!-- Required meta tags -->\n");
      out.write("    <meta charset=\"utf-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\n");
      out.write("    <title>Project Management</title>\n");
      out.write("    <!-- plugins:css -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"assets/vendors/mdi/css/materialdesignicons.min.css\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"assets/vendors/flag-icon-css/css/flag-icon.min.css\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"assets/vendors/css/vendor.bundle.base.css\">\n");
      out.write("    <!-- endinject -->\n");
      out.write("    <!-- Plugin css for this page -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"assets/vendors/font-awesome/css/font-awesome.min.css\" />\n");
      out.write("    <link rel=\"stylesheet\" href=\"assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css\">\n");
      out.write("    <!-- End plugin css for this page -->\n");
      out.write("    <!-- inject:css -->\n");
      out.write("    <!-- endinject -->\n");
      out.write("    <!-- Layout styles -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"assets/css/style.css\">\n");
      out.write("    <!-- End layout styles -->\n");
      out.write("    <link rel=\"shortcut icon\" href=\"assets/images/favicon.png\" />\n");
      out.write("    \n");
      out.write("  </head>\n");
      out.write("  <body>\n");
      out.write("      <!--------header start--------->\n");
      out.write("    <div class=\"container-scroller\">\n");
      out.write("      <!-- partial:partials/_navbar.html -->\n");
      out.write("      <nav class=\"navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row\">\n");
      out.write("        <div class=\"text-center navbar-brand-wrapper d-flex align-items-center justify-content-center\">\n");
      out.write("          <a class=\"navbar-brand brand-logo\" href=\"index.html\"><img src=\"assets/images/logo.svg\" alt=\"logo\" /></a>\n");
      out.write("          <a class=\"navbar-brand brand-logo-mini\" href=\"index.html\"><img src=\"assets/images/logo-mini.jpg\" alt=\"logo\" /></a>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"navbar-menu-wrapper d-flex align-items-stretch\">\n");
      out.write("          <button class=\"navbar-toggler navbar-toggler align-self-center\" type=\"button\" data-toggle=\"minimize\">\n");
      out.write("            <span class=\"mdi mdi-menu\"></span>\n");
      out.write("          </button>\n");
      out.write("          <div class=\"search-field d-none d-xl-block\">\n");
      out.write("            <form class=\"d-flex align-items-center h-100\" action=\"#\">\n");
      out.write("              <div class=\"input-group\">\n");
      out.write("                <div class=\"input-group-prepend bg-transparent\">\n");
      out.write("                  <i class=\"input-group-text border-0 mdi mdi-magnify\"></i>\n");
      out.write("                </div>\n");
      out.write("                <input type=\"text\" class=\"form-control bg-transparent border-0\" placeholder=\"Search projects\">\n");
      out.write("              </div>\n");
      out.write("            </form>\n");
      out.write("          </div>\n");
      out.write("          <ul class=\"navbar-nav navbar-nav-right\">\n");
      out.write("            <li class=\"nav-item  dropdown d-none d-md-block\">\n");
      out.write("              <a class=\"nav-link dropdown-toggle\" id=\"reportDropdown\" href=\"#\" data-toggle=\"dropdown\" aria-expanded=\"false\"> Reports </a>\n");
      out.write("              <div class=\"dropdown-menu navbar-dropdown\" aria-labelledby=\"reportDropdown\">\n");
      out.write("                <a class=\"dropdown-item\" href=\"#\">\n");
      out.write("                  <i class=\"mdi mdi-file-pdf mr-2\"></i>PDF </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item\" href=\"#\">\n");
      out.write("                  <i class=\"mdi mdi-file-excel mr-2\"></i>Excel </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item\" href=\"#\">\n");
      out.write("                  <i class=\"mdi mdi-file-word mr-2\"></i>doc </a>\n");
      out.write("              </div>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"nav-item  dropdown d-none d-md-block\">\n");
      out.write("              <a class=\"nav-link dropdown-toggle\" id=\"projectDropdown\" href=\"#\" data-toggle=\"dropdown\" aria-expanded=\"false\"> Projects </a>\n");
      out.write("              <div class=\"dropdown-menu navbar-dropdown\" aria-labelledby=\"projectDropdown\">\n");
      out.write("                <a class=\"dropdown-item\" href=\"clienthome.jsp\">\n");
      out.write("                  <i class=\"mdi mdi-eye-outline mr-2\"></i>View Project </a>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"nav-item dropdown\">\n");
      out.write("              <a class=\"nav-link count-indicator dropdown-toggle\" id=\"messageDropdown\" href=\"#\" data-toggle=\"dropdown\" aria-expanded=\"false\">\n");
      out.write("                <i class=\"mdi mdi-email-outline\"></i>\n");
      out.write("                <span class=\"count-symbol bg-success\"></span>\n");
      out.write("              </a>\n");
      out.write("              <div class=\"dropdown-menu dropdown-menu-right navbar-dropdown preview-list\" aria-labelledby=\"messageDropdown\">\n");
      out.write("                <h6 class=\"p-3 mb-0 bg-primary text-white py-4\">Messages</h6>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item preview-item\">\n");
      out.write("                  <div class=\"preview-thumbnail\">\n");
      out.write("                    <img src=\"assets/images/faces/face4.jpg\" alt=\"image\" class=\"profile-pic\">\n");
      out.write("                  </div>\n");
      out.write("                  <div class=\"preview-item-content d-flex align-items-start flex-column justify-content-center\">\n");
      out.write("                    <h6 class=\"preview-subject ellipsis mb-1 font-weight-normal\">Mark send you a message</h6>\n");
      out.write("                    <p class=\"text-gray mb-0\"> 1 Minutes ago </p>\n");
      out.write("                  </div>\n");
      out.write("                </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item preview-item\">\n");
      out.write("                  <div class=\"preview-thumbnail\">\n");
      out.write("                    <img src=\"assets/images/faces/face2.jpg\" alt=\"image\" class=\"profile-pic\">\n");
      out.write("                  </div>\n");
      out.write("                  <div class=\"preview-item-content d-flex align-items-start flex-column justify-content-center\">\n");
      out.write("                    <h6 class=\"preview-subject ellipsis mb-1 font-weight-normal\">Cregh send you a message</h6>\n");
      out.write("                    <p class=\"text-gray mb-0\"> 15 Minutes ago </p>\n");
      out.write("                  </div>\n");
      out.write("                </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item preview-item\">\n");
      out.write("                  <div class=\"preview-thumbnail\">\n");
      out.write("                    <img src=\"assets/images/faces/face3.jpg\" alt=\"image\" class=\"profile-pic\">\n");
      out.write("                  </div>\n");
      out.write("                  <div class=\"preview-item-content d-flex align-items-start flex-column justify-content-center\">\n");
      out.write("                    <h6 class=\"preview-subject ellipsis mb-1 font-weight-normal\">Profile picture updated</h6>\n");
      out.write("                    <p class=\"text-gray mb-0\"> 18 Minutes ago </p>\n");
      out.write("                  </div>\n");
      out.write("                </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <h6 class=\"p-3 mb-0 text-center\">4 new messages</h6>\n");
      out.write("              </div>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"nav-item dropdown\">\n");
      out.write("              <a class=\"nav-link count-indicator dropdown-toggle\" id=\"notificationDropdown\" href=\"#\" data-toggle=\"dropdown\">\n");
      out.write("                <i class=\"mdi mdi-bell-outline\"></i>\n");
      out.write("                <span class=\"count-symbol bg-danger\"></span>\n");
      out.write("              </a>\n");
      out.write("              <div class=\"dropdown-menu dropdown-menu-right navbar-dropdown preview-list\" aria-labelledby=\"notificationDropdown\">\n");
      out.write("                <h6 class=\"p-3 mb-0 bg-primary text-white py-4\">Notifications</h6>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item preview-item\">\n");
      out.write("                  <div class=\"preview-thumbnail\">\n");
      out.write("                    <div class=\"preview-icon bg-success\">\n");
      out.write("                      <i class=\"mdi mdi-calendar\"></i>\n");
      out.write("                    </div>\n");
      out.write("                  </div>\n");
      out.write("                  <div class=\"preview-item-content d-flex align-items-start flex-column justify-content-center\">\n");
      out.write("                    <h6 class=\"preview-subject font-weight-normal mb-1\">Event today</h6>\n");
      out.write("                    <p class=\"text-gray ellipsis mb-0\"> Just a reminder that you have an event today </p>\n");
      out.write("                  </div>\n");
      out.write("                </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item preview-item\">\n");
      out.write("                  <div class=\"preview-thumbnail\">\n");
      out.write("                    <div class=\"preview-icon bg-warning\">\n");
      out.write("                      <i class=\"mdi mdi-settings\"></i>\n");
      out.write("                    </div>\n");
      out.write("                  </div>\n");
      out.write("                  <div class=\"preview-item-content d-flex align-items-start flex-column justify-content-center\">\n");
      out.write("                    <h6 class=\"preview-subject font-weight-normal mb-1\">Settings</h6>\n");
      out.write("                    <p class=\"text-gray ellipsis mb-0\"> Update dashboard </p>\n");
      out.write("                  </div>\n");
      out.write("                </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <a class=\"dropdown-item preview-item\">\n");
      out.write("                  <div class=\"preview-thumbnail\">\n");
      out.write("                    <div class=\"preview-icon bg-info\">\n");
      out.write("                      <i class=\"mdi mdi-link-variant\"></i>\n");
      out.write("                    </div>\n");
      out.write("                  </div>\n");
      out.write("                  <div class=\"preview-item-content d-flex align-items-start flex-column justify-content-center\">\n");
      out.write("                    <h6 class=\"preview-subject font-weight-normal mb-1\">Launch Admin</h6>\n");
      out.write("                    <p class=\"text-gray ellipsis mb-0\"> New admin wow! </p>\n");
      out.write("                  </div>\n");
      out.write("                </a>\n");
      out.write("                <div class=\"dropdown-divider\"></div>\n");
      out.write("                <h6 class=\"p-3 mb-0 text-center\">See all notifications</h6>\n");
      out.write("              </div>\n");
      out.write("            </li>\n");
      out.write("          </ul>\n");
      out.write("          <button class=\"navbar-toggler navbar-toggler-right d-lg-none align-self-center\" type=\"button\" data-toggle=\"offcanvas\">\n");
      out.write("            <span class=\"mdi mdi-menu\"></span>\n");
      out.write("          </button>\n");
      out.write("        </div>\n");
      out.write("      </nav>\n");
      out.write("      <!-- partial -->\n");
      out.write("      <div class=\"container-fluid page-body-wrapper\">\n");
      out.write("        <!-- partial:partials/_sidebar.html -->\n");
      out.write("        <nav class=\"sidebar sidebar-offcanvas\" id=\"sidebar\">\n");
      out.write("          <ul class=\"nav\">\n");
      out.write("            <li class=\"nav-item nav-category\">Main</li>\n");
      out.write("            <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"adashboard.jsp\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-view-dashboard menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Dashboard</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"nav-item\">\n");
      out.write("              <!---<a class=\"nav-link\" href=\"pages/icons/mdi.html\">---->\n");
      out.write("                  <a class=\"nav-link\" href=\"aclientrequirement.jsp\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-contacts menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Clients Requirements</span>\n");
      out.write("              </a>\n");
      out.write("            \n");
      out.write("            <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"projectlist.jsp\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-application menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Project Lists</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("            \n");
      out.write("            <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"clienthome.jsp\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-file-outline menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Projects</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("            \n");
      out.write("            <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"pages/forms/basic_elements.html\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-format-list-bulleted menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Deliverables</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("            \n");
      out.write("             <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" data-toggle=\"collapse\" href=\"#ui-basic\" aria-expanded=\"false\" aria-controls=\"ui-basic\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-account-check menu-icon\"></i></span>\n");
      out.write("                \n");
      out.write("                <span class=\"menu-title\">Tasks</span>\n");
      out.write("                <i class=\"menu-arrow\"></i>\n");
      out.write("              </a>\n");
      out.write("              <div class=\"collapse\" id=\"ui-basic\">\n");
      out.write("                <ul class=\"nav flex-column sub-menu\">\n");
      out.write("                  <li class=\"nav-item\"> <a class=\"nav-link\" href=\"assignedlist.jsp\">Assigned List</a></li>\n");
      out.write("                </ul>\n");
      out.write("              </div>\n");
      out.write("            </li>\n");
      out.write("            \n");
      out.write("            \n");
      out.write("             <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"addemployee.jsp\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-account-multiple menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Employees</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("            \n");
      out.write("               <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"empattendance.jsp\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-account-multiple menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Emp Attendance</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("             \n");
      out.write("            \n");
      out.write("             <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-check-circle menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Task Progress</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("            \n");
      out.write("            \n");
      out.write("             <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"pages/icons/mdi.html\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-camera-timer menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Time Tracking</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("            \n");
      out.write("             <li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" href=\"pages/icons/mdi.html\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-chart-areaspline menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">Performance</span>\n");
      out.write("              </a>\n");
      out.write("            </li>\n");
      out.write("       \n");
      out.write("            \n");
      out.write("            <!---<li class=\"nav-item\">\n");
      out.write("              <a class=\"nav-link\" data-toggle=\"collapse\" href=\"#auth\" aria-expanded=\"false\" aria-controls=\"auth\">\n");
      out.write("                <span class=\"icon-bg\"><i class=\"mdi mdi-lock menu-icon\"></i></span>\n");
      out.write("                <span class=\"menu-title\">User Pages</span>\n");
      out.write("                <i class=\"menu-arrow\"></i>\n");
      out.write("              </a>\n");
      out.write("              <div class=\"collapse\" id=\"auth\">\n");
      out.write("                <ul class=\"nav flex-column sub-menu\">\n");
      out.write("                  <li class=\"nav-item\"> <a class=\"nav-link\" href=\"pages/samples/blank-page.html\"> Add Project </a></li>\n");
      out.write("                  <li class=\"nav-item\"> <a class=\"nav-link\" href=\"pages/samples/login.html\"> Project List</a></li>\n");
      out.write("                  <li class=\"nav-item\"> <a class=\"nav-link\" href=\"pages/samples/register.html\"> Deliverables</a></li>\n");
      out.write("                </ul>\n");
      out.write("              </div>\n");
      out.write("            </li>----->\n");
      out.write("            <li class=\"nav-item sidebar-user-actions\">\n");
      out.write("              <div class=\"sidebar-user-menu\">\n");
      out.write("                <a href=\"#\" class=\"nav-link\"><i class=\"mdi mdi-settings menu-icon\"></i>\n");
      out.write("                  <span class=\"menu-title\">Settings</span>\n");
      out.write("                </a>\n");
      out.write("              </div>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"nav-item sidebar-user-actions\">\n");
      out.write("              <div class=\"sidebar-user-menu\">\n");
      out.write("                <a href=\"alllogin.jsp\" class=\"nav-link\"><i class=\"mdi mdi-logout menu-icon\"></i>\n");
      out.write("                  <span class=\"menu-title\">Log Out</span></a>\n");
      out.write("              </div>\n");
      out.write("            </li>\n");
      out.write("          </ul>\n");
      out.write("        </nav>\n");
      out.write("        <!-----------header end------>\n");
      out.write("             \n");
      out.write("  \n");
      out.write("        \n");
      out.write("        \n");
      out.write("    \n");
      out.write("    \n");
      out.write("        \n");
      out.write("        <!-- plugins:js -->\n");
      out.write("    <script src=\"assets/vendors/js/vendor.bundle.base.js\"></script>\n");
      out.write("    <!-- endinject -->\n");
      out.write("    <!-- Plugin js for this page -->\n");
      out.write("    <script src=\"assets/vendors/chart.js/Chart.min.js\"></script>\n");
      out.write("    <script src=\"assets/vendors/jquery-circle-progress/js/circle-progress.min.js\"></script>\n");
      out.write("    <!-- End plugin js for this page -->\n");
      out.write("    <!-- inject:js -->\n");
      out.write("    <script src=\"assets/js/off-canvas.js\"></script>\n");
      out.write("    <script src=\"assets/js/hoverable-collapse.js\"></script>\n");
      out.write("    <script src=\"assets/js/misc.js\"></script>\n");
      out.write("    <!-- endinject -->\n");
      out.write("    <!-- Custom js for this page -->\n");
      out.write("    <script src=\"assets/js/dashboard.js\"></script>\n");
      out.write("    <!-- End custom js for this page -->\n");
      out.write("      </body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Employee Attendance List</title>\n");
      out.write("\n");
      out.write("    <!-- Chart.js -->\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/chart.js\"></script>\n");
      out.write("\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: Arial, sans-serif;\n");
      out.write("            background: #f4f6f9;\n");
      out.write("            margin: 0;\n");
      out.write("            padding: 0;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .container {\n");
      out.write("            width: 90%;\n");
      out.write("            margin: 50px auto;\n");
      out.write("            background: #ffffff;\n");
      out.write("            padding: 25px;\n");
      out.write("            border-radius: 8px;\n");
      out.write("            box-shadow: 0 4px 12px rgba(0,0,0,0.1);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        h2 {\n");
      out.write("            text-align: center;\n");
      out.write("            color: #333333;\n");
      out.write("            margin-bottom: 30px;\n");
      out.write("            border-bottom: 3px solid #007bff;\n");
      out.write("            padding-bottom: 10px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        table {\n");
      out.write("            width: 100%;\n");
      out.write("            border-collapse: collapse;\n");
      out.write("            margin-top: 15px;\n");
      out.write("            border: 2px solid #007bff;\n");
      out.write("            border-radius: 6px;\n");
      out.write("            overflow: hidden;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        th, td {\n");
      out.write("            border: 1px solid #b5b5b5;\n");
      out.write("            padding: 12px;\n");
      out.write("            text-align: center;\n");
      out.write("            font-size: 15px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        th {\n");
      out.write("            background-color: #007bff;\n");
      out.write("            color: white;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        tr:nth-child(even) {\n");
      out.write("            background-color: #f4f9ff;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        tr:hover {\n");
      out.write("            background-color: #e7f1ff;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .filter-box {\n");
      out.write("            margin-bottom: 20px;\n");
      out.write("            text-align: center;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .filter-box input {\n");
      out.write("            padding: 8px;\n");
      out.write("            font-size: 15px;\n");
      out.write("            margin: 5px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .filter-btn {\n");
      out.write("            padding: 8px 18px;\n");
      out.write("            background: #007bff;\n");
      out.write("            color: white;\n");
      out.write("            border: none;\n");
      out.write("            cursor: pointer;\n");
      out.write("            border-radius: 4px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .filter-btn:hover {\n");
      out.write("            background: #0056cc;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .chart-container {\n");
      out.write("            width: 100%;\n");
      out.write("            margin: 30px 0;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <h2>Daily Employee Attendance</h2>\n");
      out.write("\n");
      out.write("        <!-- Filter Form -->\n");
      out.write("        <form method=\"get\" class=\"filter-box\">\n");
      out.write("            <label>From: </label>\n");
      out.write("            <input type=\"date\" name=\"from\" required>\n");
      out.write("            <label>To: </label>\n");
      out.write("            <input type=\"date\" name=\"to\" required>\n");
      out.write("            <button type=\"submit\" class=\"filter-btn\">Filter</button>\n");
      out.write("        </form>\n");
      out.write("\n");
      out.write("        <!-- Graph Data Fetch -->\n");
      out.write("        ");

            StringBuilder dates = new StringBuilder("[");
            StringBuilder counts = new StringBuilder("[");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con2 = new dbconfig().getConnection();

                String from = request.getParameter("from");
                String to = request.getParameter("to");

                String graphQuery = "";

                if (from != null && to != null) {
                    graphQuery = "SELECT date, COUNT(*) AS total FROM employeeattendance " +
                                 "WHERE date BETWEEN '" + from + "' AND '" + to + "' " +
                                 "GROUP BY date ORDER BY date ASC";
                } else {
                    graphQuery = "SELECT date, COUNT(*) AS total FROM employeeattendance " +
                                 "GROUP BY date ORDER BY date ASC";
                }

                Statement st2 = con2.createStatement();
                ResultSet rs2 = st2.executeQuery(graphQuery);

                while (rs2.next()) {
                    dates.append("'").append(rs2.getString("date")).append("',");
                    counts.append(rs2.getInt("total")).append(",");
                }

                if (dates.length() > 1) dates.setLength(dates.length() - 1);
                if (counts.length() > 1) counts.setLength(counts.length() - 1);

                dates.append("]");
                counts.append("]");

                con2.close();

            } catch (Exception e) {
                out.println("Error: " + e);
            }
        
      out.write("\n");
      out.write("\n");
      out.write("        <!-- Attendance Chart -->\n");
      out.write("        <div class=\"chart-container\">\n");
      out.write("            <canvas id=\"attendanceChart\"></canvas>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("            const ctx = document.getElementById('attendanceChart').getContext('2d');\n");
      out.write("\n");
      out.write("            new Chart(ctx, {\n");
      out.write("                type: 'line',   // Change to \"bar\" if you want a bar chart\n");
      out.write("                data: {\n");
      out.write("                    labels: ");
      out.print( dates.toString() );
      out.write(",\n");
      out.write("                    datasets: [{\n");
      out.write("                        label: 'Daily Login Count',\n");
      out.write("                        data: ");
      out.print( counts.toString() );
      out.write(",\n");
      out.write("                        borderColor: '#007bff',\n");
      out.write("                        backgroundColor: 'rgba(0, 123, 255, 0.2)',\n");
      out.write("                        borderWidth: 2,\n");
      out.write("                        fill: true,\n");
      out.write("                        tension: 0.3\n");
      out.write("                    }]\n");
      out.write("                },\n");
      out.write("                options: {\n");
      out.write("                    responsive: true,\n");
      out.write("                    scales: {\n");
      out.write("                        y: {\n");
      out.write("                            beginAtZero: true,\n");
      out.write("                            title: { display: true, text: 'Employees Logged In' }\n");
      out.write("                        },\n");
      out.write("                        x: {\n");
      out.write("                            title: { display: true, text: 'Date' }\n");
      out.write("                        }\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("        <!-- Attendance Table -->\n");
      out.write("        <table>\n");
      out.write("            <tr>\n");
      out.write("                <th>Sl no</th>\n");
      out.write("                <th>Employee ID</th>\n");
      out.write("                <th>Name</th>\n");
      out.write("                <th>Date</th>\n");
      out.write("                <th>Login Time</th>\n");
      out.write("            </tr>\n");
      out.write("\n");
      out.write("            ");

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    
                    String from = request.getParameter("from");
                    String to = request.getParameter("to");

                    String query = "";

                    if (from != null && to != null) {
                        query = "SELECT * FROM employeeattendance WHERE date BETWEEN '" +
                                 from + "' AND '" + to + "' ORDER BY date DESC, logintime DESC";
                    } else {
                        query = "SELECT * FROM employeeattendance ORDER BY date DESC, logintime DESC";
                    }

                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery(query);

                    int count = 1;

                    while(rs.next()) {
            
      out.write("\n");
      out.write("\n");
      out.write("            <tr>\n");
      out.write("                <td>");
      out.print( count++ );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( rs.getString("mid") );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( rs.getString("name") );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( rs.getString("date") );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( rs.getString("logintime") );
      out.write("</td>\n");
      out.write("            </tr>\n");
      out.write("\n");
      out.write("            ");
  }

                con.close();
            } catch(Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e + "</td></tr>");
            }
            
      out.write("\n");
      out.write("        </table>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}

package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class managerchat_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/chatdata.jsp");
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

      out.write('\n');
      out.write('\n');

    // Initialize chatMessages if not present
    if(session.getAttribute("chatMessages") == null){
        session.setAttribute("chatMessages", new java.util.ArrayList<String>());
    }

    java.util.List<String> chatMessages = (java.util.List<String>) session.getAttribute("chatMessages");

    // If a new message is submitted, add to list
    String sender = request.getParameter("sender");
    String message = request.getParameter("message");

    if(sender != null && message != null && !message.trim().isEmpty()){
        chatMessages.add(sender + ": " + message);
    }

    session.setAttribute("chatMessages", chatMessages);

      out.write('\n');
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Manager Chat</title>\n");
      out.write("    <style>\n");
      out.write("        .chat-box {\n");
      out.write("            width: 60%; \n");
      out.write("            margin: auto; \n");
      out.write("            border: 1px solid #ccc; \n");
      out.write("            padding: 10px; \n");
      out.write("            height: 400px; \n");
      out.write("            overflow-y: scroll;\n");
      out.write("            background: #f0f8ff;\n");
      out.write("        }\n");
      out.write("        .message-form { text-align: center; margin-top: 10px; }\n");
      out.write("        input, button { padding: 8px; font-size: 16px; }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("<h2>Manager Chat</h2>\n");
      out.write("\n");
      out.write("<div class=\"chat-box\">\n");
      out.write("    ");

        for(String msg : chatMessages){
            out.println("<p>" + msg + "</p>");
        }
    
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"message-form\">\n");
      out.write("    <form method=\"get\">\n");
      out.write("        <input type=\"hidden\" name=\"sender\" value=\"Manager\">\n");
      out.write("        <input type=\"text\" name=\"message\" placeholder=\"Type your reply...\" required>\n");
      out.write("        <button type=\"submit\">Send</button>\n");
      out.write("    </form>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("    const chatBox = document.querySelector('.chat-box');\n");
      out.write("    chatBox.scrollTop = chatBox.scrollHeight;\n");
      out.write("</script>\n");
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

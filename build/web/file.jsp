<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Download ZIP Files</title>
</head>
<body>
    <h2>Available ZIP Files</h2>

<%
    // Map of file names to their Google Drive download links
    java.util.Map<String, String> driveFiles = new java.util.LinkedHashMap<>();
    driveFiles.put("Sample File 1.zip", "https://drive.google.com/uc?export=download&id=DRIVE_FILE_ID_1");
    driveFiles.put("Sample File 2.zip", "https://drive.google.com/uc?export=download&id=DRIVE_FILE_ID_2");
    driveFiles.put("Sample File 3.zip", "https://drive.google.com/uc?export=download&id=DRIVE_FILE_ID_3");

    if (!driveFiles.isEmpty()) {
        out.println("<ul>");
        for (java.util.Map.Entry<String, String> entry : driveFiles.entrySet()) {
            out.println("<li><a href='" + entry.getValue() + "' target='_blank'>" + entry.getKey() + "</a></li>");
        }
        out.println("</ul>");
    } else {
        out.println("<p>No files available.</p>");
    }
%>

</body>
</html>

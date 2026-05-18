<!DOCTYPE html>
<%@ include file="clientheader.jsp" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Project Management</title>

<style> 
    /* Disable scrolling completely */
html, body {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

/* Make form fit inside viewport */
center {
    height: calc(100vh - 40px);
    overflow: hidden;
}

/* Reduce vertical spacing to fit screen */
h1 {
    margin-bottom: 15px;
    padding-bottom: 5px;
}

/* Compact rows */
.form-row {
    margin-bottom: 4px;
}

/* Compact inputs */
.form-group input,
.form-group textarea,
.form-group select {
    padding: 8px 10px;
    font-size: 13px;
}

/* Compact textarea */
textarea {
    min-height: 60px;
}

/* Form container */
center {
    width: 100%;
    max-width: 1200px;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    margin: 10px auto 20px auto;
    text-align: left;
    
}

/* Form title */
h1 {
    color: #333;
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 10px;
    border-bottom: 3px solid #007bff;
}

/* Form wrapper */
.form-container {
    max-width: 900px;
    margin: 10px;
    }

/* Row with 2 columns */
.form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 7px;
}

/* Each field */
.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
}

/* Labels */
.form-group label {
    font-size: 14px;
    color: #555;
    margin-bottom: 6px;
    font-weight: 500;
}

/* Inputs */
.form-group input,
.form-group textarea,
.form-group select {
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

/* Full-width row */
.form-group.full {
    flex: 100%;
}

/* Textarea height */
textarea {
    min-height: 80px;
}

/* Submit button */
.btn-primary {
    width: 120px;
    padding: 10px;
    margin-top: 10px;
}

</style>

</head>
<body>

<center>
    <div class="form-container" style="width:900px;max-width: none;">
        <h1>ADD REQUIREMENTS</h1>

        <form action="clientreqdb" method="POST">

            <!-- Row 1 -->
            <div class="form-row">
                <div class="form-group">
                    <label>Client Name</label>
                    <input type="text" name="cname" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>
            </div>

            <!-- Row 2 -->
            <div class="form-row">
                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" name="phono" required>
                </div>

                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="title" required>
                </div>
            </div>

            <!-- Row 3 (full width) -->
            <div class="form-row">
                <div class="form-group full">
                    <label>Requirements</label>
                    <textarea name="requirements" required></textarea>
                </div>
            </div>

            <!-- Row 4 (full width) -->
            <div class="form-row">
                <div class="form-group full">
                    <label>Description</label>
                    <textarea name="description" required></textarea>
                </div>
            </div>

            <!-- Row 5 -->
            <div class="form-row">
                <div class="form-group">
                    <label>Deadline</label>
                    <input type="date" name="deadline" required>
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select name="status">
                        <option value="pending">Pending</option>
                        <option value="rejected">Rejected</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-primary">Submit</button>
        </form>
    </div>
</center>


</body>
</html>

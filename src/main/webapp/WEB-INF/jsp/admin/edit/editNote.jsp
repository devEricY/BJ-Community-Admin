<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- include libs stylesheets -->
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- include summernote -->
<link rel="stylesheet" href="/static/admin/js/editor/summernote.min.css">
<script type="text/javascript" src="/static/admin/js/editor/summernote.min.js"></script>

<body>
<div class="summernote">${rentCont}</div>
</body>
<script type="text/javaScript">
    $(document).ready(function() {

         $('.summernote').summernote({
           height:260,
           fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Merriweather', 'Avenir', 'Avenir Light', 'Helvetica Bold', 'GothicA1-Black', 'GothicA1-Regular', 'GothicA1-Bold'],
           fontNamesIgnoreCheck: ['Merriweather', 'Avenir', 'Avenir Light', 'Helvetica Bold', 'GothicA1-Black', 'GothicA1-Regular', 'GothicA1-Bold'],
           toolbar: [
               ['style', ['bold', 'italic', 'underline', 'clear']],
               ['font', ['strikethrough', 'superscript', 'subscript']],
               ['fontname', ['fontname']],
               ['fontsize', ['fontsize']],
               ['color', ['color']],
               ['para', ['ul', 'ol', 'paragraph']],
               ['table', ['table']],
               ['height', ['height']],
               ['view', ['fullscreen', 'codeview', 'help']],
             ]
         });
    });

    function getNote(){
        var contents = $('.summernote').summernote('code');
        console.log(contents)
        return contents;
    };

</script>

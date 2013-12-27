#MY COOKBOOK#
---

##流覽器後退按鈕終止上載流意外##

I'm providing users form-based file uploads (one at a time) with ajax updates/progress bars. I want to give them a heads up if they navigate away that any current upload will be canceled. The following code achieves that goal except in Chrome (v.18). If you click the back button in Chrome the file upload stream is immediately terminated, throwing a

    org.apache.commons.fileupload.FileUploadBase$IOFileUploadException: Processing of multipart/form-data request failed. Stream ended unexpectedly

from the commons.fileupload library.

I couldn't find any information specific to this issue, but does anyone have any idea if this is something I'm just going to have to live with for now? Thanks.

Edit: I should add that Chrome does still shows the "Leave page" dialog, but at that point the upload is already stopped so the answer won't affect it at all. Clicking a link in Chrome does not stop the upload, and behaves as expected.

    window.onbeforeunload = 
    function(event) {
        if (upload_in_progress) {
            var msg = "You are uploading a file." +
              "If you leave this page the upload " +
              "will be cancelled.\n\nLeave page?";
            var event = event || window.event;
            if (event) { event.returnValue = msg; }
            return msg;
        }
    };

In Chrome and Safari functions attached to beforeunload event must always return string value (message displayed to user).

---


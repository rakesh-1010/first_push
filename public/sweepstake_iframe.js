(function() {
    var widget_link, iframe, i, widget_links;
    //widget_links = document.getElementById('sweepframe');
    widget_links = $("#sweepframe");
    var sweephref = $("#sweepframe").attr('href');
    iframe = document.createElement('iframe');
    iframe.setAttribute('src', sweephref);
    iframe.setAttribute('id','sweepstake');
    iframe.setAttribute('scrolling', 'no');
    iframe.setAttribute('frameborder', '0');
    iframe.setAttribute('style', 'width: 402px; height: 605px; margin: 0px auto; display: block;');
    //document.body.appendChild(iframe);
    $( "#sweepframe" ).replaceWith(iframe);    
    
})();
// Insert response event handling code here
if ("outage" == req.resourceName && "GET" == req.verb) {
   json.forEach(function(i){
       delete i.metadata;
   });
}

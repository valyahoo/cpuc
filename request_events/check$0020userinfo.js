// Insert request event handling code here
var keyObj = req.apiKey;
//var temp = req.apiKey.getDataObjects();
//log.debug("** The abc user data: " + temp.get("user_identifier"));
log.debug("TEST CALL GLOBAL: apiKey " + req.apiKey);
log.debug("TEST CALL GLOBAL: apiKey.logging " + keyObj.logging);
log.debug("TEST CALL GLOBAL: apiKey.data " + keyObj.data);
log.debug("TEST CALL GLOBAL: req.apiKey.getDataObjects().get(\"ID\") " + req.apiKey.getDataObjects().get("ID"));
log.debug("TEST CALL GLOBAL: req.apiKey.getDataObjects().get(\"data\") " + req.apiKey.getDataObjects().get("data"));



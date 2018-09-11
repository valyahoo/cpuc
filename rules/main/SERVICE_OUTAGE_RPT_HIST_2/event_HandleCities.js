//successful example of zipcodes:
log.debug('START INSERT ZIPCODE');
var zipCodes = row.ZIP_CODE_STR.split(',');//capture zipcode string
log.debug(zipCodes);
zipCodes.forEach(function(zip) {
  //log.debug(zip+"AS A NUMBER: "+ Number(zip)); //view captured zips. 
  var newZipCode = logicContext.createPersistentBean("main:SERVICE_OUTAGE_ZIP_CODE");//create empty row obj
  newZipCode.SERVICE_OUTAGE_RPT_HIST_KEY = row.SERVICE_OUTAGE_RPT_HIST_KEY;// set the foreign key
  newZipCode.ZIP_CODE_KEY = Number(zip);// set the zip_code, also, key is AI, this shows that null is sent for SERVICE_OUTAGE_ZIP_CODE_KEY
  logicContext.insert(newZipCode); // saves (fires logic)
});

//this rule will remain live, will ultimately occure anytime a POST or PUT occurs on svc outage.

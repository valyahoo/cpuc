if (req.verb == "PUT"){
    log.debug("OLD ROW: " + oldRow);
    log.debug("REGULAR EVENT ROW: "+row);
}

if (req.verb == "POST"){
    log.debug("INSERTING ROW TO HISTORY");
    SysLogic.insertChildFrom("main:SERVICE_OUTAGE_RPT_HIST_2", logicContext);
} else if (req.verb == "PUT" && oldRow.REPORT_STATUS_CODE != row.REPORT_STATUS_CODE){
    log.debug("INSERTING ROW TO HISTORY");
    SysLogic.insertChildFrom("main:SERVICE_OUTAGE_RPT_HIST_2", logicContext);
}

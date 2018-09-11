//Sample to call DB function to generate primary Key
var rows = logicContext.getRowsByQuery("TEST_GEN_RANDOM", 
"select get_pk from dual");//runs query to call DB function
log.debug('Found GET PK:' + rows[0].GET_PK);
row.PRIMARY_NUM=rows[0].GET_PK;//sets pk field on this row obj

var rows = logicContext.getRowsByQuery("TEST_GEN_RANDOM_CHILD", 
"select get_pk from dual");
log.debug('Found GET PK:' + rows[0].GET_PK);

row.PRIMARY_KEY_ID=rows[0].GET_PK;

if (row.CAN_BENULL === null){
return req.apiKey.getDataObjects().get("ID");
} else{
    return row.CAN_BENULL;
}

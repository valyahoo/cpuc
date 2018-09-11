var apiKeyID = req.apiKey.getDataObjects().get("ID");
var rowCompID = row.COMPANY_ID;
if (rowCompID === null){
    return apiKeyID;
} else if (rowCompID == apiKeyID){
    return rowCompID;
} else{
    return 401;
}

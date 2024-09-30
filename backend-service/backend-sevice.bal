import ballerina/http;
import ballerina/log;

service /backend on new http:Listener(9090) {

    resource function get hello(http:Caller caller, http:Request req) returns error? {
        log:printInfo("BE service Received request for /jsonPayload");

        json payload = {
            "message": "Hello, World!",
            "status": "success"
        };

        string|error gwResponseHeader = req.getHeader("GW-header");
        if gwResponseHeader is string {
            log:printInfo("GW-header: " + gwResponseHeader);
        } else {
            log:printWarn("GW-response-header not found in the request");
        }

        log:printInfo("Sending response for /jsonPayload");
        check caller->respond(payload);
    }
}
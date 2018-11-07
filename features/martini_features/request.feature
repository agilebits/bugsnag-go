Feature: Capturing request information automatically

Background:
  Given I set environment variable "API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And I configure the bugsnag endpoint
  And I set environment variable "SERVER_PORT" to "4513"

Scenario: An error report will automatically contain request information
  When I start the service "martini"
  And I wait for the app to open port "4513"
  And I wait for 2 seconds
  And I open the URL "http://localhost:4513/handled"
  Then I wait to receive 2 requests
  And the request is a valid error report with api key "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And the event "request.clientIp" is not null
  And the event "request.headers.User-Agent" equals "Ruby"
  And the event "request.httpMethod" equals "GET"
  And the event "request.url" ends with "/handled"
  And the event "request.url" starts with "http://"

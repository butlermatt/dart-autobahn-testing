# Dart Websocket Autobahn Testing

These applications will enable you to run autobahn client and server testing
against the default Dart WebSocket implementation.

This assumes that you have the Autobahn TestSuite installed already. If not
follow the instructions on the
[Autobahn Site](http://autobahn.ws/testsuite/installation.html)

## Server

1) Start the dart server:
`dart bin\wsserver.dart`

2) Point the wstest to the dart server:
`wstest -m fuzzingclient -w ws://localhost:9001`

Report will be generated in `reports/servers/index.html` from where the `wstest`
command was run.

## Client

1) Start the wstest server:
`wstest -m fuzzingserver`

2) Run the dart client:
`dart bin\wsclient.dart`

Report will be generated in `reports/clients/index.html` from where the `wstest`
command was run.
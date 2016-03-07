# SearchAcronym

A simple app with just a single screen to look up the meanings of acronyms/initialisms.
It is created using Xcode 7.2.1 and written in Objective-C.

A user -
1. Can nter an acronym or initialism
2. Is presented with a list of corresponding meanings.

All the corresponsing meanings are retrieved from the below API and populated in a TableView.

API available to get the meanings for an acronym/initialism:
  http://www.nactem.ac.uk/software/acromine/rest.html

When user enters an acronym, a request is sent dynamically (via thread) through a webservice and the corresponding meaning is retrived and populated in TableView.
Error messages are shown if no results are found for the acronym, if there's an error in connecting to the webservice or the network connection is disabled, etc.

With cocoapods below projects are added
• https://github.com/AFNetworking/AFNetworking
• https://github.com/jdg/MBProgressHUD

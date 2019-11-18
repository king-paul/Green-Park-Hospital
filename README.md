# Green-Park-Hospital
An ASP.Net website I made while studying at RMIT

# How to use

## Software Requirements
To run this website you will need to have the following tools installed on you pc
* Visual Studio (2015 or later with ASP.NET C# installed)
* Microsoft SQL Server Mangament Studio

To open the solution in visual studio open Assignment2.sln.
To view the website run this project in the web browser via visual studio using IIS Express.

## Resotring Enity Framework 6.1
This project uses a package known as 'EntityFramework.6.1.0'. To greatly reduce the file size and total number of files in the repository it has been removed but can be restored inside visual studio.
When running this project in the browser for the first time you may get a message stating that it is restoring the nuget packages.
If this is the case the solution should open after a moment while waiting for this to be restored.

## Resotring Ajax
This project also uses the package 'AjaxMin.5.11.5295.12309' which has not been included in this repository to reduce the file size and total number of files. Please install this.

## Creating the database
To create the database on your computer please create a database titled "Assignment 2 - Hospital" and run the 'hospital-database.sql' file in SQL Management Studio.

## Login Details
To Login to the website please use the following login details
Username:Paul
Password:abc123

# References
* Code in HashedData.cs from http://snipplr.com/view/70294/ and
http://blogs.msdn.com/b/csharpfaq/archive/2006/10/09/how-do-i-calculate-a-md5-hash-from-a-string_3f00_.aspx
* Ajax autocomplete tutorial from http://aspsnippets.com/Articles/AJAX-AutoCompleteExtender-Example-in-ASPNet.aspx
* Jquery credit card validator code from Collaborate chat 10 
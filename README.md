# Flat

Flat is a command line tool to flatten json and yaml structures


## Install

We can install it with Homebrew 

```
brew tap tlopo-ruby/flat
brew install flat
```


## Usage 

Flattening using the default separator ` | `: 
```
$ curl https://postman-echo.com/get  -s | flat
args = {}
headers | x-forwarded-proto = https
headers | host = postman-echo.com
headers | accept = */*
headers | user-agent = curl/7.54.0
headers | x-forwarded-port = 443
url = https://postman-echo.com/get
```

Flattening specifying `.` as separator: 

```
$ curl https://postman-echo.com/get  -s | flat -s .
args = {}
headers.x-forwarded-proto = https
headers.host = postman-echo.com
headers.accept = */*
headers.user-agent = curl/7.54.0
headers.x-forwarded-port = 443
url = https://postman-echo.com/get
```

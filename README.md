# Flat

Flat is a command line tool to flatten json and yaml structures

## Why? 

I wrote this tool a while ago when dealing with a great deal of databags for Chef which are basically json files,  I wanted look inside those files and grep for a specify path, I could not do it, I would need to flatten the structure before I could grep. 

It also helps me  a lot when writting kubernetes, helm charts and cloudformation files. 

## Install

We can install it with Homebrew 

```
brew tap tlopo-ruby/flat
brew install flat
```

Or as standalone executable script: 
```
curl -sL https://raw.githubusercontent.com/tlopo-ruby/flat/master/flat.rb > /usr/local/bin/flat
chmod +x /usr/local/bin/flat
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

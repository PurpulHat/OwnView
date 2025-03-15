<h1 align="center"> OwnView </h1>

<p align="center">
    <img alt="OwnView" title="OwnView" src="https://i.imgur.com/eqnxR6J.png" width="500">
</p>

<p align="center">
  <b>Create your Own OSINT automatisation<br> with fully customisables templates and graphicals Views</b>
</p>

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Usages](#usage)
- [Configuration](#configuration)
- [Acknowledgments](#acknowledgments)

## Introduction

Take all your favorite APIs and do your searches automatically, simply by adding your API to your `config.yml` file, and running this program, you'll have your own view of your API results with a graphical network.

**Example of what OwnView can give you.**

<p align="center">
  <img src = "https://i.imgur.com/WnBDREi.png">
</p>

## Features

A few of the things you can do with OwnView:

* Automate your investigations
* Create multiple automation groups and choose which group to use
* GET and POST APIs are accepted
* Get a graphical view by API result
* Get a JSON result in your shell, if you request it

## Usage

You simply need to run `python3 OwnView.py`, after which you need to choose the group you want to run. Don't forget to create your own group first!

```markdown
 ██████╗ ██╗    ██╗███╗   ██╗    ██╗   ██╗██╗███████╗██╗    ██╗    
██╔═══██╗██║    ██║████╗  ██║    ██║   ██║██║██╔════╝██║    ██║    
██║   ██║██║ █╗ ██║██╔██╗ ██║    ██║   ██║██║█████╗  ██║ █╗ ██║    
██║   ██║██║███╗██║██║╚██╗██║    ╚██╗ ██╔╝██║██╔══╝  ██║███╗██║    
╚██████╔╝╚███╔███╔╝██║ ╚████║     ╚████╔╝ ██║███████╗╚███╔███╔╝    
 ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝      ╚═══╝  ╚═╝╚══════╝ ╚══╝╚══╝     
                                                     @PurpulHat
[Enumeration of groups in your config.yml]
[0] : CustomGroup
[1] : Scan My URL

[?] What group to use : 1
[?] Your input        : Enter Your Search Here
```

Once complete, a graphical view will be displayed in your default browser, and an .html report will be saved in the same folder as OwnView.

## Configuration
Your config.yml can look like this
```yml
CustomGroup:
  MyAPI_POST:
    - type: api
      method: POST
      url: https://example.com/FUZZ?token=ABC
      headers: 
        - api-key: ABC
          Content-Type: application/json
          Other-Headers: other
      body:
        - entry: FUZZ
          OtherEntry: ABC
      output:
        - shell: True
          graph: True
              
  MyAPI_GET:
    - type: api
      method: GET
      url: https:/your.api/token=ABC
      headers: 
        - api-key: ABC
          Content-Type: application/json
          Other-Headers: other
      output:
        - shell: True
          graph: True
```

`CustomGroup`: Name of your group. You can use whatever you like, including spaces.

`MyAPI_POST`: Name of your API. You can use whatever you like
`type`: For the moment, don't change it. It should remain `API`
`method`: HTTP method of your `GET` / `POST` API.

`url`: URL of your API.

[⚠️] Warning! Put the world `FUZZ` if you need to enter input in your URL.

- For example, if you use your API like this: myownapi.com/search=google.com

- Please write in your URL: myownapi.com/search=FUZZ

`headers`: Enter all the headers you need.

[⚠️] Warning! Put the `-` character ONLY on the first line, and put `FUZZ` in the same way as in `url` if necessary. Example:
```yml
headers:
  - api-key: FUZZ
    Content-Type: application/json
    Other-Headers: other

# If you dont need it, write :
headers: None
```

`body` : In the same way as `headers`
```yml
- entry: FUZZ
  OtherEntry: ABC
```

`output`

If you want the API result in your shell, enter `True` in `shell`

If you want the graphical view result, enter `True` in `graph`

## Acknowledgements

Thank you for knowing that OwnView is still in Beta.

CC-BY-NC (Attribution & No Commercial)
 <img alt="OwnView" title="OwnView" src="https://upload.wikimedia.org/wikipedia/commons/1/11/Cc-by_new_white.svg?uselang=fr" width="50"> <img alt="OwnView" title="OwnView" src="https://upload.wikimedia.org/wikipedia/commons/2/2f/Cc-nc_white.svg?uselang=fr" width="50">

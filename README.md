![OwnView](https://github.com/user-attachments/assets/90fa18f3-8e37-43b1-b807-9504584f8d56)
<p align="center">
  <b>Create your own OSINT recursively with the information found by your APIs, with a graphical view.</b>
</p>

<hr>

</p>

<br>

**OwnView is a modern, modular OSINT tool capable of recursively scanning any information through all your APIs. Thanks to its intuitive design, you can carry out any kind of investigation**.
- 100% free and open-source
- Add any API without limit
- Perform recursive searches

<br>

## Table of Contents

- [**`Get Started`**](#get-started)
- [**`Documentation`**](#documentation)
  - [_`Add your API`_](#add-your-api)
- [**`License`**](#license)

<br>

## Get Started
Install OwnView on your Windows or Linux computer and run `OwnView.exe`, or `OwnView.x86_64` if you're running Linux.
> [!Important]
> |**This project is in the beta development phase**. Please, expect breaking changes with releases, and don't hesitate to review the release changelog before updating.|
> |:--------------------------------|

### Linux
If you can't run OwnView, allow it to be executable.
```bash
$ chmod +x ./OwnView.x86_64
```

<br>

## Documentation

### Add your API
<p align="center">
 <img src="https://github.com/user-attachments/assets/8aee3d49-ea36-423a-81ce-d1773aacbbff" alt="OwnView_Screenshot" style="border-radius: 50px; width: 1000px; align=center" />
<p align="center">


Simply click on “Add Request” and you're ready to add your API.
Please note that you must enter the HTTP method (POST or GET only) to save your configuration.
Each configuration will be stored in the OwnView folder in the “Input Saved” folder.

> [!Important]
> |You need to replace your input by **FUZZ** !|
> |:--------------------------------|

<br>

<p align="center">
 <img src="https://github.com/user-attachments/assets/e99d4a38-d6be-470e-9a14-da59275d0487" alt="OwnView_Screenshot" style="border-radius: 50px; width: 600px; align=center" />
<p align="center">

“FUZZ” will automatically be replaced by your entry within the OwnView node created.
If you perform a search with an OwnView node, by calling the entry point “example@gmail.com”, FUZZ will be replaced by this e-mail in your API request.

## License

CC-BY-NC (Attribution & No Commercial)
<br>
<img alt="OwnView" title="OwnView" src="https://upload.wikimedia.org/wikipedia/commons/1/11/Cc-by_new_white.svg?uselang=fr" width="50"> <img alt="OwnView" title="OwnView" src="https://upload.wikimedia.org/wikipedia/commons/2/2f/Cc-nc_white.svg?uselang=fr" width="50">

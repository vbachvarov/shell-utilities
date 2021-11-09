# shell-utilities
A collection of shell scripts I use to automate my tasks.

## License
This software is distributed under the [Creative Commons Zero License](https://github.com/vbachvarov/shell-utilities/blob/main/LICENSE). By using it you consent to the terms and conditions in the latter license.

## generate-playlist.sh
Generates an M3U playlist file by scanning a specified directory for files.
### System requirements
* bash, sed, awk
* Unix OS (running under cygwin/MinGW on Windows has not been tested but should work in theory)
### Installation
Copy [the script](https://github.com/vbachvarov/shell-utilities/blob/main/generate-playlist.sh) anywhere on your path (for example in /bin) and set executable permissions (755).
### Usage
```
generate-playlist.sh [DIRECTORY] [PLAYLIST]
       DIRECTORY - optional, default is "." (the current directory)
       PLAYLIST  - optional, if omitted, a timestamped filename will be generated
```
The program will ask for confirmation before scanning the directory. You can execute it without the pause like so:
```
echo y | generate-playlist.sh
```

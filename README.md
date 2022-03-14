# Installing Ruby Curses
[Ruby curses](https://github.com/ruby/curses) is a binding to the [C library curses](https://en.wikipedia.org/wiki/Curses_(programming_library)). You will need to install the specific version of curses for your OS
before downloading and running the program.

####  For Linux
If you're using a Debian based distribution (Ubuntu, Mint, ...) you can run the following command:

`apt install libncurses5-dev`

#### For OSX
The version of curses that comes installed by default does not incude
several features that are required to run this program. To work around this do the following:

use homebrew to install curses: `brew install curses`
then buid the gem: `gem install curses -- --with-ncurses-dir=$(brew --prefix ncurses)`

#### For Windows
Ruby curses packages a version of PDCurses, so you don't need to install extra libraries. However, if you prefer
ncurses to PDCurses, specify the following option: `gem install curses -- --use-system-libraries`

# Downloading, Testing, And Running Program
- Install curses using instructions above
- Clone the directory: `cd <target-directory>; git clone <link_to_repo>`
- Install dependencies: `bundle install`
- Run specs: `rspec spec/`
- Run program optionally providing the map you want to use: `ruby draw.rb <map-file-path>`

# Debugging
Curses gets in the way of REPLs like pry so instead include the logging module and use logger.info or something similar
to get debugging info. The default log file is "maze.log".

# Playing The Game
The goal of the game is to move the player from the beginning tile to the goal tile in as few moves as possible. All
input is from the keyboard:

Movement:
`h` - left
`j` - up
`k` - down
`l` - right

Game Control:
`q` - quit the game

# Building Custom Maps
Maps are simply text files made up of characters that represent the game tiles. Currently there are four characters that
are used to make maps.

`\*` = Ground - Enterable tile representing open space
`\#` = Wall   - Unenterable tile representing a solid wall
`~`  = Water  - Unenterable tile, for now
`$`  = Goal   - When this tile is entered, the player completes the level and final score is calculated

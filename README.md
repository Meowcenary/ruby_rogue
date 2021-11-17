# Installing Ruby Curses For Linux
TBD

# Installing Ruby Curses For OSX
Ruby curses is a binding to the [C library curses](https://en.wikipedia.org/wiki/Curses_(programming_library)). The version of curses that comes installed by default does not incude
several features that are required to run this program. To work around this do the following:

use homebrew to install curses: `brew install curses`
then buid the gem: `gem install curses -- --with-ncurses-dir=$(brew --prefix ncurses)`

# Installing Ruby Curses For Windows
TBD

# Installing, Testing, And Running Program
- Install curses using instructions above
- Clone the directory: `cd <target-directory>; git clone <link_to_repo>`
- Install dependencies: `bundle install`
- Run specs: `rspec spec/`
- Run program: `ruby draw.rb`

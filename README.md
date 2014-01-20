homebrew-muttpatched
====================

A [homebrew](http://brew.sh) [tap](https://github.com/Homebrew/homebrew/wiki/brew-tap) containing a formula for the [mutt](http://mutt.org) email client. I wanted to apply more patches than those that are ([apparently temporarily](https://github.com/Homebrew/homebrew/pull/23662)) available with the brew's official formula. There are two more at the moment:
  
  * [Sidebar patch](https://github.com/nedos/mutt-sidebar-patch) Adds a sidebar with folder list.
  * [X-Label patch](https://github.com/gi1242/mutt): Adds an `edit-label` function, which allows for a direct editing of the `X-Label` header.
  
### How to use this thing

  1. Tap the tap: `brew tap flabbergast/muttpatched`
  2. Brew mutt: `brew install mutt-patched --with-whatever-patch`

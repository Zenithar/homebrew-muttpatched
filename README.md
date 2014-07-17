homebrew-muttpatched
====================

A [homebrew](http://brew.sh) [tap](https://github.com/Homebrew/homebrew/wiki/brew-tap) containing a formula for the [mutt](http://mutt.org) email client. I wanted to apply more patches than those that are ([apparently temporarily](https://github.com/Homebrew/homebrew/pull/23662)) available with the brew's official formula. There are these at the moment:
  
  * `--with-sidebar-patch` [Sidebar patch](https://github.com/nedos/mutt-sidebar-patch): Adds a sidebar with folder list.
  * `--with-xlabel-patch` [X-Label patch](https://github.com/gi1242/mutt): Adds an `edit-label` function, which allows for a direct editing of the `X-Label` header.
  * `--with-trash-patch` Adds reasonable support for a trash folder (`delete-message` function moves the message to a designated folder).
  * `--with-date-conditional-patch` Formating dates in the index will vary depending on the message age [link](http://www.schrab.com/aaron/mutt/).
  * `--with-ignore-thread-patch` Permanently ignore threads.
  * `--with-confirm-attachment-patch` Abort composing messages with no attachment containing given keywords.
  * `--with-pgp-confirm-crypt-hook-patch` Allows for skipping the "Use keyID" prompt.
  * `--with-pgp-combined-crypt-hook-patch` Multiple crypt-hooks with the same pattern, multiple keyIDs per pattern.
  * `--with-pgp-verbose-mime-patch` (This one remained from the original mutt formula. I actually don't know what does it do.)

Note that not all the patches can be applied simultaneously, automatic patching won't always figure out what to do.

A non-exhaustive and not very current list of mutt patches is [here](http://dev.mutt.org/trac/wiki/PatchList).

### How to use this thing

  1. Tap the tap: `brew tap flabbergast/muttpatched`
  2. Brew mutt: `brew install mutt-patched --with-whatever-patch`

## More Formulas

Since I don't really want to maintain an extra repository for every
small formula I need, I'm including them in this tap. At the moment,
there's only

  *  [passwdqc](http://www.openwall.com/passwdqc/) ignoring the pam
     module, I use it to generate random, long passphrases that are not
     too difficult to remember. E.g. 'lunch!duel$audio'.


Puppet dotfiles
===============

Version: **1.0.1**

Copies my dotfiles to the $HOME of the current user

Parameters
----------

[`user`]
    The user that will own own the checkout directory. This assumes that
    they will exist in `~<user>/dotfiles`.

[`source`]
    The source where to check out from. Currently only git http repositories
    are allowed.


Examples
--------

    class {"dotfiles":
        user   => "alice",
        source => "alice@git.example.invalid:dotfiles.git",
    }

Authors
-------

Martin Marcher <martin@marcher.name>

Copyright
---------

Copyright 2011 Martin (serverhorror) Marcher, unless otherwise noted.


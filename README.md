# portage-bashrc-mv

(C) Martin Väth <martin@mvath.de>
The license of this project is the GNU Public License GPL-2.

The portage-bashrc-mv project is meant to be used with the
gentoo portage system and serves two purposes.

1. It provides support for an ```/etc/portage/bashrc.d``` directory in which
   you can define functions which are executed during emerge phases.
2. It provides the following functionality in ```/etc/portage/bashrc.d```
   - Support for an ```/etc/portage/package.cflags``` file (or directory)
     in which you can easily execute tasks or modify variables like CFLAGS
     on a per-package basis.
     This is similar to using ```/etc/portage/env``` but has a more
     convenient syntax for e.g. modifying ```CFLAGS```.
     There is also a special flag filtering for non-GNU compilers
     (mainly clang).
     Moreover, pgo (profile-guided optimization) is supported.
   - Support for removing undesired ```.la``` files before installation
   - Support for removing undesired locales before installation
     (similar to ```app-admin/localepurge```, but before installation).
   - Support for ```CCACHE_*``` variables.
   - Output of time information and title bar if
     ```app-portage/portage-utils```and ```app-shells/runtitle```
     (the latter from the mv overlay) are installed.

See ```bashrc.d/README``` for more details.

For installation, just copy ```bashrc``` and ```bashrc.d``` into
```/etc/portage```.
There is also an ebuild in the ```mv``` repository
(available by ```app-select/eselect-repository``` or ```app-portage/layman```).

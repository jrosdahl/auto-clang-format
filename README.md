auto-clang-format
=================

`auto-clang-format` is an Emacs package that defines a minor mode
(`auto-clang-format-mode`) that runs `clang-format-buffer` before the buffer is
saved to its file. Exception: `clang-format-buffer` will not be run if a style
hasn't been selected, i.e. if there is no ".clang-format" file in the directory
tree and `clang-format-style` hasn't been set to an explicit style. If the
minor mode will call `clang-format-buffer` the mode line will include the
indicator "ACF", otherwise "!ACF".


Installation
------------

`auto-clang-format` depends on the [clang-format] package.

To load and enable `auto-clang-format-mode` unconditionally, put something like
this in your Emacs configuration:

```elisp
(require 'auto-clang-format)
(add-hook 'c++-mode-hook 'auto-clang-format-mode)
```

[clang-format]: https://melpa.org/#/clang-format

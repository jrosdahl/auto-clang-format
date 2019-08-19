auto-clang-format
=================

`auto-clang-format` is an Emacs package that defines a minor mode
(`auto-clang-format-mode`) that runs `clang-format-buffer` before the buffer is
saved to its file.


Installation
------------

`auto-clang-format` depends on the [clang-format] package.

To load and enable `auto-clang-format-mode` unconditionally, put something like
this in your Emacs configuration:

```elisp
(require 'auto-clang-format)
(add-hook 'c++-mode-hook 'auto-clang-format-mode)
```

Note that if there is no ".clang-format" file in the directory tree and you
haven't set `clang-format-style` to a style then `clang-format-buffer` will
happily format your code using the default clang-format style, which maybe
isn't what you want. If so, you can use
`auto-clang-format-enable-if-appropriate` instead:

```elisp
(require 'auto-clang-format)
(add-hook 'c++-mode-hook #'auto-clang-format-enable-if-appropriate)
```

`auto-clang-format-enable-if-appropriate` enables `auto-clang-format-mode` if
there is a ".clang-format"" file in the directory tree or if
`clang-format-style` is set to something else than "file".

[clang-format]: https://melpa.org/#/clang-format

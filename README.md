auto-clang-format-mode
======================

`auto-clang-format-mode` is a minor mode that runs `clang-format-buffer` before
the buffer is saved to its file.


Installation
------------

`auto-clang-format-mode` depends on the [`clang-format`] package.

To load and enable `auto-clang-format-mode`, put something like this in your
Emacs configuration:

```elisp
(require 'auto-clang-format-mode)
(add-hook 'c++-mode-hook 'auto-clang-format-mode)
```


Configuration
-------------

* `auto-clang-format-mode-enable-p-function` (default:
  `auto-clang-format-mode-default-enable-p`)

  A function that should return non-`nil` if `clang-format-buffer` should be
  called when the mode is active, otherwise `nil`. The default function makes
  sure that `clang-format-buffer` is not called if `clang-format-style` is
  `'file` (which is the default) but no `.clang-format` file is present.


[clang-format]: https://melpa.org/#/clang-format

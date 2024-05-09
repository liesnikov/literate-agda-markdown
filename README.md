# Literate Agda Markdown filter

A very simple [pandoc filter](https://pandoc.org/filters.html) to tranlate literate Agda markdown files to literate Agda TeX files.

This enables the pipeline: literate markdown -> literate tex -> pdf with highighting.
Which might be possible to do somehow with pure Agda but I couldn't find it immediately.

## Syntax example

Everything but `agda` codeblocks is left as is.

```agda {.hide}
module README where
```

gets translated to

```latex
\begin{code}[hide]
...
\end{code}
```

which will be typechecked by agda, but not visible in the final pdf.


```agda
data Nat : Set where
    zero : Nat
    suc  : Nat → Nat
```

will be tranlated to

```latex
\begin{code}
...
\end{code}
```

which will be visible.

## Usage example

1. `pandoc --from markdown --to latex -s input.lagda.md -o input.lagda.tex`
2. `agda --latex input.lagda.tex`
3. `pdflatex input.tex`


## TODOs and notes

* `{.hide}` attributes break agda-mode and code blocks which aren't annotated get checked by agda too
* adding an lhs filter would be good too

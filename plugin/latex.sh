#!/usr/bin/env bash

mktex()
{
  if [[ $# -eq 1 ]] && ! [[ $1 == 'bib' ]]
  then
    if [[ $1 == 'clean' ]]
    then
      bash -c "rm -f *.aux *.bbl *.blg *.log *.out *.idx *.ilg *.ind *.toc *.d"
    elif  [[ $1 == 'veryclean' ]]
    then
      rm -f *.aux *.bbl *.blg *.log *.out *.idx *.ilg *.ind *.toc *.d *.pdf
    else
      local pdflatex_cmd="xelatex -file-line-error -halt-on-error $1"
      ${SHELL} -c "${pdflatex_cmd} && bibtex *.aux && ${pdflatex_cmd} 2>/dev/null"
    fi
  else
    # shellcheck disable=SC2162
    # - SC2162 : read without -r will mangle backslashes
    grep -lFm 1 'begin{document}' -- *.tex | while read f
    do
      local pdflatex_cmd="xelatex -file-line-error -halt-on-error '$f'"
      if [[ $# -eq 1 ]] && [[ $1 == 'bib' ]]
      then
        ${SHELL} -c "${pdflatex_cmd} && bibtex *.aux && ${pdflatex_cmd} 2>/dev/null"
      else
        ${SHELL} -c "${pdflatex_cmd} && ${pdflatex_cmd} 2>/dev/null"
      fi
    done
  fi
}

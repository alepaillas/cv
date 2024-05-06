# cv
Curriculum vitae made with Org mode and Latex templating.

## Export to pdf
To export to pdf just run `./export-pdf.sh`. It will
watch for changes to your `.org` files and will convert them first to
latex with pandoc and then to pdf with pdflatex.

## Document Formatting
To change the document formatting just edit the `sidebar_template.tex` directly.
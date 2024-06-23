#!/bin/bash

cd ./cover-letter/desarrollador-full-stack
output_file="paillas-carta-presentacion-desarrollador-full-stack.pdf"

# Define file paths (adjust as needed)
main_content_file="main.org"
template_file="main_template.tex"

# Function to convert Org files to Latex
function org_to_latex() {
  pandoc "$1" -o "${1%.*}.tex"
}

# Function to compile and generate PDF
function compile_pdf() {
  # Convert Org files to Latex before compilation
  org_to_latex "$main_content_file"
  pdflatex "$template_file"
  # Remove .tex extension from template filename and store in temp variable
  temp_filename=$(echo "$template_file" | sed 's/\.tex$//')
  # Move generated PDF to output filename
  mv "$temp_filename.pdf" "$output_file"
}

compile_pdf

# Watch for file changes using inotifywait
while true; do
  inotifywait -e modify,create "$main_content_file" "$template_file"
  echo "File changes detected, rebuilding PDF..."
  compile_pdf
  echo "PDF generation complete."
done


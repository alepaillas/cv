#!/bin/bash

cd ./desarrollador-full-stack
output_file="paillas-cv-desarrollador-full-stack.pdf"
#cd ./desarrollador-front-end
#output_file="paillas-cv-desarrollador-front-end.pdf"
#cd ./diseñadora-web
#output_file="paillas-cv-diseñadora-web.pdf"

# Define file paths (adjust as needed)
main_content_file="main.org"
sidebar_content_file="sidebar.org"
title_content_file="title.org"
template_file="sidebar_template.tex"

# Function to convert Org files to Latex
function org_to_latex() {
  pandoc "$1" -o "${1%.*}.tex"
}

# Function to compile and generate PDF
function compile_pdf() {
  # Convert Org files to Latex before compilation
  org_to_latex "$main_content_file"
  org_to_latex "$sidebar_content_file"
  org_to_latex "$title_content_file"
  #pandoc "${main_content_file%.*}.tex" "${sidebar_content_file%.*}.tex" -o "$output_file" \
      #       --latex --variable class="$class_file"
  pdflatex "$template_file"
  # Remove .tex extension from template filename and store in temp variable
  temp_filename=$(echo "$template_file" | sed 's/\.tex$//')
  # Move generated PDF to output filename
  mv "$temp_filename.pdf" "$output_file"
}

compile_pdf

# Watch for file changes using inotifywait
while true; do
  inotifywait -e modify,create "$main_content_file" "$sidebar_content_file" "$title_content_file" "$template_file"
  echo "File changes detected, rebuilding PDF..."
  compile_pdf
  echo "PDF generation complete."
done


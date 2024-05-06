#!/bin/bash

# Define file paths (adjust as needed)
main_content_file="main.org"
sidebar_content_file="sidebar.org"
title_content_file="title.org"
output_file="output.pdf"
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
}

# Watch for file changes using inotifywait
while true; do
  inotifywait -e modify,create "$main_content_file" "$sidebar_content_file" "$title_content_file" "$template_file"
  echo "File changes detected, rebuilding PDF..."
  compile_pdf
  echo "PDF generation complete."
done


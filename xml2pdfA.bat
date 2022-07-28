SETLOCAL ENABLEDELAYEDEXPANSION
@echo off
set exec_path=%~dp0

if [%1]==[] goto :eof
:LOOP
	if exist %~1 (
		set xml_file=%~1
		set xslt_file=%~dp1edocument.xslt
		set html_file=%~dpn1.html
		set pdf_file=%~dpn1_pdf.pdf
		set pdf_a1_file=%~dpn1.pdf

		"%exec_path%"xml2pdfA\xsltproc\xsltproc.exe -o "!html_file!" "!xslt_file!" "!xml_file!"
		"%exec_path%"xml2pdfA\wkhtmltopdf\bin\wkhtmltopdf --encoding utf8 "!html_file!" "!pdf_file!"  
		"%exec_path%"xml2pdfA\gs\gs9.56.1\bin\gswin64c -dPDFA=1 -dBATCH -dNOPAUSE  -sProcessColorModel=DeviceCMYK  -sColorConversionStrategy=UseDeviceIndependentColor -sDEVICE=pdfwrite -dPDFACompatibilityPolicy=1 -sOutputFile="!pdf_a1_file!" "!pdf_file!"

		del "!html_file!"
		del "!pdf_file!"
	)
shift
if not [%1]==[] goto loop
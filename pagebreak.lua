function pagebreak()
 
  local raw = {
    epub = '<p style="page-break-after: always;"> </p>',
    html = '<div style="page-break-after: always;"></div>',
    latex = '\\newpage{}',
    ooxml = '<w:p><w:r><w:br w:type="page"/></w:r></w:p>',
    odt = '<text:p text:style-name="Pagebreak"/>',
    context = '\\page'
  }
  if quarto.doc.isFormat('docx') then
    return pandoc.RawBlock('openxml', raw.ooxml)
  elseif quarto.doc.isFormat('pdf')  then
    return pandoc.RawBlock('tex', raw.latex)
  elseif quarto.doc.isFormat('odt')  then
    return pandoc.RawBlock('opendocument', raw.odt)
  elseif quarto.doc.isFormat('epub') then
    return pandoc.RawBlock('html', raw.epub)
  elseif quarto.doc.isFormat('html') then
    return pandoc.RawBlock('html', raw.html)
  elseif quarto.doc.isFormat('context') then
    return pandoc.RawBlock('context', raw.context)
  else
    -- fall back to insert a form feed character
    return pandoc.Para{pandoc.Str '\f'}
  end
end
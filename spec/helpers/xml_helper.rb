module XMLHelper
  def load_xml_document(path)
    doc = File.open(path) { |f| Nokogiri::XML(f) }
    doc.remove_namespaces!
    doc
  end
end
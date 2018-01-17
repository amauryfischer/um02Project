require 'nokogiri'
require 'byebug'
require 'json'

puts "start"

file = File.open("communes-France-2016.gexf")
gexf = file.read
file.close

doc = Nokogiri::XML(gexf)
city_extractor = doc.css("node")
extracted_city = {}

city_extractor.each do |city_node|
  city_name = city_node.children[1].children[1].attributes["value"].value
  city_id = city_node.attributes["id"].value
  extracted_city[city_id] = city_name
end

file = File.open("extracted_id_cityname.json","wb")
file.write(extracted_city.to_json)
file.close

file = File.open("extracted_cityname_id.json","wb")
file.write(extracted_city.to_a.reverse.to_h.to_json)
file.close

extracted_node = {}

node_extractor = doc.css("edge")
node_extractor.each do |node_line|
  source = node_line.attributes["source"].value
  target = node_line.attributes["target"].value
  extracted_node[source] = [] if extracted_node[source].nil?
  extracted_node[source].push target
end

file = File.open("extracted_source_target_neighboor.json","wb")
file.write(extracted_node.to_json)
file.close

puts "end"

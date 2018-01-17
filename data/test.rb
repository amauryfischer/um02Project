require('json')
require('byebug')
file = File.open("/home/amauey/um02Project/data/extracted_cityname_id.json")
city_name = JSON.parse file.read
file.close

file = File.open("/home/amauey/um02Project/data/extracted_source_target_neighboor.json")
neightboor = JSON.parse file.read
file.close

byebug
1+1

require('json')
require('byebug')

file = File.open("communes-20160119.json")
output = JSON.parse file.read
file.close

byebug

file = File.open("lille.json","wb")
file.write city
file.close
byebug
1+1

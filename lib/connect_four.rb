module ConnectFour
end

lib_path = File.expand_path(File.dirname(__FILE__))
Dir[lib_path + "/connect_four/**/*.rb"].each { |file| require file }

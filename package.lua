-- for older versions of luvit and alternative package managers
return {
	name = "luvit-utopia",
	version = "0.0.5",
	description = "High performance middleware framework for Luvit.io",
	repository = {
		url = "http://github.com/luvitrocks/luvit-utopia.git",
	},
	author = {
		name = "Dmitri Voronianski",
		email = "dmitri.voronianski@gmail.com"
	},
	licenses = {"MIT"},
	devDependencies = {
		"luvit-test",
	},
	main = 'init.lua'
}

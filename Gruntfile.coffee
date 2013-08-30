module.exports = (grunt) ->

  grunt.initConfig
    coffeelint:
      app: ['app/**/*.coffee', 'cofnig/**/*.coffee']

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.registerTask 'default', ['coffeelint']

  return

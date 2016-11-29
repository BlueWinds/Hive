files = require('./src/loadOrder').map (f)->('src/' + f)

module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-compress'

  config = {
    coffee:
      nsfw:
        files: 'public/game/compiled.js': files
    coffeelint:
      app: ['src/**/*.coffee']
      options:
        colon_asignment_spacing: {level: 'error', left: 0, right: 1}
        cyclomatic_complexity: {level: 'error'}
        eol_last: {level: 'error'}
        line_endings: {level: 'error', value: 'unix'}
        max_line_length: {level: 'ignore'}
        no_empty_functions: {level: 'error'}
        no_empty_param_list: {level: 'error'}
        no_interpolation_in_single_quotes: {level: 'error'}
        no_standalone_at: {level: 'error'}
        no_this: {level: 'error'}
        prefer_english_operator: {level: 'error'}
        space_operators: {level: 'error'}
        spacing_after_comma: {level: 'error'}
    copy:
      libs:
        files: [{
          cwd: 'src/lib/fonts'
          expand: true
          src: ['**']
          dest: 'public/game/engine/fonts'
        },
        {
          cwd: 'src/lib'
          expand: true
          src: ['*.css']
          dest: 'public/game/engine'
        }]
      static:
        files:
          'public/index.html': ['src/index.html']
          'public/game/CC-by-nc-sa-4.0.txt': ['src/content/CC-by-nc-sa-4.0.txt']
          'public/game/GPL.txt': ['src/engine/GPL.txt']
          'public/Credits.txt': ['src/Credits.txt']
          'public/README.txt': ['src/README.txt']
          'public/game/engine/style.css': ['src/engine/style.css']
    resize:
      images:
        options:
          maxWidth: 1280
          maxHeight: 1280
          quality: 90
        cwd: 'src/images'
        expand: true
        src: ['**/*.jpg', '**/*.png']
        dest: 'public/game/images'
    uglify:
      options:
        mangle: false
      libs:
        files:
          'public/game/engine/lib.js': ['src/lib/*.js']
    watch:
      compile:
        files: ['src/**/*']
        tasks: ['compile']
    clean:
      game: ['public', 'Hive.zip']
    compress:
      nsfw:
        options:
          archive: './Hive.zip'
        src: ['**/*']
        cwd: 'public'
        expand: true
  }
  grunt.initConfig config

  require('./tasks/dump')(grunt)
  require('./tasks/resize')(grunt)

  grunt.registerTask 'compile', ['coffee', 'copy:static']
  grunt.registerTask 'lib', ['uglify', 'copy:libs', 'resize']
  grunt.registerTask 'full-compile', ['lib', 'coffeelint', 'compile', 'dump']
  grunt.registerTask 'full-build', ['clean', 'full-compile', 'compress']
  grunt.registerTask 'default', ['lib', 'coffeelint', 'compile', 'watch:compile']

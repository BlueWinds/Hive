path = require 'path'
async = require 'async'
gm = require('gm').subClass {imageMagick: true}

module.exports = (grunt)->
  grunt.registerMultiTask 'resize', 'Resize images to a max width, height and jpg quality.', ->
    done = this.async()
    options = this.options()

    resizeFile = (file, next)->
      grunt.file.mkdir(path.dirname(file.dest))
      gm(file.src[0])
      .resize(options.maxWidth, options.maxHeight, '>')
      .quality(options.quality)
      .write(file.dest.replace('.png', '.jpg'), next)

    # Iterate through the lists of files, resizing each one.
    async.each(this.files, resizeFile, done)

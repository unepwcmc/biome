'use strict';

var gulp = require('gulp'),
    browserify = require('browserify'),
    source = require('vinyl-source-stream'),
    buffer = require('vinyl-buffer'),
    gutil = require('gulp-util'),
    coffeeify = require('coffeeify'),
    sass = require('gulp-sass'),
    sourcemaps = require('gulp-sourcemaps'),
    handlebars_transform = require('browserify-handlebars');

// add custom browserify options here
var paths = {
  coffee: './src/coffee/**/*',
  sass: './src/sass/**/*',
  coffee_entry: './src/coffee/index.coffee',
  js: './dist/js/',
  css: './dist/css/'
};


gulp.task('coffee', function () {
  var b = browserify({
    entries: paths.coffee_entry,
    debug: true,
    transform: [coffeeify, handlebars_transform]
  });

  return b.bundle()
    .on('error', gutil.log.bind(gutil, 'Browserify Error'))
    .pipe(source('index.js'))
    .pipe(buffer())
    .pipe(gulp.dest(paths.js));
});

gulp.task('sass', function () {
  gulp.src(paths.sass)
    .pipe(sourcemaps.init())
    .pipe(sass().on('error', sass.logError))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(paths.css));
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.sass, ['sass']);
});

gulp.task('default', ['watch', 'coffee', 'sass']);

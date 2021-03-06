'use strict';

var gulp = require('gulp'),
    browserify = require('browserify'),
    source = require('vinyl-source-stream'),
    buffer = require('vinyl-buffer'),
    gutil = require('gulp-util'),
    coffeeify = require('coffeeify'),
    sass = require('gulp-sass'),
    sourcemaps = require('gulp-sourcemaps'),
    coffeelint = require('gulp-coffeelint'),
    handlebars_transform = require('browserify-handlebars');

// add custom browserify options here
var paths = {
  // src
  coffee: './www/src/coffee/**/*.coffee',
  coffee_entry: './www/src/coffee/index.coffee',
  coffee_and_hbs: './www/src/coffee/**/*',
  sass: './www/src/sass/**/*',
  fonts_src: './www/src/fonts/**/*',
  images_src: './www/src/img/**/*',

  // dist
  js: './www/dist/js/',
  css: './www/dist/css/',
  fonts_dist: './www/dist/fonts/',
  images_dist: './www/dist/img/',

  // extra
  coffeelint: './coffeelint.json'
};


function handleError(err) {
  gutil.log(err, 'Browserify Error');
  this.emit('end');
};

gulp.task('coffee', function () {
  var b = browserify({
    entries: paths.coffee_entry,
    debug: true,
    transform: [coffeeify, handlebars_transform]
  });

  return b.bundle()
    .on('error', handleError)
    .pipe(source('index.js'))
    .pipe(buffer())
    .pipe(gulp.dest(paths.js));
});


gulp.task('lint', function () {
  return gulp.src(paths.coffee)
    .pipe(coffeelint(paths.coffeelint))
    .pipe(coffeelint.reporter())
});

gulp.task('fonts', function() {
  gulp.src(paths.fonts_src)
    .pipe(gulp.dest(paths.fonts_dist));
});

gulp.task('images', function() {
  gulp.src(paths.images_src)
    .pipe(gulp.dest(paths.images_dist));
});

gulp.task('sass', function () {
  gulp.src(paths.sass)
    .pipe(sourcemaps.init())
    .pipe(sass().on('error', sass.logError))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(paths.css));
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee_and_hbs, ['coffee']);
  gulp.watch(paths.coffee, ['lint']);
  gulp.watch(paths.sass, ['sass']);
  gulp.watch(paths.fonts_src, ['fonts']);
});

gulp.task('default', ['watch', 'lint', 'coffee', 'sass', 'fonts', 'images']);

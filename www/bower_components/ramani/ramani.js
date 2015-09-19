window.Ramani = {
  baseUrl: 'http://ramani.ujuizi.com/ddl/wms',

  tileLayer: function tileLayer(layerID, next) {
    this.getMetadata(layerID, function(res) {
      var layer = L.tileLayer.wms("http://{s}.ramani.ujuizi.com/ddl/wms", {
        subdomains: 'ab',
        layers: layerID,
        format: 'image/png',
        style: res.supportedStyles[0] + '/' + res.defaultPalette,
        styles: res.supportedStyles[0] + '/' + res.defaultPalette,
        srs: 'EPSG:4326',
        transparent: true,
        zIndex: 400,
        reuseTiles: true,
        maxZoom: 18,
        minZoom: 2,
        attribution: "Ramani by Ujuizi Laboratories"
      });

      var scaleRange = res.scaleRange[0] + "," + res.scaleRange[1];
      var elevation = "0";

      if (res.zaxis) {
        elevation = res.zaxis.values[0];
      }

      layer.setParams({
        token: 'b163d3f52ebf1cf29408464289cf5eea20cda538',
        package: 'com.web.ramani',
        COLORSCALERANGE: scaleRange,
        ELEVATION: elevation,
        EXCEPTIONS: 'application/vnd.ogc.se_inimage',
        LOGSCALE: res.logScaling,
        NUMCOLORBANDS: res.numColorBands,
        TIME: res.nearestTimeIso
      }, true);

      next(layer);
    });
  },

  getTransect: function transect(layerID, coordinates, opts, next) {
    var time = opts.time,
        scaleRange = opts.colorScaleRange,
        numColors = opts.numColors || 250,
        logScale = opts.logScale || false,
        palette = opts.palette || 'grayscale';

    coordinates = coordinates.map(function(coord) {
      return coord.lng + ' ' + coord.lat;
    }).toString();

    $.getJSON(Ramani.baseUrl, {
      token: 'b163d3f52ebf1cf29408464289cf5eea20cda538',
      package: 'com.web.ramani',
      request: 'GetTransect',
      layer: layerID,
      crs: 'EPSG:4326',
      time: time,
      linestring: coordinates,
      format: 'text/json',
      colorscalerange: scaleRange,
      numcolorbands: numColors,
      logscale: logScale,
      palette: palette,
      version: '1.1.1'
    }, next);
  },

  getFeatureInfo: function getFeatureInfo(layerID, map, opts, next) {
    var point = map.latLngToContainerPoint(opts.latLng, map.getZoom());
    var size = map.getSize();
    var time = opts.time;

    $.getJSON(Ramani.baseUrl, {
      layers: layerID,
      time: time,
      token: 'b163d3f52ebf1cf29408464289cf5eea20cda538',
      package: 'com.web.ramani',
      service: 'WMS',
      version: '1.1.1',
      request: 'GetFeatureInfo',
      exceptions: 'application/vnd.ogc.se_inimage',
      srs: 'EPSG:4326',
      bbox: map.getBounds().toBBoxString(),
      x: point.x,
      y: point.y,
      info_format: 'text/json',
      query_layers: layerID,
      width: size.x,
      height: size.y
    }, next);
  },

  getVerticalProfile: function getVerticalProfile(layerID, point, opts, next) {
    var time = opts.time,
        scaleRange = opts.colorScaleRange,
        numColors = opts.numColors || 250,
        logScale = opts.logScale || false,
        palette = opts.palette || 'grayscale';

    $.getJSON(Ramani.baseUrl, {
      token: 'b163d3f52ebf1cf29408464289cf5eea20cda538',
      package: 'com.web.ramani',
      request: 'GetVerticalProfile',
      layer: layerID,
      crs: 'CRS:84',
      time: time,
      point: point.lng + ' ' + point.lat,
      format: 'text/json',
      colorscalerange: scaleRange,
      numcolorbands: numColors,
      logscale: logScale,
      palette: palette,
      version: '1.1.1'
    }, next);
  },

  getTimeseriesProfile: function getTimeseriesProfile(layerID, map, opts, next) {
    var size = map.getSize();
    var point = map.latLngToContainerPoint(opts.latLng, map.getZoom());
    var time = opts.time,
        scaleRange = opts.colorScaleRange,
        numColors = opts.numColors || 250,
        logScale = opts.logScale || false,
        palette = opts.palette || 'grayscale',
        transparent = opts.transparent || true,
        style = opts.style || 'boxfill',
        exceptions = opts.exceptions || 'application%2Fvnd.ogc.se_inimage',
        srs = opts.srs || 'EPSG%3A4326';

    $.getJSON(Ramani.baseUrl, {
      token: 'b163d3f52ebf1cf29408464289cf5eea20cda538',
      package: 'com.web.ramani',
      request: 'GetFeatureInfo',
      layers: layerID,
      time: time,
      //transparent: transparent,
      // styles: style + '/' + palette,
      service: 'WMS',
      x: point.x,
      y: point.y,
      bbox: map.getBounds().toBBoxString(),
      width: size.x,
      height: size.y,
      exceptions: exceptions,
      format: 'text/json',
      info_format: 'text/json',
      query_layers: layerID,
      srs: srs,
      colorscalerange: scaleRange,
      numcolorbands: numColors,
      logscale: logScale,
      version: '1.1.1'
    }, next);
  },

  area: function area(marker, latlng) {

    var layer = $('#layer_id').val();
    var date = $('.datetimeseries input').val();
    var scaleRange = $('#scaleMin').val()+","+$('#scaleMax').val();
    var time = date +"T"+ $('.datetimeseries select option:selected').val();
    var line = latlng;
    var numColorBands = $('#numColorBands').val();
    var logScale = $('#scaleSpacing option:selected').val();
    var palette = $('#defaultPalette').val();

    $('#transectModal .modal-body img').attr('src', 'http://ramani.ujuizi.com/ddl/wms?key=b163d3f52ebf1cf29408464289cf5eea20cda538&package=com.web.ramani&REQUEST=GetTransect&LAYER='+layer+'&CRS=EPSG:4326&ELEVATION=0&TIME='+time+'&LINESTRING='+line+'&FORMAT=image/png&COLORSCALERANGE='+scaleRange+'&NUMCOLORBANDS='+numColorBands+'&LOGSCALE='+logScale+'&PALETTE='+palette+'&VERSION=1.1.1');

    $('#transectModalLabel').html('Get Area');
    $('#transectModal').modal('show');
  },

  layerAnimation: function layerAnimation(layer) {
    var ddl = L.tileLayer.wms("http://ramani.ujuizi.com/ddl/wms", {
      layers: layer,
      format: 'image/png',
      transparent: true,
      zIndex:400,
      reuseTiles:true,
      maxZoom: 18,
      attribution: "Ramani by Ujuizi Laboratories"
    });

    ddl.setParams({
      'key' : 'b163d3f52ebf1cf29408464289cf5eea20cda538',
      'package' : 'com.web.ramani'
    }, true);

    ddl.setOpacity(0.2);

    return ddl;
  },

  getMetadata: function getMetadata(layerID, next) {
    $.getJSON(Ramani.baseUrl, {
      package: 'com.web.ramani',
      item: 'layerDetails',
      layerName: layerID,
      request: 'GetMetadata',
      token: 'b163d3f52ebf1cf29408464289cf5eea20cda538'
    }, next);
  }
};

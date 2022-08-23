<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
<title>{{$d->title}}</title>
<link rel="stylesheet" href="https://cdn.plyr.io/3.7.2/plyr.css" />
<script src="https://cdn.plyr.io/3.7.2/plyr.polyfilled.js"></script>
</head>
<body style="display: flex;justify-content: center;align-items: center;">
<video id="player" playsinline controls data-poster="{{$d->image}}" style="padding:0;margin:0;">
  <source src="{{$d->source}}" type="video/mp4" />
</video>
<script>
  const player = new Plyr('#player');
</script>
</body>
</html>

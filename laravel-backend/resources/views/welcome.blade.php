<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name') }}</title>

    <!-- Fonts -->
    <link rel="dns-prefetch" href="//fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Nunito" rel="stylesheet">

    <!-- Styles -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
</head>
<body>
<div class="col-md-4 col-sm-10 mx-auto my-5 p-3">
<div class="card">
<div class="card-body">
<div class="p-2 text-center">
<img src="{{config("app.logo")}}" alt="..." class="rounded" width=100>
<h3 class="m-2 fw-semibold">{{ config('app.name', 'Dark Moon') }}</h3>
<p class="lh-base">Free 18+ online video channel application for Android.</p>
<a class="btn btn-dark btn-lg" href="{{config("app.dlink")}}">Download Now</a>
<div class="w-75 my-3  mx-auto bg-dark" style="height:.2px"></div>
<h5>Contact us : <a class="fw-semibold" href="https://t.me/{{config("app.contact")}}">Telegram</a> </h5>
</div>
</div></div>
</div>
</body>
</html>

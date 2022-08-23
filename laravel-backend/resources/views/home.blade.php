@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Dashboard') }}</div>

                <div class="card-body">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif
<p>User ({{$users}})</p>
                    <p><a href="{{route("category-list")}}">Category({{$category}}) </a></p>
                    <p><a href="{{route("post-list")}}">Post({{$post}})</a></p>
                    <p><a href="{{route("ads-list")}}">Advertisement({{$ads}})</a></p>
@if(auth()->user()->level=="0")
<p><a href="{{route("admin-list")}}">Admin</a></p>
@endif

                </div>
            </div>
        </div>
    </div>
</div>
@endsection

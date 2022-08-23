@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('View Category') }}</div>

                <div class="card-body">
                    <form method="POST" enctype="multipart/form-data" action="{{route("category-edit",$d->id)}}">
@method('PUT')
@csrf
<div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control @error('title') is-invalid @enderror" id="logo" name="title" placeholder="Enter Title" value="{{$d->name}}">
@error('title')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
<label for="url">Image</label>
    <input type="file" class="form-control @error('url') is-invalid @enderror" id="logo" name="url" accept="image/*">
@error('url')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="mt-2 form-group">
<button type="submit" class="btn btn-primary mb-2">Edit</button>
<button type="button"onclick="document.getElementById('del-cat').submit();" class="btn btn-danger mb-2">Delete</button>
<a href="{{route("category-list")}}" class="btn btn-warning mb-2">Back</a>
</div>
</form>
<form method="POST" action="{{route('category-delete',$d->id)}}" id="del-cat">@method('DELETE') @csrf</form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

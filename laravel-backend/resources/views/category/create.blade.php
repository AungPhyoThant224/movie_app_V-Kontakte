@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Create Category') }}</div>

                <div class="card-body">
                    <form method="POST" enctype="multipart/form-data">@csrf
<div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control @error('title') is-invalid @enderror" id="logo" name="title" placeholder="Enter Title">
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
<button type="submit" class="btn btn-primary mb-2">Create</button></div>
</form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

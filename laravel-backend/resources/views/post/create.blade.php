@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Create Post') }}</div>

                <div class="card-body">
	<form method="POST">
@csrf
	<div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control @error('title') is-invalid @enderror" id="title" name="title" placeholder="Enter title">
@error('title')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="url">Video Url</label>
<input type="text" class="form-control @error('key') is-invalid @enderror" id="url" name="key" placeholder="Enter VK video url">
@error('key')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-group">
    <label for="category">Category</label>
    <select class="form-control @error('category') is-invalid @enderror" name="category" id="category">
      <option value="0" disable>Select Category</option>
@foreach($categories as $c)
      <option value="{{$c->id}}">{{$c->name}}</option>
@endforeach
    </select>
@error('category')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="description">Description</label>
    <textarea class="form-control" id="description" name="description" rows="3"></textarea>
  </div>
<div class="mt-2">
<button type="submit" class="btn btn-primary mb-2">Create</button></div>
</form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

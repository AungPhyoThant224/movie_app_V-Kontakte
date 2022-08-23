@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Create Notification') }}</div>

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
    <label for="description">Description</label>
    <textarea class="form-control" id="description" name="description" rows="3"></textarea>
  </div>
<div class="form-group">
    <label for="type">Type</label>
    <select class="form-control @error('type') is-invalid @enderror" name="type" id="type">
      <option value="0" disable>Select Type</option>
      <option value="1">App Update</option>
	<option value="2">Notification</option>
	<option value="3">Advertisement</option>
    </select>
@error('type')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="note">Note</label>
<input type="text" class="form-control @error('note') is-invalid @enderror" id="note" name="note" placeholder="Note">
@error('note')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-check">
  <input class="form-check-input" type="checkbox" id="status" name="status" checked>
  <label class="form-check-label" for="status">
    Show
  </label>
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

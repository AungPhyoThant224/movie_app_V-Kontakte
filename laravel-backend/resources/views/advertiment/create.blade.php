@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Create Advertisement') }}</div>

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
<div class="form-group">
    <label for="type">Type</label>
    <select class="form-control @error('type') is-invalid @enderror" name="type" id="type">
      <option value="0" disable>Select Type</option>
      <option value="1">Slider Image</option>
	<option value="2">Card Image</option>
    </select>
@error('type')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="ctype">Contact Type</label>
    <select class="form-control @error('ctype') is-invalid @enderror" name="ctype" id="ctype">
      <option value="0" disable>Select Contact Type</option>
      <option value="1">Website</option>
<option value="2">Facebook</option>
<option value="3">Viber</option>
<option value="4">Line</option>
<option value="5">Telegram</option>
    </select>
@error('ctype')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="contact">Contact Address</label>
<input type="text" class="form-control @error('contact') is-invalid @enderror" id="contact" name="contact" placeholder="Contact Address">
@error('contact')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-group">
    <label for="end_date">End Date</label>
<input type="date" class="form-control @error('end_date') is-invalid @enderror" id="end_date" name="end_date" min="{{date('Y-m-d')}}">
@error('end_date')
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
<script>
document.getElementById("end_date").defaultValue = "{{date('Y-m-d')}}";
</script>

@endsection

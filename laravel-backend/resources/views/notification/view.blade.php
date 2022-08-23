@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('View Advertisement') }}</div>

                <div class="card-body">
                    <form method="POST" action="{{route("notification-edit",$d->id)}}">
@method('PUT')
@csrf
<div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control @error('title') is-invalid @enderror" id="logo" name="title" placeholder="Enter Title" value="{{$d->title}}">
@error('title')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror

  </div>
<div class="form-group">
    <label for="description">Description</label>
    <textarea class="form-control" id="description" name="description" rows="3">{{$d->description}}</textarea>
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
<input type="text" class="form-control @error('note') is-invalid @enderror" id="note" name="note" placeholder="Note" value="{{$d->note}}">
@error('note')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-check">
  <input class="form-check-input" type="checkbox" id="status" name="status" @if($d->status=="1") checked @endif>
  <label class="form-check-label" for="status">
    Show
  </label>
</div>
<div class="mt-2 form-group">
<button type="submit" class="btn btn-primary mb-2">Edit</button>
<button type="button"onclick="document.getElementById('del-noti').submit();" class="btn btn-danger mb-2">Delete</button>
<a href="{{route("notification-list")}}" class="btn btn-warning mb-2">Back</a>
</div>
</form>
<form method="POST" action="{{route('notification-delete',$d->id)}}" id="del-noti">@method('DELETE') @csrf</form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
function setSelectedValue(selectObj, valueToSet) {
    for (var i = 0; i < selectObj.options.length; i++) {
        if (selectObj.options[i].value== valueToSet) {
            selectObj.options[i].selected = true;
            return;
        }
    }
}
var type = document.getElementById("type");
setSelectedValue(type,"{{$d->type}}");
</script>
@endsection

@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Setting') }}</div>
                <div class="card-body">
                    <form method="POST" action="{{route("us",$data->id)}}" enctype="multipart/form-data">@method("PUT")
@csrf
<div class="form-group">
    <label for="title">App Name</label>
    <input type="text" class="form-control @error('title') is-invalid @enderror" id="title" name="title" placeholder="Enter App Name" value="{{$data->name}}">
@error('title')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="logo">Logo</label>
    <input type="file" accept="image/*" class="form-control @error('logo') is-invalid @enderror" id="logo" name="logo" placeholder="Enter VK Client ID" value="{{$data->client_id}}">
@error('logo')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="dlink">Download Link</label>
<input type="text" class="form-control @error('dlink') is-invalid @enderror" id="dlink" name="dlink" placeholder="Enter Download Link" value="{{$data->dlink}}">
@error('dlink')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-group">
    <label for="version">Version</label>
<input type="text" class="form-control @error('version') is-invalid @enderror" id="version" name="version" placeholder="Enter App Version" value="{{$data->version}}">
@error('version')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-group">
    <label for="imgbb">Imgbb Api Token</label>
    <input type="text" class="form-control @error('imgbb') is-invalid @enderror" id="imgbb" name="imgbb" placeholder="Enter Imgbb token" value="{{$data->imgbb_token}}">
@error('imgbb')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="vkid">VK Client ID</label>
    <input type="text" class="form-control @error('vkid') is-invalid @enderror" id="vkid" name="vkid" placeholder="Enter VK Client ID" value="{{$data->client_id}}">
@error('vkid')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
    <label for="vksecret">VK Secret</label>
    <input type="text" class="form-control @error('vksecret') is-invalid @enderror" id="logo" name="vksecret" placeholder="Enter VK Client Secret" value="{{$data->client_secret}}">
@error('vksecret')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
  </div>
<div class="form-group">
<label for="token">VK Access Token</label>
<div class="input-group">
  <input type="text" class="form-control" placeholder="Vk Token" readonly aria-label="Vk Generate Token" aria-describedby="basic-addon2" id="token" value="{{auth()->user()->access_token}}">
  <div class="input-group-append">
    <button class="input-group-text bg-primary text-white" type="button" onclick="document.getElementById('gen-token').submit();" id="basic-addon2">Generate</button>
  </div>
</div>
</div>
<div class="form-group">
    <label for="contact">Contact</label>
<input type="text" class="form-control @error('contact') is-invalid @enderror" id="contact" name="contact" placeholder="Enter Telegram Username" value="{{$data->contact}}">
@error('contact')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-group">
    <label for="about">About us</label>
    <textarea class="form-control" id="about" name="about" rows="3">{{$data->about}}</textarea>
  </div>
<div class="form-group">
    <label for="policy">Policy</label>
    <textarea class="form-control" id="policy" name="policy" rows="3">{{$data->policy}}</textarea>
  </div>
<div class="mt-2">
 <button type="submit" class="btn btn-primary mb-2">Update</button>
</form>
<form method="POST" action="{{route('generate-token')}}" id="gen-token">@csrf</form>
                </div>
            </div>
</div>
<div class="col-md-8 mt-2">
            <div class="card">
<div class="card-header">{{ __('Change Info') }}</div>
                <div class="card-body">
<form method="POST" action="{{route("ci")}}">@csrf
<div class="form-group">
    <label for="name">Name</label>
<input type="text" class="form-control @error('name') is-invalid @enderror" id="name" name="name" placeholder="Enter Username" value="{{auth()->user()->name}}">
@error('name')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-group">
    <label for="mail">Email Address</label>
<input type="email" class="form-control @error('mail') is-invalid @enderror" id="mail" name="mail" placeholder="Enter Email Address" value="{{auth()->user()->email}}">
@error('mail')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<button type="submit" class="btn btn-primary my-2">Save</button>

</form>
</div>
        </div>
</div>
<div class="col-md-8 mt-2">
            <div class="card">
<div class="card-header">{{ __('Change Password') }}</div>
                <div class="card-body">
<form method="POST" action="{{route("cp")}}">@csrf
<div class="form-group">
    <label for="old">Old Password</label>
<input type="password" class="form-control @error('old') is-invalid @enderror" id="old" name="old" placeholder="Enter Old Password">
@error('old')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>
<div class="form-group">
    <label for="new">New Password</label>
<input type="password" class="form-control @error('new') is-invalid @enderror" id="new" name="new" placeholder="Enter New Password">
@error('new')
 <span class="invalid-feedback" role="alert">
 <strong>{{ $message }}</strong></span>
@enderror
</div>

<div class="form-group">
    <label for="newc">Comfrim New Password</label>
<input type="password" class="form-control" id="newc" name="new_confirmation" placeholder="Comfrim New Password"></div>
<button type="submit" class="btn btn-primary my-2">Save</button>
</form>

</div>
	</div>
</div>
          </div>
    </div>
</div>
@endsection

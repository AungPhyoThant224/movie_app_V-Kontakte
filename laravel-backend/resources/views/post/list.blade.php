@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Posts') }} | <a class="btn btn-warning" href="{{route("post-create")}}">Create</a></div>

                <div class="card-body">
<div class="table-responsive">
                        <table class="table table-bordered table-md">
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Source</th>
                                <th>Action</th>
                            </tr>
@foreach ($data as $d)
                                <tr>
                                    <td>{{auth()->user()->level == "0" ? $d->admin->name : $loop->index + 1 }}</td>
                                    <td>{{ $d->title }}</td>
<td>{{$d->key}}</td>
<td><a href="{{route("post-view",$d->id)}}" class="btn btn-primary">View</a></td>
</tr>
@endforeach


</table>
</div>
<div class="d-flex justify-content-center">
                        {!! $data->links() !!}
</div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

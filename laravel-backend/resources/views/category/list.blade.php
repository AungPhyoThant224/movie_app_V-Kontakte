@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Categories') }} | <a class="btn btn-warning" href="{{route("category-create")}}">Create</a></div>

                <div class="card-body">
                    <div class="card-body">
<div class="table-responsive">
                        <table class="table table-bordered table-md">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Image</th>
                                <th>Action</th>
                            </tr>
@foreach ($data as $d)
                                <tr>
                                    <td>{{auth()->user()->level == "0" ? $d->admin->name : $loop->index + 1 }}</td>
                                    <td>{{ $d->name }}</td>
<td>{{$d->image}}</td>
<td><a href="{{route("category-view",$d->id)}}" class="btn btn-primary">View</a></td>
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

@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Advertisememts') }} | <a class="btn btn-warning" href="{{route("ads-create")}}">Create</a></div>

                <div class="card-body">
                    <div class="card-body">
<div class="table-responsive">
                        <table class="table table-bordered table-md">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>End Date</th>
                                <th>Action</th>
                            </tr>
@foreach ($data as $d)
                                <tr>
                                    <td>{{auth()->user()->level == "0" ? $d->admin->name : $loop->index + 1 }}</td>
                                    <td>{{ $d->title }}</td>
<td>{{$d->end_date}}</td>
<td><a href="{{route("ads-view",$d->id)}}" class="btn btn-primary">View</a></td>
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

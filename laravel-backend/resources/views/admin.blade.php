@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Admins') }} | <a class="btn btn-warning" href="{{route("admin-create")}}">Create</a></div>

                <div class="card-body">
                    <div class="card-body">
<div class="table-responsive">
                        <table class="table table-bordered table-md">
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Email</th>
                            </tr>
@foreach ($data as $d)
                                <tr>
                                    <td>{{$d->id }}</td>
                                    <td>{{ $d->name }}</td>
<td>{{$d->email}}</td>
</tr>
@endforeach


</table>
</div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

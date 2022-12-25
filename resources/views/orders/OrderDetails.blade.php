@extends('layouts.app')

@section('title', trans("lang.orders"))

@section('content')
    @inject('permission', 'App\Http\Controllers\API\PermissionController')
    <order-details
            :id="{{ $id}}"
            tab_name="{{$tab_name}}"
            route_name="{{$route_name}}">
    </order-details>
@endsection
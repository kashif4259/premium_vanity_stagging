@inject('perm', 'App\Http\Controllers\API\PermissionController')
@extends('layouts.app')
@section('title', 'Todos Management')
@section('content')

    <todos-management-component :user="{{ Auth::user() }}"
                                 current_branch="{{$currentBranch}}"
                                 >
    </todos-management-component>

@endsection

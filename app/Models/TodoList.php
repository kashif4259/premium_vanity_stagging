<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class TodoList extends BaseModel
{
    protected $fillable = ['title', 'description', 'due_date', 'completed_date', 'completed', 'user_id', 'created_at', 'updated_at'];

    public static function getSortedLists($sortBy, $orderBy)
    {
        $userId = Auth()->user()->id;
        $query = DB::table('todo_lists')
            ->join('users', 'users.id', '=', 'todo_lists.user_id')
            ->join('users as u2', 'u2.id', '=', 'todo_lists.user_id')
            ->select(
                'todo_lists.id as todo_id',
                'todo_lists.title as title',
                'todo_lists.due_date as due_date',
                'todo_lists.completed_date as completed_date',
                'todo_lists.completed as completed',
                'todo_lists.description',
                DB::raw("CONCAT(users.first_name,' ',users.last_name)  AS created_by"),
                DB::raw("CONCAT(u2.first_name,' ',u2.last_name)  AS assigned_to")
            )->where('todo_lists.user_id', $userId);

        if ($sortBy == 'due_date') {
            $data = $query->where('todo_lists.due_date', '!=', null)
                //->where('todo_lists.completed', true)
                ->orderBy('todo_lists.due_date', $orderBy)->get();
        } else {
            $data = $query->orderBy('todo_lists.id', $orderBy)->get();
        }
        return $data;
    }
}

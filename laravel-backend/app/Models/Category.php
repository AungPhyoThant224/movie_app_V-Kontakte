<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $fillable=["name","image","admin_id"];

    protected $hidden=["admin_id","updated_at"];

    public function posts(){
         return $this->hasMany(Post::class);
    }
    public function admin(){
         return $this->belongsTo(Admin::class);
    }
}

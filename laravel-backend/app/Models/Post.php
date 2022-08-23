<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $fillable=["title","url","key","total_view","image","duration","description","admin_id","category_id"];

    protected $hidden = ["updated_at","admin_id","category_id","key"];

    public function category(){
         return $this->belongsTo(Category::class);
    }
    public function admin(){
         return $this->belongsTo(Admin::class);
    }
}

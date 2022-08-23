<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Advertiment extends Model
{
    use HasFactory;

    protected $fillable=["title","info","end_date","status","type","admin_id","contact","ctype"];

    protected $hidden=["updated_at","end_date","status","admin_id"];
   
    public function admin(){
         return $this->belongsTo(Admin::class);
    }
}

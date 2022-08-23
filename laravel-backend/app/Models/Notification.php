<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;

protected $fillable=["title","description","type","note","status","admin_id"];
protected $hidden=["updated_at","status","admin_id"];
public function admin(){
         return $this->belongsTo(Admin::class);
    }
}

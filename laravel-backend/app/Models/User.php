<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    use HasFactory;

protected $fillable=["device_id","username","password","profile","status"];
protected $hidden=["password","updated_at"];

}

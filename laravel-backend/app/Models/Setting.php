<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
    use HasFactory;

    protected $fillable =["name","logo","about","contact","policy","client_id","client_secret","imgbb_token","active","dlink","version"];
}

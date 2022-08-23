<?php

namespace App\Models;


use Illuminate\Contracts\Auth\MustVerifyEmail; 
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable; 
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;


class Admin extends Authenticatable {
    
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable=["name","email","password","level","access_token"];

    protected $hidden = ['password','remember_token',];

    protected $casts = ['email_verified_at' =>'datetime'];

    public function posts(){
         return $this->hasMany(Post::class);
    }

    public function categories(){
         return $this->hasMany(Category::class);
    }

    public function advertiments(){
         return $this->hasMany(Advertiment::class);
    }
    public function notifications(){
         return $this->hasMany(Notification::class);
    }
}

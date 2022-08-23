<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\SavePostRequest;
use App\Models\Category;
use App\Models\Post;
use App\Helpers\RequestHelper;

class PostController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function list(){
return view("post.list",["data"=>Post::orderBy("updated_at","DESC")->paginate(5)]);
}

    public function create(){
return view("post.create",["categories"=>Category::orderBy("updated_at","DESC")->get()]);
    }

public function view($id){
return view("post.view",["categories"=>Category::orderBy("updated_at","DESC")->get(),"d"=>Post::findOrFail($id)]);
}

    public function save(SavePostRequest $req){
	$key =RequestHelper::getVideoKey($req->key);
	$vd = RequestHelper::checkVk($key);
	$vd = $vd["response"]["items"][0];
	$d =[
"title"=>$req->title,
"url"=>$vd["player"],
"key"=>$req->key,
"total_view"=>0,
"image"=>$vd["photo_800"],
"duration"=>floor($vd["duration"]/60),
"description"=>$req->description ?? null,
"screenshots"=>[],
"admin_id"=>auth()->user()->id,
"category_id"=>$req->category
	];
$p = Post::create($d);
return redirect(route("post-list"))->with('success', 'New Post is created.');
    }

public function edit(SavePostRequest $req,$id){
$key =RequestHelper::getVideoKey($req->key);
        $vd = RequestHelper::checkVk($key);
        $vd = $vd["response"]["items"][0];
$p=Post::findOrFail($id);
$p->title=$req->title;
$p->url=$vd["player"];
$p->key=$req->key;
$p->image=$vd["photo_800"];
$p->duration=floor($vd["duration"]/60);
$p->description=$req->description ?? null;
$p->category_id=$req->category;
$p->admin_id=auth()->user()->id;
$p->save();
return redirect(route("post-view",$id))->with('success', 'Post is updated');
}

public function delete($id){
$p=Post::findOrFail($id);
$p->delete();
return redirect(route("post-list"))->with('success', 'Post is deleted.');
}

}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\SaveCategoryRequest;
use App\Models\Category;
use App\Helpers\RequestHelper;

class CategoryController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }
    public function create(){
        return view("category.create");
    }
public function save(SaveCategoryRequest $req){
if(!$req->hasFile("url")) return redirect()->back()->with('error', 'Image is required.');
$f=base64_encode(file_get_contents($req->file('url')));
$url=RequestHelper::uploadI($f);
$p = Category::create(["name"=>$req->title,"image"=>$url,"admin_id"=>auth()->user()->id]);
return redirect(route("category-list"))->with('success', 'New Category is created.');
}

public function list(){
return view("category.list",["data"=>Category::orderBy("updated_at","DESC")->paginate(5)]);
}
public function view($id){
return view("category.view",["d"=>Category::findOrFail($id)]);
}
public function edit(SaveCategoryRequest $req,$id){
$d=Category::findOrFail($id);
$d->name=$req->title;
if($req->hasFile("url")){
$f=base64_encode(file_get_contents($req->file('url')));
$d->image=RequestHelper::uploadI($f);
}
$d->admin_id=auth()->user()->id;
$d->save();
return redirect(route("category-view",$id))->with('success', 'Category is updated.');
}

public function delete($id){
$p=Category::findOrFail($id);
$p->delete();
return redirect(route("category-list"))->with('success', 'Category is deleted');
}



}


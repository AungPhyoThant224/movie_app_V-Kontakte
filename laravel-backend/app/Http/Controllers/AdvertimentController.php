<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Advertiment;
use App\Helpers\RequestHelper;
use App\Http\Requests\SaveAdvertimentRequest;

class AdvertimentController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

public function create(){
        return view("advertiment.create");
    }
public function save(SaveAdvertimentRequest $req){
if(!$req->hasFile("url")) return redirect()->back()->with('error', 'Image is required');
$f=base64_encode(file_get_contents($req->file('url')));
$url=RequestHelper::uploadI($f);
$p = Advertiment::create([
"title"=>$req->title,
"info"=>$url,
"end_date"=>$req->end_date,
"type"=>$req->type,
"ctype"=>$req->ctype,
"contact"=>$req->contact,
"admin_id"=>auth()->user()->id]);
return redirect(route("ads-list"))->with('success', 'New Advertisement is created.');
}

public function list(){
return view("advertiment.list",["data"=>Advertiment::orderBy("updated_at","DESC")->paginate(5)]);
}
public function view($id){
return view("advertiment.view",["d"=>Advertiment::findOrFail($id)]);
}
public function edit(SaveAdvertimentRequest $req,$id){
$d=Advertiment::findOrFail($id);
$d->title=$req->title;
if($req->hasFile("url")){
$f=base64_encode(file_get_contents($req->file('url')));
$d->info=RequestHelper::uploadI($f);
}
$d->end_date=$req->end_date;
$d->type=$req->type;
$d->ctype=$req->ctype;
$d->contact=$req->contact;
$d->admin_id=auth()->user()->id;
$d->save();
return redirect(route("ads-view",$id))->with('success', 'Advertisement is updated.');
}

public function delete($id){
$p=Advertiment::findOrFail($id);
$p->delete();
return redirect(route("ads-list"))->with('success', 'Advertisement is deleted.');
}

}

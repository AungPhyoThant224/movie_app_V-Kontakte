<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\SaveNotificationRequest;
use App\Models\Notification;

class NotificationController extends Controller
{
public function __construct()
    {
        $this->middleware('auth');
    }
    public function create(){
        return view("notification.create");
    }
public function save(SaveNotificationRequest $req){
$s=$req->status ? "1" : "0";
$p = Notification::create(["title"=>$req->title,"description"=>$req->description,"type"=>$req->type,"note"=>$req->note,"status"=>$s,"admin_id"=>auth()->user()->id]);
return redirect(route("notification-list"))->with('success', 'New Notification is created.');
}

public function list(){
return view("notification.list",["data"=>Notification::orderBy("updated_at","DESC")->paginate(5)]);
}
public function view($id){
return view("notification.view",["d"=>Notification::findOrFail($id)]);
}
public function edit(SaveNotificationRequest $req,$id){
$d=Notification::findOrFail($id);
$d->title=$req->title;
$d->description=$req->description;
$d->type= $req->type;
$d->note=$req->note;
$d->status=$req->status ? "1" : "0";
$d->admin_id=auth()->user()->id;
$d->save();
return redirect(route("notification-view",$id))->with('success', 'Notification is updated.');
}

public function delete($id){
$p=Notification::findOrFail($id);
$p->delete();
return redirect(route("notification-list"))->with('success', 'Notification is deleted');
}
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Admin;
use App\Models\User;
use App\Models\Post;
use App\Models\Category;
use App\Models\Advertiment;
use App\Models\Setting;
use App\Http\Requests\ChangePasswordRequest;
use App\Http\Requests\ChangeMailRequest;
use App\Http\Requests\UpdateSettingRequest;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Hash;
use App\Helpers\RequestHelper;
use Illuminate\Support\Facades\Validator;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth')->except(["video"]);
    }

    public function video($id){
	$p=Post::findOrFail($id);
	$p->source=RequestHelper::getVideo($p->key);
	return view('video',["d"=>$p]);
    }

    public function index()
    {
        $cat = count(Category::all());
        $p = count(Post::all());
        $a = count(Advertiment::all());
	$u= count(User::all());
        return view('home',["category"=>$cat,"post"=>$p,"ads"=>$a,"users"=>$u]);
    }

    public function setting(){
         return view('setting',["data"=> Setting::where("active","1")->first()]);
    }

public function createA(){
if(auth()->user()->level!="0") return abort(404);
return view('auth.register');
}
public function createAP(Request $data){
if(auth()->user()->level!="0") return abort(404);
Validator::make($data->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:admins'],
            'password' => ['required', 'string', 'min:8'],
        ]);
Admin::create([
            'name' => $data->name,
            'email' => $data->email,
            'password' => Hash::make($data->password),
            'level' => '1'
        ]);
return redirect(route("admin-list"))->with('success', 'Admin Account Created.');
}
public function adminList(){
if(auth()->user()->level!="0") return abort(404);
return view('admin',["data"=>Admin::orderBy("updated_at","DESC")->get()]);
}
public function updateSetting(UpdateSettingRequest $req,$id){
$d=Setting::findOrFail($id);
$d->name=$req->title;
if($req->hasFile("logo")){
$f=base64_encode(file_get_contents($req->file('logo')));
$d->logo=RequestHelper::uploadI($f);
}
$d->version=$req->version;
$d->about=$req->about;
$d->dlink=$req->dlink;
$d->contact=$req->contact;
$d->policy=$req->policy;
$d->client_id=$req->vkid;
$d->client_secret=$req->vksecret;
$d->imgbb_token=$req->imgbb;
$d->save();
return redirect(route('setting'))->with('success', 'Some Data is updated.');
}

public function changeMail(ChangeMailRequest $req){
$u=auth()->user();
$u->name=$req->name;
$u->email=$req->mail;
$u->save();
return redirect(route('setting'))->with('success', 'Your Info is updated');
}
public function changePassword(ChangePasswordRequest $req){
$u=auth()->user();
$u->password=Hash::make($req->new);
$u->save();
return redirect(route('setting'))->with('success', 'Your Password is changed.');
}


    public function generateToken(Request $req){
	$d = Setting::where("active","1")->first();
	$url = "https://oauth.vk.com/authorize?client_id=".strval($d->client_id)."&display=page&redirect_uri=". route("callback")."&scope=photos,audio,video&response_type=code&v=5.92";
	return \Redirect::to($url);
    }
    public function callback(Request $req){
$d = Setting::where("active","1")->first();
$url = "https://oauth.vk.com/access_token?client_id=".$d->client_id."&client_secret=".$d->client_secret."&code=".$req->code."&redirect_uri=".route("callback");
$r = Http::get($url);
$res = $r->json();
$u=auth()->user();
$u->access_token=$res["access_token"];
$u->save();
return redirect(route('setting'))->with('success', 'VK Access Token is created.');
}
}

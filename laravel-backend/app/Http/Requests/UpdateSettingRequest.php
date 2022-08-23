<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateSettingRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "title"=>"required|string|min:3|max:50",
	"logo"=>"image",
	"imgbb"=>"required|string",
"version"=>"required|string",
	"vkid"=>"required|string",
	"vksecret"=>"required|string",
	"contact"=>"required|string",
        ];
    }
}

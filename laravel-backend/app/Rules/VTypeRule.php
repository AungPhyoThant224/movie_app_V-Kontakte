<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;

class VTypeRule implements Rule
{
    private $a = [];
    /**
     * Create a new rule instance.
     *
     * @return void
     */
    public function __construct($arr)
    {
        $this->a=$arr;
    }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */
    public function passes($attribute, $value)
    {
        return in_array($value,$this->a);
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'Type is not allow!!!';
    }
}

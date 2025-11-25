<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Session;

class SetDefaultCurrency
{
    public function handle($request, Closure $next)
    {
        if (!Session::has('currency')) {
            Session::put('currency', 'EGP'); // Default to EGP
        }

        return $next($request);
    }
}

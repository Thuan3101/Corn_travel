﻿// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
import { createPopper } from '@popperjs/core';

// Ví dụ sử dụng Popper.js
const button = document.querySelector('#button');
const tooltip = document.querySelector('#tooltip');
createPopper(button, tooltip, {
    placement: 'top',
});

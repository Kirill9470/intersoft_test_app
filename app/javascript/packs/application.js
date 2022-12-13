// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import * as Vue from 'vue'
import App from '../app.vue'
import axios from 'axios'
import VueAxios from 'vue-axios'

import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"

import VueChartkick from 'vue-chartkick'
import 'chartkick/chart.js'

const app = Vue.createApp(App);

app.use(VueChartkick);
app.use(VueAxios, axios);

document.addEventListener('DOMContentLoaded', function(){
    app.mount('#app')
});

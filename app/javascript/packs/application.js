// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("@rails/ujs").start()
require("@rails/ujs")
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("jquery")
// require("moment")

// require("jquery.mCustomScrollbar")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import "bootstrap"
import "../stylesheets/application"
import Rails from "@rails/ujs"

// window.Calendar = require("@fullcalendar/core").Calendar;
// window.dayGridPlugin = require("@fullcalendar/daygrid").default;
// window.timeGridPlugin = require("@fullcalendar/timegrid").default;
// window.momentPlugin = require("@fullcalendar/moment").default;
// window.interactionPlugin = require("@fullcalendar/interaction").default;
// window.bootstrapPlugin = require("@fullcalendar/bootstrap").default;


window.Rails = Rails;
Rails.start();

import "controllers"

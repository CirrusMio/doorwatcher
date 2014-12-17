doorwatcher
===========

## Contributing

So you've got an awesome idea. Great! Please keep the following in mind:

* Please follow the [GitHub Ruby Styleguide](https://github.com/styleguide/ruby)
  when modifying Ruby code.
* Please do your best to submit **small pull requests**. The easier the proposed
  change is to review, the more likely it will be merged.
* When submitting a pull request, please make judicious use of the pull request
  body. A description of what changes were made, the motivations behind the
  changes and [any tasks completed or left to complete](http://git.io/gfm-tasks)
  will also speed up review time.
* Tests would be nice.

## Running Server

Deamonized Thin

`sudo thin -a 10.0.1.101 -p 80 -R config.ru -d --pid thin.pid start`

### Foreman

**Development**

`foreman start -f Procfile.dev`

**Production**

Foreman can export an init script via the following: bluepill, inittab, runit, upstart

For more info on Foreman export formats see:
http://ddollar.github.io/foreman/#EXPORT-FORMATS

## Getting Started

## Have Door Watcher record a .gif from the webcam and send it to the specified e-mail.

`curl http://127.0.0.1:80/door`

## Raspberry Pi setup

`sudo apt-get update`

Install git:

`sudo apt-get install git`

Install ruby:

`sudo apt-get install ruby` #=> ruby 1.9.3, ruby 2 would be better

`sudo apt-get install ruby-dev` #=> provides required libraries

Install bundler:

`sudo gem install bundler`

Clone DoorWatcher:

`git clone https://github.com/CirrusMio/doorwatcher.git`

Bundle gems:

`cd /path/to/doorwatcher && sudo bundle install`
       
## How to Use

Once you have everything installed, there are two things you want to configure or at least take note of 
inside handlers/door_action.

1. Edit line 22 to contain the URL of your still frame captures from your camera.

2. Line 53-59 for email input and 67-72 for email output.
       

## Explanation of Process
Capture frames -> Add frames to .gif -> attach .gif to email -> send email

## Fun ideas!
In theory you can use any trigger to curl to doorwatcher to get a .gif. You could use it to captures .gifs
of anything you want with a webcam. No need for a door!

(Much borrowed from AinsleyTwo)

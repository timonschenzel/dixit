// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-tab
//= require bootstrap-modal
//= require bootstrap-dropdown
//= require bootstrap-popover
//= require_tree .

$(document).ready(function(){
    $('form[data-remote="true"]').on('ajax:success', function(event, xhr, status) {
        callback = eval($(this).attr('data-callback'));
        callback.call(this, [xhr][0]);
    });
});

function invite_friends(args) {
    console.log(args.game);
    dialog('games/' + args.game.id + '/invite', args.game);
}

(function($) {

    $(document).ready(function(){
        $('div#login-form div input').tooltip({
            trigger: 'focus',
            placement: 'right'
        });

        $('a[rel=tooltip]').tooltip({
            trigger: 'hover'
        });

        $('input[rel=tooltip]').tooltip({
            trigger: 'focus',
            placement: 'left'
        });

        $('textarea[rel=tooltip]').tooltip({
            trigger: 'focus',
            placement: 'left'
        });

        $('tr[role=presentation]').tooltip({
            trigger: 'focus',
            placement: 'left'
        });

        $('[title]').tooltip({
            trigger: 'hover'
        });
    });

    /**
     * Create an alert message
     * @param {object}   options { type, autoCloseTime, closeButton, visible, titleAtOwnLine, title, message, buttons }
     * @return {Mixed}   Creates an alert from the specified object
     */
    $.fn.xsAlert = function(options) {

        var elementId;
        var alertContainer;

        var defaults = {
            type: 'error', /** { warning, error, success, info } */
            autoCloseTime: 0,
            closeButton: true,
            titleAtOwnLine: false,
            title: '',
            message: '',
            buttons: ''
        };
        var options = $.extend(defaults, options);
        elementId = this.get(0).id;

        $(this).append('<div class="alert-container"></div>');

        alertContainer = $(this).children('div.alert-container');

        //Add the default classes
        alertContainer.addClass('alert');
        alertContainer.addClass('fade');
        alertContainer.addClass('in');
        alertContainer.addClass('alert-' + options.type);

        //Close button
        if(options.closeButton) {
            alertContainer.append('<button type="button" class="close" data-dismiss="alert">&times;</button>');
        }

        //Title and content
        if(options.titleAtOwnLine) {
            alertContainer.addClass('alert-block');
            alertContainer.append('<h4 class="alert-heading">' + options.title + '</h4><p>' + options.message + '</p>');
        } else {
            alertContainer.append('<strong>' + options.title + '</strong>&nbsp;' + options.message);
        }

        //Auto-close
        if(options.autoCloseTime > 0) {
            setTimeout('closeAlert("' + elementId + '")', options.autoCloseTime * 1000);
        }
    }

    $.fn.ajaxModal = function(url, data) {
        $(this).load(url, data, function(){
            $(this).modal({
                keyboard:true,
                backdrop:true
            });
        }).modal('show');
    }

})(jQuery);

function add_tag_fields() {
    counter = $('div#tags_container').children('input').length
    $('div#tags_container').append('<input type="text" size="30" name="game[tags_attributes][' + counter + '][tag]" id="game_tags_attributes_' + counter + '_tag">');
}

function select_flickr_photo(me, photo_id) {
    $('input#flickr_photo_id').val(photo_id);
    $('a.flickr_photos').css({ 'background-color': 'transparent', 'border-color': '#DDDDDD' })

    $(me).css({ 'background-color': 'gray', 'border-color': 'green' })
}

function closeAlert(elementId) {
    $('#' + elementId + ' > div.alert-container').alert('close');
}

function prepare_tags() {
    tags = '';
    $('div#tags_container').children('input').each(function(){
        if($(this).val() != '') {
            if(tags == '') {
                tags += $(this).val();
            } else {
                tags += ", " + $(this).val();
            }
        }
        console.log(tags);
    })
    return tags;
}

function showDialog(me, args) {
    console.log(site_url($(me).attr('href')));

    args.url = prepare_tags();

    $('#modalContainer').ajaxModal(
        site_url($(me).attr('href')),
        args
    );
}

function dialog(url, args) {
    $('#modalContainer').ajaxModal(
        site_url(url),
        args
    );
}

function create_friendship(me, user_id, friend_id) {
    $.ajax({
        url: site_url('friendship/create'),
        data: {user_id: user_id, friend_id: friend_id},
        type: 'post',
        success: function(data) {
            console.log('friend added!');
            $(me).css({'background-color': 'green'})
        }
    });
}

function site_url(addition_url) {

    var lang_abbr = '';
    var add_sub_dir = '';

    if(typeof(addition_url) == 'undefined') {
        addition_url = '';
    } else if(addition_url.substring(0,1) == '/') {
        addition_url = addition_url.substring(1);
    }
    /*
    var url = location.href;  // entire url including querystring - also: window.location.href;
    var baseURL = url.substring(0, url.indexOf('/', 14));

    var relative_uri = location.pathname;
    relative_uri_arr = relative_uri.split("/");
    relative_uri = "/"+relative_uri_arr[1];

    if (baseURL.indexOf('http://localhost') != -1) {
        // Base Url for localhost
        var url = location.href;  // window.location.href;
        var pathname = location.pathname;  // window.location.pathname;
        var index1 = url.indexOf(pathname);
        var index2 = url.indexOf("/", index1 + 1);
        var baseLocalUrl = url.substr(0, index2);

        return baseLocalUrl + '/' + add_sub_dir + addition_url;
    } else {
        if(relative_uri_arr[2].length == 2) {
            lang_abbr = relative_uri_arr[2] + '/';
        }

        return baseURL + '/' + add_sub_dir + lang_abbr + addition_url;
    }
    */
    return 'http://localhost:3000/' + addition_url;
}

function go_to(addition_url) {
    location.href = site_url(addition_url);
}

console.log(site_url());
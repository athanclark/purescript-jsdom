"use strict";

var jsdom = require('jsdom');

exports.mkJsdomImpl = function mkJsdomImpl (html,options) {
    return new jsdom.default(html,options);
};

exports.mkResourceLoaderImpl = function mkResourceLoaderImpl (options) {
    return new jsdom.ResourceLoader(options);
};

exports.virtualConsole = function virtualConsole () {
    return new jsdom.VirtualConsole();
};

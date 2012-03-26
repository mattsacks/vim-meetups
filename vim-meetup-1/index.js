var activateNav;

activateNav = function(e, from, to) {
  if (to === 0) {
    return this.element.removeClass('show');
  } else if (from === 0) {
    this.element.addClass('show');
  }
  this.subnavs.filter('.active').removeClass('active');
  this.subnavs.eq(to - 1).addClass('active');
  if (to >= 3 && to < 14) {
    return this.subnav.addClass('active');
  } else {
    return this.subnav.removeClass('active');
  }
};

$(document).live('deck.change', function() {
  return activateNav.apply(window.nav, arguments);
});

$(document).live('keyup', function(e) {
  var numIndex;
  numIndex = numKeys.indexOf(e.keyCode);
  if (numIndex !== -1) {
    return $.deck('go', numIndex);
  } else if ([72, 75, 80].indexOf(e.keyCode) !== -1) {
    return $.deck('prev');
  } else if ([74, 76, 78].indexOf(e.keyCode) !== -1) {
    return $.deck('next');
  }
});

$(function() {
  var tempNav;
  tempNav = $('#nav');
  window.nav = {
    element: tempNav,
    subnav: tempNav.find('ul.subnav'),
    subnavs: tempNav.find('li')
  };
  window.numKeys = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57];
  return window.deck = {
    slides: $('.slide')
  };
});

var pad = function(i){
  if(i < 10){
    return "0" + i
  } else {
    return i
  }
}

var clock = function(){
  setTimeout(function(){
    date = new Date()
    str = pad(date.getHours()) + ":" + pad(date.getMinutes()) + ":" + pad(date.getSeconds())
    $('#clock').text(str)
    clock()
  }, 200)
}

$(function(){
  clock()
})

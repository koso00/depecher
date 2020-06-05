console.log("BIG WORKER SCRIPT");

var noExtra = function(s){return s.replace(/\ufe0f/gm, '');}///\ufe0f|\u200d/gm, ''
var toSurrogatePairs = function(r){for(var t="",n=0;n<r.length;n++)t+="\\u"+("000"+r[n].charCodeAt(0).toString(16)).substr(-4);return t}
var toCodePoint = function(t){for(var n=[],r=0,o=0,h=0;h<t.length;)r=t.charCodeAt(h++),o?(n.push((65536+(o-55296<<10)+(r-56320)).toString(16)),o=0):r>=55296&&56319>=r?o=r:n.push(r.toString(16));return n.join("-")}

var re = /(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])/gm
var parseText = function (txt){
  var path = "/usr/share/depecher/qml/assets/emoji/";
  var alt = false;
  var eclass = "";
  var ext = "png";
      return txt.replace(re, function (a, b) {
          var r = '<img draggable="false"';
          r += (eclass)?' class="'+eclass+'"':'';
          r += (alt)?' alt="'+b+'"':'';
          r += ' src="'+path+toCodePoint(noExtra(b))+'.'+ext+'">';
          //var r = '<img height="50" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAACylBMVEUAAAAAAAD/AAD/AAA5HDnpKDLpJzHnKDE0MD4vKznoJzLjHBwvKzkuKjkyLzvpJzEwLToyLjznJzLnJzHoJzLrKDLqKTP/AADoJjLqKDPnJzHmJzLoKDPnKDDnJzHkJzLMGhrpJzPpKDLoKDToKDLmJTDlJzHpKDLnKDLkKDDqJzDoKDLlJTDkJjDRFy7kJjDmKDI6NUM4NEI4M0E4NELoJzLpKDI4NUE3M0E4NEIzMz/qJzI1MT5VVVU2MkA2MkA0MD7lJTE1MUDlJjE1MT81MT8zMzM2MTwzMD7lJzIzLz4yLjwxLj0AAAAxLj0yLTkxLjowLTowLTowLDo5NUQwLDsvKzsvLDgwLDkwLDw3NEE2MkD73zblJzHmJzH43DXmJzI0MD7oJzIzLz04NUP84DZnXTtFQEDmLjHlKzE1MT/zjzSnlTf62jbOtzX2uDU8OD+kkjnpOjLqWjL31jToVDH1xzXmzTS4pDhkWz/LtTby2DRQSUAwLTrmRTEvLDntYzLnLjLoOzL1pDXawjQ7NkD0jjRrYTzWvjeXhzj93jdjWj05NUGynjrozjREP0D52jb02DJLRUD4tTWmlDftXjN0aTzoPzLw1jLxkTTdxDTu0zPt0zXIsjbMtTWSgjq9qjb82DftYDP83TbpPzLpKDKLfT3tbDPnKDP3xDZuZD/y1zK0oDd8cDvPuDWmlDhJRD7nLDL1qDUxLjuDdj05NkOOfzzAqzjx1jHTuzSJezm9qTU2Mj9IQz2llDi4ozXjJjDqVzPsYjLnJzJVTjw4ND9zaDrYwTNwZTrtXDPwbjQ4NEHrXDPwgzNVTTzjyTFCPD3vgTTmKjKLfTtOSDo0MT3wbjPr0TTcxDXubjPmLzHsXTNPRz7seDLzkzTykTQyLjz0vzT50jb81zbrXjLxezXTvDZ9cTz3rDZ2aT5HQ0H32zXlKjH52TaWL9ttAAAAWnRSTlMAAgMCCerJP/76/gnqyVb66v7+fZCLgwFX44jreUDpQgqr61nlj8usi8iP5On5C/h6+Ovqynvlx5GOQVY+A+vqe1l4kuPlClmL64itrAGGjljk43v5ekGRkED+iOEMAAAB2klEQVR4XpXQY49kQRgF4OqexnDHtte2bXtv2z22bXNt27Zt2/Z/2LpzC9M9nWzm+XRy3pNUUqAd+P5uIqGjo1DUWcwHbdn1C9lKCP3sgJlR/dUmvL1Mzp4etmoztu5WgLCKVFsQTBcdL7eSTJIPQEIvU7cWfy7H2WUIdw/qsoO6+aN649dnqAjrDliuSqqwSFlcotu8BRU9AcT3VVKHNsEQo1t6kCsC2B8LlBOXPkmlCcvljxLi3qNGDAdj5NRLadwrGF5L36EiHA4iZFhU1Mo7d1Ng+PP3Iao6wcEkMviy3SiTGdm0s/EiV3WFg24XsLepaSilf8znQg84mKvFdinW/GwJv35vQ1UvOOitJeoUlUeOwnBMcRw1feCgL0Pcfvz8RZKBaa7/9h01A+BgID431DKMISkjMys7Jxd3g+BgsIRTFh9fkSiR1Kxdt37DGwkyFA6GDUeLZSuaVpeu2r1n7779B1A1ggegkdGcxNglVSdOnjp95uy583quGg1YgrHRhP4KG65eu36DLcaNBy0mWKvM3bv/QKWy7gCQiZo2njzVaCYDjDflgwVTeYCYNt35sBnnGeiOzJyVZ2I2ep8SzHEqIJzmCUBbvPkLHOxtbOwdFi6ir//fPxBZV484NAs9AAAAAElFTkSuQmCC" />'
          return r;
      });
}

WorkerScript.onMessage = function(message) {
    console.log(message.type)
    // ... long-running operations and calculations are done here
    WorkerScript.sendMessage({id : message.id ,type : message.type,text : parseText(message.text)})
}

/**
 * Created by wsharp on 6/3/15.
 */
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
};

Array.prototype.capitalize = function() {
    return this.map(function(i) {
        return i.capitalize();
    })
};
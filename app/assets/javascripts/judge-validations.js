/**
 * Created by wsharp on 6/3/15.
 */
var asyncValidateInput, judgeValidateForm;

asyncValidateInput = function(elm) {
    var dfd, q;
    dfd = new $.Deferred;
    q = judge.validate(elm, function(element, status, messages) {
        if (status === 'valid') {
            $(element).closest('.form-group').removeClass('has-error');
            $(element).parent().find('.help-block').remove();
            dfd.resolve();
        } else if (status === 'invalid') {
            $(element).closest('.form-group').addClass('has-error');
            $(element).after('<span class="help-block">' + messages.capitalize().join(',') + '</span>');
            dfd.reject();
        }
    });
    if (q.validations.length === 0) {
        dfd.resolve();
    }
    return dfd;
};

judgeValidateForm = function(frm) {
    $(frm).submit(function(e) {
        var defers;
        e.preventDefault();
        $(frm).find('.help-block').remove();
        defers = [];
        $(frm).find('.form-control[data-klass]').each(function(idx, elm) {
            defers.push(asyncValidateInput(elm));
        });
        $.when.apply($, defers).done(function() {
            $(frm).unbind('submit');
            $(frm).submit();
        });
        $.when.apply($, defers).fail(function() {
            return Metronic.scrollTo($('.page-title'));
        });
    });
};

$(document).ready(function(){
    judge.eachValidators.not_in_past = function(options, messages) {
        var errorMessages = [];

        if ((this.value !== "") && this.value < moment().format('MM/DD/YYYY')) {
            errorMessages.push(messages.not_in_past);
        }
        return new judge.Validation(errorMessages);
    };
});

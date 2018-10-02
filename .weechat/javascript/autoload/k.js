// Kirjava's WeeChat formatting DSL
// github.com/kirjavascript

// Array.from polyfill
Array.from||(Array.from=function(){var toStr=Object.prototype.toString,isCallable=function(fn){return"function"==typeof fn||"[object Function]"===toStr.call(fn)},toInteger=function(value){var number=Number(value);return isNaN(number)?0:0!==number&&isFinite(number)?(number>0?1:-1)*Math.floor(Math.abs(number)):number},maxSafeInteger=Math.pow(2,53)-1,toLength=function(value){var len=toInteger(value);return Math.min(Math.max(len,0),maxSafeInteger)};return function(arrayLike){var C=this,items=Object(arrayLike);if(null==arrayLike)throw new TypeError("Array.from requires an array-like object - not null or undefined");var T,mapFn=arguments.length>1?arguments[1]:void 0;if("undefined"!=typeof mapFn){if(!isCallable(mapFn))throw new TypeError("Array.from: when provided, the second argument must be a function");arguments.length>2&&(T=arguments[2])}for(var kValue,len=toLength(items.length),A=isCallable(C)?Object(new C(len)):new Array(len),k=0;k<len;)kValue=items[k],mapFn?A[k]="undefined"==typeof T?mapFn(kValue,k):mapFn.call(T,kValue,k):A[k]=kValue,k+=1;return A.length=len,A}}());
// Array#reverse polyfill
Array.prototype.reverse = function() { var stack = [], n = this.length; for(var i=n-1;i>=0;i--) { stack.push(this[i]) ; } return stack; }

// taken from babel
function consume(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

var rainbow = ['r', 'o', 'y', 'dg', 'b', 'db', 'dp'];
var sup = ' ᴬᴮᶜᴰᴱᶠᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾQᴿˢᵀᵁⱽᵂˣʸᶻᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖqʳˢᵗᵘᵛʷˣʸᶻ⁰¹²³⁴⁵⁶⁷⁸⁹';
var full = ' ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ０１２３４５６７８９';
var flip = ' ∀qƆpƎℲפHIſʞ˥WNOԀQɹS┴∩ΛMX⅄Zɐqɔpǝɟƃɥᴉɾʞlɯuodbɹsʇnʌʍxʎz0ƖᄅƐㄣϛ9ㄥ86';
var normal = ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
var symbols = {
    // reset
    '/': '\u000f',
    // formatting
    u: '\u001f',
    bo: '\u0002',
    i: '\u001D',
    nl: '\x12',
    bell: '\x07',
    lambda: 'λ',
    // emote
    shrug: "¯\\_(ツ)_/¯",
    actually: "(~˘▾˘)~",
    happy: "(• ◡•)",
    daww: "(◕‿◕✿)",
    ayy: "☜(ﾟヮﾟ)☜",
    love: "( ˘ ³˘)♥",
    lenny: "( ͡° ͜ʖ ͡°)",
    lenny2: "( ͡º ͜ʖ ͡º)",
    wink: "( ͡~ ͜ʖ ͡°)",
    cool: "(⌐■_■)",
    bh: "ヘ（。□°）ヘ",
    notes: "♪♫",
    normal: "(¬●_ ●)",
    lod: "ಠ_ಠ",
    table: "(╯°□°）╯︵ ┻━┻",
    sad: "ʘ︵ʘ",
};

// (default、black、(dark)gray、white、(light)red、(light)green、brown、yellow、(light)blue、(light)magenta、(light)cyan)
var codes = {
    r: '04',
    dr: '05',
    w: '00',
    bl: '01',
    c: '11',
    dc: '10',
    b: '12',
    db: '02',
    g: '09',
    dg: '03',
    p: '13',
    dp: '06',
    o: '07',
    y: '08',
    gr: '15',
    dgr: '14',
};

function parse(text) {
    var rainbowIndex = 0;

    if (typeof text != 'string') {
        text = text && typeof text.toString == 'function' ? text.toString() : '';
    }

    return text
    // multiline
    .split('\n').reduce(function (a, c) {
        var lastLine = a[a.length - 1];
        if (lastLine) {
            var matches = lastLine.match(/{(.*?)}/g);
            var last = matches && matches.pop();
            return [].concat(consume(a), [last ? last + c : c]);
        } else {
            return [].concat(consume(a), [c]);
        }
    }, []).join('\n')
    // flip
    .replace(/{flip}(.*?)({(.*?)}|$)/gm, function (str, key, key2) {
        return consume(key).map(function (ch, i) {
            return flip[normal.indexOf(ch)] || ch;
        }).reverse().join('') + key2;
    })
    // fullwidth
    .replace(/{full}(.*?)({(.*?)}|$)/gm, function (str, key, key2) {
        return consume(key).map(function (ch, i) {
            return full[normal.indexOf(ch)] || ch;
        }).join('') + key2;
    })
    // superscript
    .replace(/{sup}(.*?)({(.*?)}|$)/gm, function (str, key, key2) {
        return consume(key).map(function (ch, i) {
            return sup[normal.indexOf(ch)] || ch;
        }).join('') + key2;
    })
    // rainbow
    .replace(/{rb}(.*?)({(.*?)}|$)/gm, function (str, key, key2) {
        return consume(key).map(function (ch, i) {
            if (ch != ' ') return "{" + rainbow[rainbowIndex++ % rainbow.length] + "}" + ch;
            else return ch;
        }).join('') + key2;
    })
    // emoji
    .replace(/{(.*?)}/g, function (str, key) {
        if (!symbols[key]) {
            return str;
        } else {
            return symbols[key];
        }
    })
    // fg
    .replace(/{(.*?)}/g, function (str, key) {
        if (!codes[key]) {
            return str;
        } else {
            return '\x03' + codes[key];
        }
    })
    // fg & bg
    .replace(/{(.*?),(.*?)}/gm, function (str, key1, key2) {
        var _ref = [key1.trim(), key2.trim()],
            a = _ref[0],
            b = _ref[1];

        if (codes[a] && codes[b]) {
            return "\x03" + codes[a] + "," + codes[b];
        } else {
            return str;
        }
    });
}

weechat.register('formatDSL', 'Kirjava', '0.1', 'Public Domain', 'JS script', '', '');
weechat.hook_command('f', 'format', '', '', '', 'callback_format', '');
function callback_format(data, buffer, args) {
    var parsed = parse(args);
    parsed.split('\x12').forEach(function (text) {
        weechat.command('', '/say ' + text);
    });
    return weechat.WEECHAT_RC_OK;
}
weechat.hook_command('fi', 'format input', '', '', '', 'callback_formatInput', '');
function callback_formatInput(data, buffer, args) {
    weechat.command('', '/input delete_line');
    weechat.command('', '/input insert /f ' + parse(args));
    return weechat.WEECHAT_RC_OK;
}
weechat.hook_command('fl', 'format list', '', '', '', 'callback_formatList', '');
function callback_formatList(data, buffer, args) {
    weechat.print('', 'codes: ' + Object.keys(codes).join(', '));
    weechat.print('', 'symbols: ' + Object.keys(symbols).join(', '));
    return weechat.WEECHAT_RC_OK;
}

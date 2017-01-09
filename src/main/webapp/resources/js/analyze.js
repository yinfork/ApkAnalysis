var second = 50; //间隔时间1秒钟
function requestOutput(basepath) {
    $.get(basepath+"/result",function(data,status){
        $("#output").html(data);
    });
}


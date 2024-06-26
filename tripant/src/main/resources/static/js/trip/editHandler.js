

// 시간 설정 모달 열림
function timeRangeBtnClickHandler(thisElement) {
	$(thisElement).children(".timerange").addClass('hide');
	$(thisElement).parents('.spot-block').children(".timerange-modal").removeClass('hide');
}

// 시간 설정 완료
function timeDoneBtnClickHandler(thisElement) {
	$(thisElement).parents('.spot-block').children(".timerange").removeClass('hide');
	$(thisElement).parents(".timerange-modal").addClass('hide');

	var hours = $(thisElement).parent().children('.spot-hours').val();
	var mins = $(thisElement).parent().children('.spot-mins').val();
	var idx =  $(thisElement).parents('.spot-block').data('idx');
	
	var timeVal = hours*3600 + mins*60;
	console.log("timeVal");
	console.log(timeVal);
	
	changeStayTime= JSON.parse(editStorage.getItem(idx));
	changeStayTime.stayTime=timeVal;
	
	console.log(editStorage.setItem(idx,JSON.stringify(changeStayTime)));
	
	$(thisElement).parents('.spot-block').find('.timerange').text(timeVal);
}

let editArr = [];

function displayEditInfo(){
	sessionLength = editStorage.length;
	for(var i = 0 ; i<sessionLength ; i++){
		let obj = JSON.parse(editStorage.getItem(i));
		let objKey = obj.travelOrder;
		
		let existArr = editArr.find(arr => arr[0].a ===objKey); 
		if(!existArr){
			editArr.push([obj]);
		}else{
			existArr.push(obj);
		}
	}
	console.log(editArr);
}

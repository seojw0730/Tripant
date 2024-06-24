 /* 편집 취소 저장 */
function editHandler(){
	$(this).next().show(); //취소 버튼 활성화
	$(this).parent().prevAll().find('.dayn').not(':first').hide(); //n일차 btn 숨김
	$(this).hide(); //편집 숨김
	//저장btn 활성화 css변경
	$(this).siblings('.save').attr('disabled',false);
	
	$(this).parents().find('.tourlist').addClass('hide');
	$(this).parents().find('.edit-tourlist').removeClass('hide');
	setBounds(); //지도 리로드
}
function cancelHandler(){
	$(this).hide(); //취소 숨김
	$(this).prev().show(); //편집 보여줌
	$(this).siblings('.save').attr('disabled',true); //저장 비활성화
	$(this).parent().prevAll().find('.dayn').show(); //n일차 btn 보여줌
	
	$(this).parents().find('.tourlist').removeClass('hide');
	$(this).parents().find('.edit-tourlist').addClass('hide');
	setBounds(); //지도 리로드
}
function saveHandler(){
	$(this).siblings('.cancel').hide(); //취소 숨김
	$(this).siblings('.edit').show(); //편집 보여줌
	$(this).attr('disabled',true); //저장 비활성화
	$(this).parent().prevAll().find('.dayn').show(); //n일차 btn 보여줌
	//일정 목록보여주기
	$(this).parents().find('.tourlist').removeClass('hide');
	$(this).parents().find('.edit-tourlist').addClass('hide');
	setBounds(); //지도 리로드
	//DB이동 ajax
}
function navHandler(){
	//좌측 탭
	$('.dayn a').click(function() {
		$('.dayn > div').hide().filter(this.hash).fadeIn();
		$('.dayn a').css("color", "black");
		$('.dayn a').removeClass('active');
		$(this).addClass('active');
		
		var cls_name = $(this).attr("class");
		cls_name = cls_name.replace(' active', '');
/*		if (cls_name == 'nav-1') {
			$(".main-wrapper .tab-content").css("width", "25%");
		} else {
			$(".main-wrapper .tab-content").css("width", "40%");
		}*/

		$(this).css("color", "#4BC9E5");
		return false;
	}).filter(':eq(0)').click();
}
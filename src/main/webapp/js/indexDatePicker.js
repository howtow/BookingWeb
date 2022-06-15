//首頁的Datepicker
	$("#datepicker1,#datepicker2").datepicker({ dateFormat: 'yy/mm/dd', minDate: new Date(), maxDate: "+90D"});
	$("#datepicker1").change(function(){
		let mindate = this.value;
		$('#datepicker2').datepicker('option',{ minDate: new Date(mindate)})
	})
	$("#datepicker2").change(function(){
		let mindate = this.value;
		$('#datepicker1').datepicker('option',{ maxDate: new Date(mindate)})
	})
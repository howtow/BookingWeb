$(document).ready(function (){
    $.getJSON("http://localhost:8080/Booking/hotelManage1",function (data){
        let hotel_data='';
        $.each(data,function (key,value){
            hotel_data += '<tr>';
            hotel_data += '<td>'+value.hotelId+'</td>';
            hotel_data += '<td>'+value.hotelName+'</td>';
            hotel_data += '<td>'+value.description+'</td>';
            hotel_data += '<td>'+value.add+'</td>';
            hotel_data += '<td>'+value.Tel+'</td>';
            hotel_data += '<td>'+value.serviceinfo+'</td>';
            hotel_data += '<td>'+value.totalNumberofRooms+'</td>';
            hotel_data += '<td>'+value.lowestPrice+'</td>';
            hotel_data += '<td>'+value.ceilingPrice+'</td>';
            hotel_data += '</tr>';
        });
        $('#hotelTable').append(hotel_data);
    })
})
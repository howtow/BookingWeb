var px = document.getElementById('px').value
var py = document.getElementById('py').value
var name = document.getElementById('name').value

//載入小地圖(起始點座標)
var map;
map = L.map('map').setView([px, py], 15);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '<a href="https://www.openstreetmap.org/">OSM</a>',
    maxZoom: 18,
}).addTo(map);
//載入小地圖座標定位
var marker = L.marker([px, py]);
marker.addTo(map);

//載入大地圖
var bigMap;
bigMap = L.map('bigMap').setView([px, py], 15);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '<a href="https://www.openstreetmap.org/">OSM</a>',
    maxZoom: 18,
}).addTo(bigMap);
//載入大地圖座標定位
var marker2 = L.marker([px, py]);
marker2.addTo(bigMap)
.bindPopup(name);
//點擊顯示大地圖
let btn=document.querySelector("#show");
let infoModal=document.querySelector("#infoModal");
let close=document.querySelector("#closebtn");
btn.addEventListener("click", function(){
	window.dispatchEvent(new Event('resize'));
    infoModal.showModal();
})
close.addEventListener("click", function(){
    infoModal.close();
})
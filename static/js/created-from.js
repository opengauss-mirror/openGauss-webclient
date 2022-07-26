$(document).ready(function () {
  function showCreatedContent(id) {
    $(".created-content>div,.created-content>ul").hide();
    $(`.created-${id}`).show();
    $(`.created-content>.alert`).show();
  }
  // 新建表格中的表格导航点击事件
  $(".created .created-choose li").on("click", function () {
    $(".created .created-choose li.active").removeClass("active");
    $(this).addClass("active");
    showCreatedContent($(this).attr("id"));
  });
  // 新建表格中的表格导航点击事件
  $(".created-close").on("click", function () {
    $(".created").hide();
  });
  // 新增列
  let order=1
  $(".columns-add").on("click", function () {
    $(".columns-content").append(`<ul class="columns-list">
    <li>${order}</li>
    <li><input type="text"></li>
    <li><input type="text"></li>
    <li><input type="text"></li>
    <li><input type="text"></li>
    <li><input type="text"></li>
    <li><input type="text"></li>
  </ul>`);
  order++;
  });
  
});

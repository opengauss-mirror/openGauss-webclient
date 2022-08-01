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
    <li>
      <select id="selected_column_type">
        <option value="TINYINT">TINYINT</option>
        <option value="SMALLINT">SMALLINT</option>
        <option value="INTEGER">INTEGER</option>
        <option value="BIGINT">BIGINT</option>
        <option value="NUMERIC">NUMERIC</option>
        <option value="BOOLEAN">BOOLEAN</option>
        <option value="VARCHAR">VARCHAR</option>
        <option value="TEXT">TEXT</option>
        <option value="DATE">DATE</option>
        <option value="TIMESTAMP">TIMESTAMP</option>
      </select>
    </li>
    <li>
      <select id="column_not_null">
        <option value="NOT NULL">YES</option>
        <option value="NULL">NO</option>
      </select>
    </li>
    <li>
      <select id="column_primary_key">
        <option value="PRIMARY KEY">YES</option>
        <option value="">NO</option>
      </select>
    </li>
    <li><input type="text"></li>
    <li><input type="text"></li>
  </ul>`);
  order++;
  });
  
});

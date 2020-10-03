$(document).ready(function(){

  // ユーザーの誕生日の閏年を動的に変化させる
  // 誕生日の配列を宣言
  let birth_year = [];
  let birth_month = [];
  let months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  // 現在の年を取得する
  let date = new Date();
  let this_year = date.getFullYear();
  let oldest_year = 1900;

  // 誕生年月の配列を自動生成
  for (var i = this_year; i >= oldest_year; i--) {
    var year = { var: i, txt: String(i) };
    birth_year.push(year);
  }
  for (var i = 1; i <= 12; i++) {
    var month = { var: i, txt: String(i) };
    birth_month.push(month);
  }
  for (var i = 0; i < birth_year.length; i++) {
    $("<option>",{
      value: birth_year[i].var,
      text: birth_year[i].txt
    }).appendTo('#select-year');
  }
  for (var i = 0; i < birth_month. length; i++) {
    $("<option>", {
      value: birth_month[i].var,
      text: birth_month[i].txt
    }).appendTo('#select-month');
  }

  // 年、もしくは月のセレクトボックスの中身に変更があったら日の内容を変更する
  $('#select-year, #select-month').change(function(){
    // 日が入っているセレクトボックスの中身を空っぽにする
    $('#select-day').empty();
    // 日が入るセレクトボックスにデフォルト値の'----'をいれる
    $("<option>", {
      text: '----'
    }).appendTo('#select-day');
    // 2月の日にち、すなわちmonths[1]を28にセットし直す
    months[1] = 28;
    // 年と月に入力されている情報を取得する
    let year = $('#select-year').val();
    let month = $('#select-month').val();
    // yearとmonth共に数字が入力されている。すなわち共に'----'出ない時に実行
    if (year !== '----' && month !== '----') {
      // monthに２月が選択されている時実行
      if (month == 2) {
        // yearが閏年の時、２月の日付が格納されているmonths[1]の値を29にする
        if (year % 4 === 0 && year % 100 === 0 && year % 400 == 0) {
          months[1] = 29;
        }
      }
      // 日を入れる配列を宣言し、閏年を考慮したデータを格納して反映させる
      let birth_day = []
      for (var i = 1; i <= months[month - 1]; i++) {
        var day = { var: i, txt: String(i) };
        birth_day.push(day);
      }
      for (var i = 0; i < birth_day. length; i++) {
        $('<option>',{
          value: birth_day[i].var,
          text: birth_day[i].txt
        }).appendTo('#select-day');
      };
    };
  });
});

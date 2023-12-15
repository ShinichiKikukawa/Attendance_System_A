module UsersHelper

  def format_basic_info(time) # 勤怠基本情報を指定のフォーマットで返します。
   format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
end

Rails.application.routes.draw do
  
  root 'static_pages#top' # トップページ
  get '/signup', to: 'users#new' #新規登録
  
  get    '/login', to: 'sessions#new' # ログイン機能
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  
  resources :users do
    collection { post :import}
    member do
      get 'edit_basic_info' # 基本情報の編集
      patch 'update_basic_info'

      #get 'attendances/edit_one_month' # １ヶ月分の変更申請    
      #patch 'attendances/update_one_month' 
      get 'attendances/edit_one_month_request' # 1ヶ月分の勤怠申請・承認
      patch 'attendances/update_one_month_request'
      get 'attendances/edit_one_month_approval'
      patch 'attendances/update_one_month_approval_'
        
      get 'attendances/edit_attendance_change_request' # 個々の勤怠変更申請・承認
      patch 'attendances/update_attendance_change_request'
      get 'attendances/edit_attendance_change_approval'
      patch 'attendances/update_attendance_change_approval'
        
      get 'attendances/edit_overtime_request' # 残業申請・承認
      patch 'attendances/update_overtime_request'
      get 'attendances/edit_overtime_approval'
      patch 'attendances/update_overtime_approval'

      get 'attendances/attendance_confirmation'  # 上長勤怠確認
        
      get 'attendances/attendance_log' # 勤怠ログ

      get 'at_work'# 出勤中社員一覧
    end
    
    resources :attendances, only: :update
    collection do
      get :at_work
    end
  end

  resources :bases, except: :show # 拠点
end

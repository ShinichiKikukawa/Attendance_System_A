Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'  # ログイン機能
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month' # この行が追加対象です。
      get 'at_work' # 出勤中社員一覧

      
      get 'attendances/edit_one_month_request'# 1ヶ月の勤怠申請・承認
      patch 'attendances/update_one_month_request'
      get 'attendances/edit_one_month_approval'
      patch 'attendances/update_one_month_approval'
      
      get 'attendances/edit_attendance_change_request'# 個々の勤怠変更申請・承認
      patch 'attendances/update_attendance_change_request'
      get 'attendances/edit_attendance_change_approval'
      patch 'attendances/update_attendance_change_approval'
      
      get 'attendances/edit_overtime_request'# 残業申請・承認
      patch 'attendances/update_overtime_request'
      get 'attendances/edit_overtime_approval'
      patch 'attendances/update_overtime_approval'
      
      get 'attendances/attendance_confirmation'# 上長勤怠確認
      
      get 'attendances/attendance_log'# 勤怠ログ
    end

    resources :attendances, only: :update
    collection { post :import}
    collection do
      get :at_work
    end
  end

  resources :bases, except: :show

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
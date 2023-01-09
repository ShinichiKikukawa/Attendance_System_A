Rails.application.routes.draw do
  
  root 'static_pages#top' # トップページ
  get '/signup', to: 'users#new' #新規登録
  
  get    '/login', to: 'sessions#new' # ログイン機能
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  
  resources :users do
    collection {post :import} 
    member do
      get 'edit_basic_info' # 基本情報の編集
      patch 'update_basic_info'

      get 'attendances/edit_one_month' # １ヶ月分の変更申請    
      patch 'attendances/update_one_month' 
      
      get 'attendances/edit_one_month_request'# １ヶ月分の勤怠申請
      patch 'attendances/update_month_request'
      
      get 'list_of_employees_at_work'# 出勤中社員一覧

    end
    
    resources :attendances, only: :update do 
      member do

        get 'edit_overtime_request' # 残業申請
        patch 'update_overtime_request'
       
        get 'edit_overtime_approval' # 残業承認
        patch 'update_overtime_approval'
       
        get 'edit_working_hours_approval' # 勤怠承認
        patch 'update_working_hours_approval'
        
        get 'edit_one_month_approval' # 1ヶ月の勤怠承認
        patch 'update_one_month_approval'
        
        get 'log_page' # 勤怠ログ
      end
    end
  end

  resources :bases # 拠点
end

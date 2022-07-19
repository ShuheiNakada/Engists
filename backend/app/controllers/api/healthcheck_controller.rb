### ヘルスチェックは前段のNginxでステータス200を返し対応
### (Railsコンテナでも2重チェックできるようにnginx転送設定を調査する)
module Api
  class HealthcheckController < ApplicationController
    def index
      head :ok
    end
  end
end

require 'rails_helper'

RSpec.describe "PostsApis", type: :request do
  describe "GET /posts" do
    it '記事の全件取得' do
      # spec/factories/posts.rbで定義したテストデータを10件複製(配列)
      FactoryBot.create_list(:post, 10)
      # /postsのエンドポイントへGETリクエスト
      get '/posts'
      # 返り値( render json: @posts)を変数に格納
      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
      # 10件のデータが返ってきているかを確認
      expect(json.length).to eq(10)
    end
  end

  describe 'GET /posts/:id' do
    it '特定の記事を取得する' do
      # テストデータを1件作成
      post = create(:post, title: "サンプル記事")
      # /posts/#{post.id}へGETリクエスト
      get "/posts/#{post.id}"
      # 返り値を変数へ格納
      json = JSON.parse(response.body)
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
      # テストデータで作成した値が返ってきているかを確認
      expect(json["title"]).to eq(post["title"])
    end
  end

  # describe 'Post /posts' do
  #   # リクエストで送られてくるテストデータ
  #   before do
  #     @post_create_params = {
  #         title: "新規投稿"
  #     }
  #   end
  #   it '新しいタスクを作成する' do
  #     # 受け取ったテストデータをパラメタとし新規作成
  #     # Postデータが作成されているかをテスト(件数が1つ増えているか)
  #     expect { post '/posts', params: @post_create_params  }.to change(Post, :count).by(+1)
  #     expect(response.status).to eq(201)
  #   end
  # end

  # describe "PUT /posts/:id" do
  #   it '記事の更新' do
  #     # 更新対象のテストデータを作成
  #     post = create(:post)
  #     # 更新用のリクエストデータ
  #     @post_update_params = {
  #       title: "更新しました"
  #     }
  #     # PUTリクエスト
  #     put "/posts/#{post.id}", params: @post_update_params

  #     expect(response.status).to eq(200)
  #     # 更新後のデータとリクエストデータが一致しているかを確認
  #     expect(post.reload.title).to eq(@post_update_params[:title])
  #   end
  # end

  describe 'Delete /posts/:id' do
    it '記事をを削除する' do
      # テストデータを1件削除
      post = create(:post)
      # DLETEにリクエストを送る
      # 作成したテストデータが削除されている事を確認
      expect { delete "/posts/#{post.id}" }.to change(Post, :count).by(-1)
      # リクエスト成功を表す204が返ってきたか確認する。
      expect(response.status).to eq(204)
    end
  end
end

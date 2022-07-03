class Public::SearchesController < ApplicationController
  def search
    @model = params["model"] # 選択したmodelの値を@modelに代入
    @content = params["content"] # 検索ワードを@contentに代入
    @method = params["method"] # 選択した検索方法の値を@methodに代入
    @records = search_for(@model, @content, @method) # 上3つを代入した、search_forを@recordsに代入
  end

  private

  def search_for(model, content, method)
    if model == 'customer'
      if method == 'perfect'  # 選択した検索方法がが完全一致だったら
        Customer.where(name: content)
      elsif method == 'partial'# 選択した検索方法がが部分一致だったら
        # Customer.where('name LIKE ?', '%'+'content'+'%')
        Customer.where("name LIKE?","%#{content}%")
      else
        Customer.all
      end
    elsif model == 'post_image'
      if method == 'perfect'  # 選択した検索方法がが完全一致だったら
        PostImage.where(title: content)
      elsif method == 'partial' # 選択した検索方法がが部分一致だったら
        PostImage.where("title LIKE?","%#{content}%")
      else
        PostImage.all
      end
    end
  end

end

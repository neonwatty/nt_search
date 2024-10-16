class NewTestWordsController < ApplicationController
  rate_limit to: 20, within: 1.minute, only: [ :search ], with: -> { redirect_to root_path, alert: "Too many requests. Please try again" }

  def search
    @query = search_params["query"]
    @words = NewTestWord.search_any_word(@query).limit(10) || []
    @words = @words.sort_by { |word| [-word.chapter_number, -word.verse_number] }
    respond_to do |format|
      format.turbo_stream do
        if @query.blank?
          render turbo_stream: turbo_stream.update("search_results", partial: "new_test_words/no_search")
        else
          render turbo_stream: turbo_stream.update("search_results", partial: "new_test_words/search_results", locals: { words: @words })
        end
      end
    end
  end


  private

  def search_params
    params.permit([ :query, :authenticity_token, :source, :controller, :action ])
  end

end

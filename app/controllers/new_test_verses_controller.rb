class NewTestVersesController < ApplicationController
  rate_limit to: 20, within: 1.minute, only: [ :search ], with: -> { redirect_to root_path, alert: "Too many requests. Please try again" }

  def search
  end

  def search_items
    @query = search_params["query"]
    @query = remove_stopwords(@query)
    @verses = NewTestVerse.search_any_word(@query).limit(10) || []
    # @words = @words.sort_by { |word| [-word.chapter_number, -word.verse_number] }

    respond_to do |format|
      # resopnd to turbo
      format.turbo_stream do
        if @query.blank?
          render turbo_stream: turbo_stream.update("search_results", partial: "new_test_verses/no_search")
        else
          render turbo_stream: turbo_stream.update("search_results", partial: "new_test_verses/search_results", locals: { verses: @verses, query: @query })
        end
      end

      # Handle HTML format or other formats
      format.html do
        # Redirect or render a specific view if needed
      end

      # Optionally handle other formats like JSON
      format.json { render json: @words }
    end
  end


  private

  def search_params
    params.permit([ :query, :authenticity_token, :source, :controller, :action ])
  end

  def remove_stopwords(input_string)
    stopwords = %w[i me my myself we our ours ourselves you your yours yourself yourselves he him his himself she her hers herself it its itself they them their theirs themselves what which who whom this that these those am is are was were be been being have has had having do does did doing a an the and but if or as until while of at by for with above below to from up down in out on off over under how all any both each few more most other some such no nor not only own same so than too very s]

    words = input_string.split
    filtered_words = words.reject { |word| stopwords.include?(word.downcase) }
    
    filtered_words.join(' ')
  end

end

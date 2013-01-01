class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  

  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    #@comment = Comment.find_by_number(params[:id], params[:board_id])
    @comments = Comment.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    #@comment = Comment.find_by_number(params[:id], params[:board_id])
    @comments = Comment.find(params[:id])

  end

  # POST /comments
  # POST /comments.json
  def create
   @node = Node.find(params[:node_id])
   @board = @node.board
   @comment = @node.comments.create(params[:comment])
   respond_to do |format|

   if @comment.save
      @comment.ip = getIp
      @comment.formated_date = @comment.created_at.strftime("%d %b %Y, %H:%M")
      @comment.number = @board.post_counter.to_int + 1
      @comment.save
    #Порядок выборки определяется датой последнего комментария. Пишем в заголвке сажу - не обновляем поле
      if @comment.head!="sage"
        @node.last_comment = @comment.created_at # update last_comment field in nodes table
        @node.save
      end
      @board.post_counter = @comment.number
      @board.save
      
      format.html { redirect_to node_path(@node), :notice => 'Comment was successfully created.' }
      # May be some problems
      format.json { render :json => @comment, :status => :created, :location => @comment }
    else
      format.html { redirect_to node_path(@node), :notice => 'There was some errors.' }
      format.json { render :json => @comment.errors, :status => :unprocessable_entity }
    end
  end
end
  # PUT /comments/1
  # PUT /comments/1.json
  def update
  @comments = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, :notice => 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @node = Node.find(params[:node_id])
    @comment = @node.comments.find(params[:id])
    @comment.destroy
    redirect_to node_path(@node)
  end
end

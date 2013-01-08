class BoardsController < ApplicationController
  # GET /boards
  # GET /boards.json
  #
  attr_accessor :board_list, :board_nodes
  $nodes_per_page = 10
  def index
    @board_list = Board.all
    @boards = Board.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board_list = Board.all
    @board = Board.find(params[:id])
    @board_nodes = @board.nodes.all
    # Пагинация, аттеншн - располагание тредов по убыванию даты последнего коммента происходит здесь,
    # поэтому нефиг пирать реверс в board/show
    @nodes = @board.nodes.paginate(:page => params[:page], :per_page => $nodes_per_page, :order => 'last_comment DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @board }
    end
  end

  # GET /boards/new
  # GET /boards/new.json
  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(params[:board])

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, :notice => 'Board was successfully created.' }
        format.json { render :json => @board, :status => :created, :location => @board }
      else
        format.html { render :action => "new" }
        format.json { render :json => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.json
  def update
    @board = Board.find(params[:id])

    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.html { redirect_to @board, :notice => 'Board was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :ok }
    end
  end
end

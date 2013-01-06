class NodesController < ApplicationController  
  # GET /nodes
  # GET /nodes.json

  attr_accessor :board_list

  def index
    @nodes = Node.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @nodes }
    end
  end
  
  # GET /nodes/1
  # GET /nodes/1.json
  def show
    @board_list = Board.all
    @node = Node.find(params[:id])
    #@node = Node.find_by_number(params[:id], params[:board_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @node }
    end
  end

  # GET /nodes/new
  # GET /nodes/new.json
  def new
    @node = Node.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    #@node = Node.find_by_number(params[:id], params[:board_id])
    @node = Node.find(params[:id])
  end

  # POST /nodes
  # POST /nodes.json
  def create
    respond_to do |format|
      
      @board = Board.find(params[:board_id])
      @node = @board.nodes.create(params[:node])
      if @node.save
        format.html { redirect_to @node, :notice => 'Node was successfully created.' }
        format.json { render :json => @node, :status => :created, :location => @node }
      else
        # Пока такой костыль.
        format.html { redirect_to @board, :notice => 'There was some errors. Enter your message and choose a picture.' }
        format.json { render :json => @node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.json
  def update
    #@node = Node.find_by_number(params[:id], params[:board_id])
    @node = Node.find(params[:id])

    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to @node, :notice => 'Node was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    #@node = Node.find_by_number(params[:id], params[:board_id])
    @node = Node.find(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :ok }
    end
  end

  
end

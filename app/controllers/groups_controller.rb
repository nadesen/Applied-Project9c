class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
    @book = Book.new
  end

  def new
    @group = Group.new
    @book = Book.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      redirect_to group_path(@group), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def edit
    @group = Group.find(params[:id])
    redirect_to groups_path unless @group.owner == current_user
  end
  
  def update
    @group = Group.find(params[:id])
    redirect_to groups_path unless @group.owner == current_user
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'グループ情報を更新しました'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end

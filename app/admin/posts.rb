# frozen_string_literal: true

ActiveAdmin.register Post do
  includes :user
  scope_to :current_user, unless: -> { current_user.admin? }
  permit_params :title, :body, :views_count, :user_id

  batch_action :destroy, if: proc { current_user.admin? }, confirm: 'Are you sure you want to delete these posts?' do |ids|
    return unless current_user.admin?

    Post.where(id: ids).delete_all
    redirect_to collection_path
  end

  index do
    selectable_column
    id_column
    column :title
    column :body

    column :user do |post|
      "#{post.user.id} - #{post.user.email}"
    end

    column :views_count
    column :created_at
    column :updated_at
    actions
  end

  filter :title
  filter :body
  filter :views_count
  filter :user_id, as: :select, collection: proc { User.pluck(:email, :id) }, if: proc { current_user.admin? }
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :views_count
      f.input :user_id
    end

    f.actions
  end

  show do
    resource.increment!(:views_count)

    attributes_table do
      row :title
      row :body
      row :views_count
      row :user_id
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end
end

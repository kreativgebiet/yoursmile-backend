# encoding: utf-8
class Project < ApplicationRecord
  def upload_count
    uploads.count
  end
end

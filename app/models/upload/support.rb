class Upload::Support < ApplicationRecord
  belongs_to :project
  belongs_to :upload
end

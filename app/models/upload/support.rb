class Upload::Support < ApplicationRecord
  belongs_to :project, touch: true
  belongs_to :upload, touch: true
end

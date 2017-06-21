
class UploadService
  def initialize(params)
    @user = params[:user]
    @supported_projects = params[:supported_projects] || {}
    @upload_params = params[:upload]
  end

  def run
    @support_ids = create_supports
    create_upload
  end

  def create_supports
    @supported_projects.keys.map { |key|
      amount = @supported_projects[key]
      Upload::Support.create(amount: amount, project_id: key).id
    }
  end

  def create_upload
    Upload.create(actual_upload_params)
  end

  protected

  def actual_upload_params
    @upload_params.merge(
      support_ids: @support_ids,
      user: @user
    )
  end
end

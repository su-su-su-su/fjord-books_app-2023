# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports or /reports.json
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @reports = @user.reports
    else
      redirect_to root_path, alert: 'User not specified.'
    end
  end

  # GET /reports/1 or /reports/1.json
  def show
    @report = Report.find(params[:id])
    @user = @report.user
  end
  # GET /reports/new
  def new
    @report = Report.new
    @user = current_user
  end

  # GET /reports/1/edit
  def edit; end

  # POST /reports or /reports.json
  def create
    @report = current_user.reports.build(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to user_report_path(@report.user, @report), notice: 'Report was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to user_report_path(@report.user, @report), notice: 'Report was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to user_reports_url(@report.user), notice: 'Report was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :content)
  end
end

class AbuseReportsController < ApplicationController
    def create
        @article = Article.find(params[:abuse_report][:article_id])
        @abuse_report = @article.abuse_reports.create(abuse_report_params)
        redirect_to article_path(@article)
    end
    def index
        @abuse_reports = AbuseReport.where(article_id: 1)
    end
    def show
        @abuse_report = AbuseReport.find(params[:id])
    end
    def new
        @article = Article.find(params[:article_id])
    end
    private
        def abuse_report_params
            params.require(:abuse_report).permit(:reason, :body)
        end
end

class AbuseReportsController < ApplicationController
    def create
        @article = Article.find(1)
        @abuse_report = @article.abuse_reports.create(abuse_report_params)
        redirect_to article_path(@article)
    end
    def index
        @abuse_reports = AbuseReport.all
    end
    
    private
        def abuse_report_params
            params.require(:abuse_report).permit(:reason, :body)
        end
end

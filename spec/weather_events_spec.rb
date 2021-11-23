# frozen_string_literal: true

RSpec.describe 'Weather Data', type: :request do
  path = File.join(File.expand_path('..', __dir__), 'spec', 'helpers')
  files = %w[http00.txt http01.txt http02.txt http03.txt http04.txt http05.txt]
  cnt = 1

  files.each do |file|
    it "Tests all events of Test - #{cnt}" do
      data = File.open(File.join(path, file)).read

      data.each_line do |row|
        req = JSON.parse(row)
        url = 'http://localhost:3000'
        header = req['request']['header']
        body = req['request']['body']

        case req['request']['method']
        when 'GET'
          url += req['request']['url']
          get url, body
          body = JSON.parse(response.body)

          expect(response.status).to eq(req['response']['status_code'])
          next if req['response']['status_code'] == 404

          expect(body).to eq(req['response']['body'])

        when 'POST'
          url += req['request']['url']
          post(url, body)
          body = JSON.parse(response.body)
          expect(response.status).to eq(req['response']['status_code'])

        when 'DELETE'
          url += req['request']['url']
          delete(url, body)
          expect(response.status).to eq(req['response']['status_code'])

        when 'PUT'
          url += req['request']['url']
          put(url, body)
          body = JSON.parse(response.body)
          expect(response.status).to eq(req['response']['status_code'])
          expect(body).to eq(req['response']['body'])

        else
          # type code here
        end
      end
    end
    cnt += 1
  end
end

